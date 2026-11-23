import json
import re
import os

SWIFT_PATHS = {
    "atlas_data": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift",
    "atlas_view": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift",
    "crisis": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\EmergencyProtocolsView.swift",
    "consults": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\ERConsultsView.swift",
    "procedures": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgicalProceduresView.swift",
    "calculators": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgeryCalculatorsView.swift"
}

# ==========================================
# 1. PARSE SURGICAL ATLAS (106 PLATES)
# ==========================================
with open(SWIFT_PATHS["atlas_data"], "r", encoding="utf-8") as f:
    data_text = f.read()

with open(SWIFT_PATHS["atlas_view"], "r", encoding="utf-8") as f:
    view_text = f.read()

sec_c = data_text[data_text.find("public var callouts: [SurgicalCallout]"):data_text.find("public var steps: [ApproachSequentialStep]")]
sec_s = data_text[data_text.find("public var steps: [ApproachSequentialStep]"):data_text.find("public var catastrophicHazards: [String]")]
sec_h = data_text[data_text.find("public var catastrophicHazards: [String]")]

titles_map = {}
t_start = view_text.find("public var title: String {")
if t_start != -1:
    t_end = view_text.find("public var iconName: String {", t_start)
    t_sec = view_text[t_start:t_end] if t_end != -1 else view_text[t_start:]
    for m in re.finditer(r'case \.plate(\d+):\s*return "(.*?)"', t_sec):
        titles_map[m.group(1)] = m.group(2)

plates_data = []
for i in range(1, 107):
    p_str = f"{i:03d}"
    c_pattern = r"case \.plate" + p_str + r":(.*?)(?=\n\s*case|\n\s*default:|\Z)"
    c_match = re.search(c_pattern, sec_c, re.DOTALL)
    pins = []
    if c_match:
        callout_blocks = re.findall(r"SurgicalCallout\((.*?)\n\s*\)", c_match.group(1), re.DOTALL)
        for idx, cb in enumerate(callout_blocks):
            title_m = re.search(r'title:\s*"(.*?)"', cb)
            type_m = re.search(r'structureType:\s*"(.*?)"', cb)
            color_m = re.search(r'color:\s*(.*?)[,\n]', cb)
            x_m = re.search(r'normalizedX:\s*([0-9.]+)', cb)
            y_m = re.search(r'normalizedY:\s*([0-9.]+)', cb)
            desc_m = re.search(r'description:\s*"(.*?)"', cb)
            pearl_m = re.search(r'surgicalPearl:\s*"(.*?)"', cb)

            pins.append({
                "id": f"pin_{p_str}_{idx+1}",
                "num": idx + 1,
                "title": title_m.group(1) if title_m else "Landmark",
                "structureType": type_m.group(1) if type_m else "ANATOMICAL LANDMARK",
                "color": color_m.group(1).replace("ObsidianTheme.", "").replace("Color.", "").strip() if color_m else "neonAmber",
                "x": float(x_m.group(1)) if x_m else 0.5,
                "y": float(y_m.group(1)) if y_m else 0.5,
                "description": desc_m.group(1) if desc_m else "",
                "surgicalPearl": pearl_m.group(1) if pearl_m else ""
            })

    s_match = re.search(c_pattern, sec_s, re.DOTALL)
    steps = []
    if s_match:
        step_blocks = re.findall(r"ApproachSequentialStep\((.*?)\)", s_match.group(1), re.DOTALL)
        for sb in step_blocks:
            num_m = re.search(r"stepNumber:\s*(\d+)", sb)
            stitle_m = re.search(r'title:\s*"(.*?)"', sb)
            detail_m = re.search(r'detail:\s*"(.*?)"', sb)
            steps.append({
                "step": int(num_m.group(1)) if num_m else len(steps)+1,
                "title": stitle_m.group(1) if stitle_m else "",
                "detail": detail_m.group(1) if detail_m else ""
            })

    h_match = re.search(c_pattern, sec_h, re.DOTALL)
    hazards = []
    if h_match:
        h_strings = re.findall(r'"(.*?)"', h_match.group(1))
        hazards = [h.strip() for h in h_strings if h.strip()]

    plate_title = titles_map.get(p_str, f"Plate {p_str}")

    batch_tag = "Catalog Core"
    if 1 <= i <= 25:
        batch_tag = "Dr. Mohit Calibrated (001-025)"
    elif 26 <= i <= 46:
        batch_tag = "Reviewed 026-046"
    elif 47 <= i <= 106:
        batch_tag = "Reviewed 047-106"

    plates_data.append({
        "plate_num": p_str,
        "title": plate_title,
        "batch_tag": batch_tag,
        "image_file": f"/plates/plate_{p_str}.jpg",
        "pins": pins,
        "steps": steps,
        "hazards": hazards
    })

# ==========================================
# 2. PARSE 2 AM CRISIS
# ==========================================
with open(SWIFT_PATHS["crisis"], "r", encoding="utf-8") as f:
    em_text = f.read()

start_ts = em_text.find("var thresholdSpec: EmergencyThresholdSpec")
end_ts = em_text.find("default:", start_ts) if start_ts != -1 else len(em_text)
ts_sec = em_text[start_ts:end_ts]

threshold_specs = []
crisis_cases = [
    ("EDH", "plate_ct_edh.jpg", "Epidural Hematoma (EDH)"),
    ("SDH", "plate_ct_sdh.jpg", "Acute Subdural Hematoma (SDH)"),
    ("Uncal", "plate_ct_uncal.jpg", "Acute Uncal Herniation"),
    ("Posterior Fossa", "plate_ct_post_fossa.jpg", "Posterior Fossa Cerebellar ICH")
]

for case_name, img, default_t in crisis_cases:
    c_idx = ts_sec.find(f'case "{case_name}":')
    if c_idx != -1:
        ret_idx = ts_sec.find("return EmergencyThresholdSpec(", c_idx)
        open_p = 0
        p_start = ret_idx + len("return EmergencyThresholdSpec")
        body_end = -1
        for i in range(p_start, len(ts_sec)):
            if ts_sec[i] == '(':
                open_p += 1
            elif ts_sec[i] == ')':
                open_p -= 1
                if open_p == 0:
                    body_end = i
                    break
        body = ts_sec[p_start+1:body_end] if body_end != -1 else ""
        def get_field(fname):
            m = re.search(rf'{fname}:\s*"(.*?)"', body, re.DOTALL)
            return m.group(1).strip() if m else ""

        threshold_specs.append({
            "id": case_name,
            "title": get_field("title") or default_t,
            "thicknessThreshold": get_field("thicknessThreshold"),
            "shiftThreshold": get_field("shiftThreshold"),
            "volumeThreshold": get_field("volumeThreshold"),
            "neurologicalTrigger": get_field("neurologicalTrigger"),
            "operativeProcedure": get_field("operativeProcedure"),
            "image_file": f"/plates/{img}"
        })

crisis_checklists = [
    {
        "id": "pupil_herniation",
        "title": "Herniation Resuscitation & Pupillary Asymmetry Protocol",
        "image_file": "/plates/plate_herniation_pupils.jpg",
        "steps": [
            "Immediately elevate head of bed to 30 degrees (promotes venous drainage)",
            "Push Mannitol (1 g/kg IV bolus) or 3% Hypertonic Saline (250-500 mL bolus over 15 min)",
            "Brief hyperventilation to PaCO2 30-35 mmHg as temporary bridge to OR only",
            "Obtain urgent non-contrast Head CT or mobilize OR team directly if known lesion",
            "Emergency bedside ventriculostomy (EVD) or decompressive hemicraniectomy"
        ]
    }
]

reversals = [
    {
        "drug": "Warfarin (Coumadin)",
        "mechanism": "Vitamin K Antagonist (Factors II, VII, IX, X)",
        "agent": "4-Factor PCC (Kcentra) + Vitamin K 10mg IV",
        "dose": "25-50 units/kg based on baseline INR",
        "target": "Target INR ≤ 1.3 within 30 minutes",
        "badgeColor": "red"
    },
    {
        "drug": "Apixaban / Rivaroxaban (DOAC)",
        "mechanism": "Direct Factor Xa Inhibitor",
        "agent": "Andexanet Alfa (Andexxa) or 4F-PCC",
        "dose": "High Dose: 800mg bolus + 8mg/min OR 4F-PCC 50 U/kg",
        "target": "Immediate cessation of Factor Xa inhibition",
        "badgeColor": "amber"
    },
    {
        "drug": "Dabigatran (Pradaxa)",
        "mechanism": "Direct Thrombin Inhibitor",
        "agent": "Idarucizumab (Praxbind)",
        "dose": "5 g IV (two consecutive 2.5 g vials)",
        "target": "Complete reversal of thrombin time in 15 min",
        "badgeColor": "purple"
    },
    {
        "drug": "Aspirin / Clopidogrel (Plavix)",
        "mechanism": "Antiplatelet / P2Y12 Inhibitor",
        "agent": "Platelet Transfusion + DDAVP",
        "dose": "1-2 Single Donor Apheresis Units + DDAVP 0.3 mcg/kg IV",
        "target": "Restore primary platelet plug aggregation",
        "badgeColor": "cyan"
    }
]

# ==========================================
# 3. PARSE ER CONSULTS
# ==========================================
with open(SWIFT_PATHS["consults"], "r", encoding="utf-8") as f:
    cs_text = f.read()

cranial_start = cs_text.find("enum CranialConsultType")
spine_start = cs_text.find("enum SpineConsultType")
end_spine = cs_text.find("// MARK: - Odontoid Quick-Triage Decision Matrix", spine_start)

def parse_consult_enum(enum_text, category_name):
    cases = []
    for m in re.finditer(r'case\s+(\w+)\s*=\s*"([^"]+)"', enum_text):
        cases.append((m.group(1), m.group(2)))
    
    results = []
    for case_id, raw_val in cases:
        def get_string_prop(prop_name):
            p_start = enum_text.find(f"public var {prop_name}: String")
            if p_start == -1: return ""
            p_end = enum_text.find("public var ", p_start + 15)
            if p_end == -1: p_end = len(enum_text)
            sec = enum_text[p_start:p_end]
            m = re.search(rf'case\s+\.{case_id}:\s*return\s*"((?:[^"\\]|\\.)*)"', sec, re.DOTALL)
            return m.group(1).replace('\\"', '"').replace('\\\\', '\\') if m else ""

        def get_array_prop(prop_name):
            p_start = enum_text.find(f"public var {prop_name}: [String]")
            if p_start == -1: return []
            p_end = enum_text.find("public var ", p_start + 15)
            if p_end == -1: p_end = len(enum_text)
            sec = enum_text[p_start:p_end]
            m = re.search(rf'case\s+\.{case_id}:\s*return\s*\[(.*?)\]', sec, re.DOTALL)
            if not m: return []
            return [s.strip().strip('"').replace('\\"', '"') for s in re.findall(r'"((?:[^"\\]|\\.)*)"', m.group(1))]

        img = get_string_prop("assetImageName")
        results.append({
            "category": category_name,
            "case": case_id,
            "id": raw_val,
            "shortTitle": get_string_prop("shortTitle"),
            "title": get_string_prop("title"),
            "assetImageName": img,
            "image_file": f"/plates/{img}.jpg",
            "acuityLabel": get_string_prop("acuityLabel"),
            "imagingPearl": get_string_prop("imagingPearl"),
            "operativePlan": get_string_prop("operativePlan"),
            "clinicalTriad": get_array_prop("clinicalTriad"),
            "pitfalls": get_array_prop("pitfalls")
        })
    return results

cranial_consults = parse_consult_enum(cs_text[cranial_start:spine_start], "cranial")
spine_consults = parse_consult_enum(cs_text[spine_start:end_spine], "spine")
consults_data = cranial_consults + spine_consults

# ==========================================
# 4. PARSE BEDSIDE HARDWARE & PROCEDURES
# ==========================================
with open(SWIFT_PATHS["procedures"], "r", encoding="utf-8") as f:
    pr_text = f.read()

procedure_defs = [
    {
        "id": "evd",
        "title": "Kocher's Point Ventriculostomy (EVD)",
        "card_name": "EVDDetailCard",
        "image_file": "/plates/plate_bedside_evd.jpg",
        "summary": "Frontal burr hole entry for ICP monitoring and acute CSF diversion.",
        "steps": [
            {"number": "1", "title": "Burr Hole Entry", "detail": "**1 cm anterior to coronal suture**, **2.5 - 3.0 cm lateral to sagittal midline** (mid-pupillary line)."},
            {"number": "2", "title": "Coronal Plane Target", "detail": "Aimed strictly toward the **Ipsilateral Medial Canthus** (inner eye corner)."},
            {"number": "3", "title": "Sagittal Plane Target", "detail": "Perpendicular to skull curvature, aimed toward the **External Auditory Meatus (Tragus)**."},
            {"number": "4", "title": "Depth Warning Limit", "detail": "CSF flash typically at **4.5 - 5.0 cm** (Foramen of Monro). **NEVER advance beyond 6.0 cm** from outer skull cortex!"}
        ]
    },
    {
        "id": "camino_bolt",
        "title": "Camino Bolt Placement & ICP Waveform Atlas",
        "card_name": "CaminoBoltDetailCard",
        "image_file": "/plates/plate_bedside_camino_bolt.jpg",
        "summary": "Parenchymal microtransducer sensor insertion and Lundberg wave interpretation.",
        "steps": [
            {"number": "1", "title": "Twist Drill Safety Collar", "detail": "Drill perpendicular to skull at Kocher's point with safety drill collar set to **1.0 cm**."},
            {"number": "2", "title": "Dural Perforation & Bolt Fixation", "detail": "Perforate dura with 18G needle; screw skull bolt snugly into cranial bone until flush."},
            {"number": "3", "title": "Transducer Insertion & Zeroing", "detail": "Advance fiberoptic probe **1.5 to 2.0 cm into white matter**; zero sensor prior to parenchymal insertion per protocol."}
        ]
    },
    {
        "id": "lumbar_puncture",
        "title": "Lumbar Puncture (LP) Anatomy & Manometry",
        "card_name": "LumbarPunctureDetailCard",
        "image_file": "/plates/plate_bedside_lumbar_puncture.jpg",
        "summary": "Diagnostic CSF sampling, opening pressure manometry, and cauda equina avoidance.",
        "steps": [
            {"number": "1", "title": "Interspace Localization", "detail": "Palpate superior iliac crests (Tuffier's line) identifying **L4 spinous process**. Target L3-L4 or L4-L5 interspace."},
            {"number": "2", "title": "Needle Trajectory & Bevel", "detail": "Aim 20G or 22G Quincke needle **10-15 degrees cephalad** toward umbilicus with bevel parallel to dural longitudinal fibers."},
            {"number": "3", "title": "Opening Pressure Manometry", "detail": "Legs must be **relaxed / straightened** before reading manometer. Normal: 10 - 20 cm H2O. Abnormal > 25 cm H2O."}
        ]
    },
    {
        "id": "lumbar_drain",
        "title": "Continuous Lumbar Drain Management",
        "card_name": "LumbarDrainDetailCard",
        "image_file": "/plates/plate_bedside_lumbar_drain.jpg",
        "summary": "Subarachnoid diversion for postop CSF fistula, skull base repair, or aneurysm surgery.",
        "steps": [
            {"number": "1", "title": "Tuohy Needle Entry", "detail": "14G Tuohy curved-tip needle entered at **L3-L4** with curve oriented cephalad into the subarachnoid space."},
            {"number": "2", "title": "Catheter Insertion", "detail": "Thread subarachnoid catheter **8 - 10 cm beyond needle tip**. Withdraw needle while holding catheter firmly."},
            {"number": "3", "title": "Target Hourly Drainage", "detail": "Maintain rate at **5 - 10 mL/hr** (never exceed 15-20 mL/hr) to avoid catastrophic downward transtentorial sag."}
        ]
    },
    {
        "id": "art_line",
        "title": "Radial Arterial Line Cannulation",
        "card_name": "RadialArterialLineDetailCard",
        "image_file": "/plates/plate_bedside_art_line.jpg",
        "summary": "Continuous beat-to-beat hemodynamic monitoring and CPP calculation.",
        "steps": [
            {"number": "1", "title": "Wrist Positioning & Collateral Flow", "detail": "Dorsiflex wrist 30-45 degrees with roll underneath. Palpate radial pulse proximal to flexor crease."},
            {"number": "2", "title": "Modified Seldinger / Angiocath", "detail": "Enter skin at **30-45 degree angle**. Upon bright pulsatile flash, lower angle to 10-15 degrees and advance wire."},
            {"number": "3", "title": "Transducer Leveling & Phlebostatic Axis", "detail": "Level pressure transducer to the **Phlebostatic Axis** (4th intercostal space, mid-axillary line) or Foramen of Monro for CPP."}
        ]
    },
    {
        "id": "cvc_line",
        "title": "Ultrasound-Guided Right IJV Central Line",
        "card_name": "InternalJugularCVCDetailCard",
        "image_file": "/plates/plate_bedside_cvc_line.jpg",
        "summary": "Vascular access for vasoactive infusions and hypertonic saline delivery.",
        "steps": [
            {"number": "1", "title": "Sedillot's Triangle & Probe Placement", "detail": "Between sternal and clavicular heads of SCM. Place high-frequency vascular probe transversely."},
            {"number": "2", "title": "Vein vs Artery Confirmation", "detail": "IJV is compressible, non-pulsatile, and expands with Trendelenburg. Carotid artery is round, thick-walled, pulsatile."},
            {"number": "3", "title": "Seldinger Technique & Wire Control", "detail": "Direct needle under direct real-time ultrasound guidance into center of vein. Confirm venous dark flash, advance J-wire without resistance."}
        ]
    }
]

# ==========================================
# 5. PARSE CALCULATORS
# ==========================================
calculators_data = [
    {
        "id": "cpp",
        "title": "CPP & Cerebral Hemodynamics",
        "formula": "CPP = Mean Arterial Pressure (MAP) - Intracranial Pressure (ICP)",
        "target": "BTF Target: 60 - 70 mmHg",
        "evidence": "Brain Trauma Foundation (BTF) Guidelines 4th Edition"
    },
    {
        "id": "ich",
        "title": "Hemphill ICH Score & 30-Day Mortality",
        "formula": "GCS (3-4: 2 pts, 5-12: 1 pt) + ICH Volume >30 cc (1 pt) + IVH (1 pt) + Infratentorial (1 pt) + Age ≥80 (1 pt)",
        "target": "Score 0: 0% mortality | Score 1: 13% | Score 2: 26% | Score 3: 72% | Score 4: 97% | Score 5-6: 100%",
        "evidence": "Hemphill JC et al. Stroke. 2001;32(4):891-897"
    },
    {
        "id": "sah",
        "title": "Aneurysmal SAH: Hunt-Hess & Modified Fisher",
        "formula": "Hunt-Hess Grade (1-5) clinical severity + Modified Fisher Grade (0-4) vasospasm risk",
        "target": "Fisher 3 (thick cisternal clot): Highest symptomatic vasospasm & DCI risk (>40%)",
        "evidence": "Hunt WE, Hess RM 1968; Claassen J et al. Stroke 2001"
    },
    {
        "id": "avm",
        "title": "Spetzler-Martin AVM Grading System",
        "formula": "Size (<3cm: 1, 3-6cm: 2, >6cm: 3) + Eloquence (Non-eloquent: 0, Eloquent: 1) + Venous Drainage (Superficial: 0, Deep: 1)",
        "target": "Grade I-II: Microsurgical resection | Grade III: Multimodal (Embo/SRS/Surgery) | Grade IV-V: Typically conservative",
        "evidence": "Spetzler RF, Martin NA. J Neurosurg. 1986;65(4):476-483"
    },
    {
        "id": "tlics",
        "title": "TLICS Thoracolumbar Spine Injury Score",
        "formula": "Morphology (Compression: 1, Burst: 2, Distraction: 3, Rotation/Translation: 4) + PLC Integrity (Intact: 0, Suspected: 2, Disrupted: 3) + Neurological Status (Intact: 0, Root: 2, Complete SCI: 2, Incomplete SCI: 3, Cauda Equina: 3)",
        "target": "Score ≤3: Non-operative | Score 4: Surgeon's discretion | Score ≥5: Operative stabilization",
        "evidence": "Vaccaro AR et al. Spine. 2005;30(20):2325-2333"
    },
    {
        "id": "slic",
        "title": "SLIC Subaxial Cervical Spine Injury Score",
        "formula": "Morphology (No abnormality: 0, Compression: 1, Burst: 2, Distraction: 3, Translation/Rotation: 4) + DLC Integrity (Intact: 0, Indeterminate: 1, Disrupted: 2) + Neurological Status (Intact: 0, Root: 1, Complete SCI: 2, Incomplete SCI: 3)",
        "target": "Score ≤3: Conservative / Rigid Collar | Score 4: Equivocal | Score ≥5: Surgical reduction & stabilization",
        "evidence": "Vaccaro AR et al. Spine. 2007;32(21):2365-2374"
    },
    {
        "id": "sins",
        "title": "Spine Instability Neoplastic Score (SINS)",
        "formula": "Location (1-3) + Mechanical Pain (0-3) + Bone Lesion (1-3) + Radiographic Alignment (0-4) + Body Collapse (0-3) + Posterolateral Elements (0-3)",
        "target": "Score 0-6: Stable | Score 7-12: Potentially unstable (Surgical consult recommended) | Score 13-18: Instability (Surgical stabilization mandatory)",
        "evidence": "Fisher CG et al. Spine. 2010;35(19):E1221-E1229"
    },
    {
        "id": "osmo",
        "title": "Osmotherapy & Sodium Dosing Optimizer",
        "formula": "Free Water Deficit = Total Body Water × [(Serum Na / 140) - 1] | 3% NaCl Infusion rate = 1-2 mL/kg/hr",
        "target": "Target Serum Na: 145 - 155 mEq/L | Target Serum Osmolality: 300 - 320 mOsm/kg",
        "evidence": "Neurocritical Care Society (NCS) Refractory ICP Osmotherapy Guidelines"
    }
]

app_store = {
    "atlas": plates_data,
    "crisis": {
        "thresholds": threshold_specs,
        "checklists": crisis_checklists,
        "reversals": reversals
    },
    "consults": consults_data,
    "procedures": procedure_defs,
    "calculators": calculators_data
}

app_json = json.dumps(app_store, indent=2)

html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NeuroCall Full App Studio — Interactive Local Visual Inspector & Code Editor</title>
<style>
  :root {{
    --bg-dark: #07090e;
    --card-bg: #0f141c;
    --border-color: #1e2638;
    --text-primary: #f8fafc;
    --text-secondary: #94a3b8;
    --accent-amber: #f59e0b;
    --accent-cyan: #00e5ff;
    --accent-rose: #f43f5e;
    --accent-green: #10b981;
    --accent-purple: #a855f7;
  }}
  * {{ box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }}
  body {{ background: var(--bg-dark); color: var(--text-primary); padding: 16px; }}
  header {{
    max-width: 1540px; margin: 0 auto 16px auto;
    background: #0d121d; border: 1px solid var(--border-color); border-radius: 14px; padding: 16px 20px;
    display: flex; flex-direction: column; gap: 14px;
  }}
  .header-top {{ display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px; }}
  h1 {{ font-size: 20px; font-weight: 800; color: #fff; display: flex; align-items: center; gap: 8px; }}
  .header-desc {{ font-size: 12px; color: var(--text-secondary); }}
  
  /* Pillar Navigation Tabs */
  .pillar-tabs {{ display: flex; gap: 10px; flex-wrap: wrap; border-top: 1px solid #1e2638; padding-top: 12px; }}
  .tab-btn {{
    background: #141b27; border: 1px solid #253047; border-radius: 10px;
    padding: 10px 16px; color: #94a3b8; font-size: 13px; font-weight: 800; cursor: pointer; transition: 0.15s;
    display: flex; align-items: center; gap: 8px;
  }}
  .tab-btn:hover {{ background: #1e293b; color: #fff; }}
  .tab-btn.active {{ background: var(--accent-cyan); color: #000; border-color: var(--accent-cyan); box-shadow: 0 0 12px rgba(0,229,255,0.4); }}
  
  .section-container {{ display: none; max-width: 1540px; margin: 0 auto; }}
  .section-container.active {{ display: flex; flex-direction: column; gap: 20px; }}

  /* Cards & Controls */
  .grid-2col {{ display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }}
  @media (max-width: 1100px) {{ .grid-2col {{ grid-template-columns: 1fr; }} }}
  .studio-card {{
    background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 14px;
    padding: 18px; display: flex; flex-direction: column; gap: 14px;
  }}
  .card-header {{ display: flex; justify-content: space-between; align-items: flex-start; gap: 10px; }}
  .card-title {{ font-size: 15px; font-weight: 800; color: #fff; }}
  .badge {{
    font-size: 10px; font-weight: 800; text-transform: uppercase; padding: 4px 8px; border-radius: 6px;
    letter-spacing: 0.5px;
  }}
  .badge-red {{ background: rgba(244,63,94,0.15); color: var(--accent-rose); border: 1px solid rgba(244,63,94,0.3); }}
  .badge-cyan {{ background: rgba(0,229,255,0.15); color: var(--accent-cyan); border: 1px solid rgba(0,229,255,0.3); }}
  .badge-amber {{ background: rgba(245,158,11,0.15); color: var(--accent-amber); border: 1px solid rgba(245,158,11,0.3); }}
  .badge-purple {{ background: rgba(168,85,247,0.15); color: var(--accent-purple); border: 1px solid rgba(168,85,247,0.3); }}

  /* Side-by-side Image + Form Grid */
  .media-card-grid {{ display: grid; grid-template-columns: 340px 1fr; gap: 18px; }}
  @media (max-width: 950px) {{ .media-card-grid {{ grid-template-columns: 1fr; }} }}
  
  .viewport-container {{
    position: relative; background: #000; border: 1px solid var(--border-color);
    border-radius: 10px; overflow: hidden; display: flex; flex-direction: column; align-items: center; justify-content: center;
  }}
  .viewport-container img {{
    width: 100%; max-height: 380px; object-fit: contain; display: block; background: #05070a; cursor: zoom-in;
    transition: transform 0.2s ease;
  }}
  .viewport-container img:hover {{ transform: scale(1.02); }}
  .viewport-caption {{
    width: 100%; padding: 6px 10px; background: rgba(10,14,23,0.9); font-size: 11px;
    font-weight: 700; color: #94a3b8; text-align: center; border-top: 1px solid #1a2233;
  }}

  /* Fields */
  .field-label {{ font-size: 11px; font-weight: 700; color: #94a3b8; text-transform: uppercase; margin-bottom: 4px; }}
  .edit-input, .edit-textarea {{
    width: 100%; background: #080c14; border: 1px solid #232c40; border-radius: 8px;
    padding: 8px 10px; color: #fff; font-size: 13px; font-weight: 500; transition: border 0.15s;
  }}
  .edit-input:focus, .edit-textarea:focus {{ border-color: var(--accent-cyan); outline: none; }}
  .edit-textarea {{ min-height: 60px; resize: vertical; line-height: 1.4; }}

  .save-btn {{
    background: #0284c7; color: #fff; border: none; border-radius: 8px;
    padding: 10px 16px; font-size: 12px; font-weight: 800; cursor: pointer; transition: 0.15s;
    display: inline-flex; align-items: center; gap: 6px; width: fit-content;
  }}
  .save-btn:hover {{ background: #0369a1; }}
  .save-btn.saved {{ background: #10b981; }}

  /* Filter Toolbar */
  .filter-bar {{ display: flex; gap: 10px; flex-wrap: wrap; align-items: center; background: #0d121d; padding: 12px 16px; border-radius: 12px; border: 1px solid var(--border-color); }}
  .pill-filter {{
    background: #141b27; border: 1px solid #253047; border-radius: 8px;
    padding: 6px 12px; color: #94a3b8; font-size: 12px; font-weight: 700; cursor: pointer;
  }}
  .pill-filter.active {{ background: #253047; color: #fff; border-color: var(--accent-cyan); }}

  /* Toast Notification */
  #toast {{
    position: fixed; bottom: 24px; right: 24px; background: #10b981; color: #fff;
    padding: 12px 20px; border-radius: 10px; font-size: 13px; font-weight: 800;
    box-shadow: 0 4px 16px rgba(0,0,0,0.5); display: none; z-index: 9999;
  }}

  /* Atlas Specific (106 Plates with 15px Pins) */
  .atlas-card {{
    background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 14px;
    padding: 18px; display: grid; grid-template-columns: 520px 1fr; gap: 20px;
  }}
  @media (max-width: 1200px) {{ .atlas-card {{ grid-template-columns: 1fr; }} }}
  .plate-viewport {{
    position: relative; width: 100%; border-radius: 10px; overflow: hidden; background: #000;
    aspect-ratio: 1 / 1; border: 1px solid #253047; user-select: none;
  }}
  .plate-viewport img {{ width: 100%; height: 100%; object-fit: contain; pointer-events: none; }}
  .pin-marker {{
    position: absolute; width: 15px; height: 15px; border-radius: 50%;
    transform: translate(-50%, -50%); border: 1.5px solid #fff; box-shadow: 0 0 8px rgba(0,0,0,0.8);
    cursor: grab; display: flex; align-items: center; justify-content: center;
    font-size: 8px; font-weight: 900; color: #fff; text-shadow: 0 0 2px #000;
  }}
  .pin-marker:active {{ cursor: grabbing; transform: translate(-50%, -50%) scale(1.2); }}
</style>
</head>
<body>

<div id="toast">Changes Saved!</div>

<header>
  <div class="header-top">
    <div>
      <h1>🧠 NeuroCall Full App Studio</h1>
      <div class="header-desc">Dr. Mohit: Live visual inspection and two-way code editing across all 5 clinical pillars. All changes write directly to Swift codebase.</div>
    </div>
  </div>

  <div class="pillar-tabs">
    <button class="tab-btn active" onclick="switchPillar('atlas')">📖 1. Surgical Atlas (106 Plates)</button>
    <button class="tab-btn" onclick="switchPillar('crisis')">🚨 2. 2 AM Crisis & ICP Ladders</button>
    <button class="tab-btn" onclick="switchPillar('consults')">🩺 3. Frontline ER Consults (16 Modules)</button>
    <button class="tab-btn" onclick="switchPillar('procedures')">🎯 4. Bedside Hardware & Trajectories</button>
    <button class="tab-btn" onclick="switchPillar('calculators')">🔢 5. Calculators & Scoring</button>
  </div>
</header>

<!-- ========================================== -->
<!-- 1. SURGICAL ATLAS (106 PLATES)             -->
<!-- ========================================== -->
<div id="pillar-atlas" class="section-container active">
  <div class="filter-bar">
    <input type="text" id="atlasSearch" class="edit-input" style="max-width: 320px;" placeholder="Search 106 plates by title or plate number..." oninput="renderAtlas()">
    <span style="font-size:12px; color:#64748b;">💡 Drag any numbered circle on the canvas to reposition. 15px markers ensure zero anatomical obscuration.</span>
  </div>
  <div id="atlasList" style="display:flex; flex-direction:column; gap:20px;"></div>
</div>

<!-- ========================================== -->
<!-- 2. 2 AM CRISIS & ICP LADDERS               -->
<!-- ========================================== -->
<div id="pillar-crisis" class="section-container">
  <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:16px;">
    <h2 style="font-size:16px; font-weight:800; color:#fff;">2 AM Crisis Cockpit & Operative Thresholds</h2>
    <div style="font-size:12px; color:#94a3b8; margin-top:4px;">BTF Emergency Specifications, High-Contrast CT Plates, Herniation Resuscitation, and Reversal Cockpit</div>
  </div>

  <div id="crisisThresholdGrid" class="grid-2col"></div>

  <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:16px; margin-top:10px;">
    <h3 style="font-size:15px; font-weight:800; color:#fff;">Acute Herniation Resuscitation & Pupillary Asymmetry</h3>
  </div>
  <div id="crisisChecklistGrid"></div>

  <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:16px; margin-top:10px;">
    <h3 style="font-size:15px; font-weight:800; color:#fff;">Anticoagulation Rapid Reversal Cockpit</h3>
  </div>
  <div id="crisisReversalGrid" class="grid-2col"></div>
</div>

<!-- ========================================== -->
<!-- 3. FRONTLINE ER CONSULTS                   -->
<!-- ========================================== -->
<div id="pillar-consults" class="section-container">
  <div class="filter-bar">
    <button class="pill-filter active" id="filter-all" onclick="filterConsults('all')">All Modules (13)</button>
    <button class="pill-filter" id="filter-cranial" onclick="filterConsults('cranial')">Cranial (7)</button>
    <button class="pill-filter" id="filter-spine" onclick="filterConsults('spine')">Spine (6)</button>
    <input type="text" id="consultSearch" class="edit-input" style="max-width: 280px; margin-left:auto;" placeholder="Search consults or keywords..." oninput="renderConsults()">
  </div>
  <div id="consultsGrid" style="display:flex; flex-direction:column; gap:20px;"></div>
</div>

<!-- ========================================== -->
<!-- 4. BEDSIDE HARDWARE & TRAJECTORIES         -->
<!-- ========================================== -->
<div id="pillar-procedures" class="section-container">
  <div class="filter-bar">
    <button class="pill-filter active" id="filter-proc-all" onclick="filterProcedures('all')">All Procedures (6)</button>
    <button class="pill-filter" id="filter-proc-evd" onclick="filterProcedures('evd')">Kocher's EVD</button>
    <button class="pill-filter" id="filter-proc-camino" onclick="filterProcedures('camino_bolt')">Camino Bolt</button>
    <button class="pill-filter" id="filter-proc-lp" onclick="filterProcedures('lumbar_puncture')">Lumbar Puncture</button>
    <button class="pill-filter" id="filter-proc-drain" onclick="filterProcedures('lumbar_drain')">Lumbar Drain</button>
    <button class="pill-filter" id="filter-proc-art" onclick="filterProcedures('art_line')">Radial Art Line</button>
    <button class="pill-filter" id="filter-proc-cvc" onclick="filterProcedures('cvc_line')">Ultrasound CVC</button>
  </div>
  <div id="proceduresGrid" style="display:flex; flex-direction:column; gap:20px;"></div>
</div>

<!-- ========================================== -->
<!-- 5. CALCULATORS & SCORING                   -->
<!-- ========================================== -->
<div id="pillar-calculators" class="section-container">
  <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:16px;">
    <h2 style="font-size:16px; font-weight:800; color:#fff;">Neurosurgical Calculators & Clinical Scoring Engines</h2>
    <div style="font-size:12px; color:#94a3b8; margin-top:4px;">Validated peer-reviewed formulas, point allocations, and clinical management cutoff thresholds.</div>
  </div>
  <div id="calculatorsGrid" class="grid-2col"></div>
</div>

<script>
const appData = {app_json};

function showToast(msg) {{
  const t = document.getElementById('toast');
  t.innerText = msg;
  t.style.display = 'block';
  setTimeout(() => {{ t.style.display = 'none'; }}, 2800);
}}

function switchPillar(pillarId) {{
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('.section-container').forEach(sec => sec.classList.remove('active'));

  event.currentTarget.classList.add('active');
  document.getElementById(`pillar-${{pillarId}}`).classList.add('active');
}}

// ==========================================
// 1. ATLAS RENDER
// ==========================================
function renderAtlas() {{
  const container = document.getElementById('atlasList');
  const search = document.getElementById('atlasSearch').value.toLowerCase();
  container.innerHTML = '';

  const filtered = appData.atlas.filter(p => {{
    return p.plate_num.includes(search) || p.title.toLowerCase().includes(search);
  }});

  filtered.forEach(p => {{
    const card = document.createElement('div');
    card.className = 'atlas-card';
    card.id = `atlas-card-${{p.plate_num}}`;

    const pinsHtml = p.pins.map((pin, idx) => `
      <div class="pin-marker" id="marker-${{p.plate_num}}-${{idx}}"
           style="left:${{pin.x * 100}}%; top:${{pin.y * 100}}%; background:${{getPinColor(pin.color)}};"
           title="${{pin.num}}: ${{pin.title}}">
        ${{pin.num}}
      </div>
    `).join('');

    const pinsRows = p.pins.map((pin, idx) => `
      <div style="background:#131a26; padding:8px 10px; border-radius:8px; border:1px solid #232c40; display:flex; flex-direction:column; gap:6px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <span style="font-weight:800; font-size:11px; color:#00e5ff;">PIN ${{pin.num}}</span>
          <span style="font-size:10px; color:#64748b;">X: <span id="pos-x-${{p.plate_num}}-${{idx}}">${{pin.x.toFixed(3)}}</span> | Y: <span id="pos-y-${{p.plate_num}}-${{idx}}">${{pin.y.toFixed(3)}}</span></span>
          <button style="background:none; border:none; color:#f43f5e; cursor:pointer; font-size:11px;" onclick="deletePin('${{p.plate_num}}', ${{idx}})">✕ Delete</button>
        </div>
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:6px;">
          <input type="text" class="edit-input" value="${{pin.title}}" placeholder="Structure Title" onchange="updatePin('${{p.plate_num}}', ${{idx}}, 'title', this.value)">
          <input type="text" class="edit-input" value="${{pin.structureType}}" placeholder="Structure Type" onchange="updatePin('${{p.plate_num}}', ${{idx}}, 'structureType', this.value)">
        </div>
        <textarea class="edit-textarea" placeholder="Surgical Pearl / Anatomical Details" onchange="updatePin('${{p.plate_num}}', ${{idx}}, 'surgicalPearl', this.value)">${{pin.surgicalPearl}}</textarea>
      </div>
    `).join('');

    const stepsRows = p.steps.map((st, idx) => `
      <div style="display:flex; gap:6px; align-items:center;">
        <span style="font-size:11px; font-weight:800; color:#94a3b8; width:45px;">Step ${{st.step}}:</span>
        <input type="text" class="edit-input" value="${{st.title}}" onchange="updateStep('${{p.plate_num}}', ${{idx}}, 'title', this.value)">
        <button style="background:none; border:none; color:#f43f5e; cursor:pointer;" onclick="deleteStep('${{p.plate_num}}', ${{idx}})">✕</button>
      </div>
    `).join('');

    const hazardsRows = p.hazards.map((hz, idx) => `
      <div style="display:flex; gap:6px; align-items:center;">
        <span style="font-size:11px; font-weight:800; color:#f43f5e;">⚠️</span>
        <input type="text" class="edit-input" value="${{hz}}" onchange="updateHazard('${{p.plate_num}}', ${{idx}}, this.value)">
        <button style="background:none; border:none; color:#f43f5e; cursor:pointer;" onclick="deleteHazard('${{p.plate_num}}', ${{idx}})">✕</button>
      </div>
    `).join('');

    card.innerHTML = `
      <div>
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
          <span style="font-weight:800; font-size:14px; color:#fff;">PLATE ${{p.plate_num}}</span>
          <span class="badge badge-amber">${{p.batch_tag}}</span>
        </div>
        <div class="plate-viewport" id="viewport-${{p.plate_num}}">
          <img src="${{p.image_file}}" alt="Plate ${{p.plate_num}}">
          ${{pinsHtml}}
        </div>
      </div>
      <div style="display:flex; flex-direction:column; gap:12px;">
        <div>
          <div class="field-label">Plate Title:</div>
          <input type="text" class="edit-input" value="${{p.title}}" style="font-size:15px; font-weight:800;" onchange="updatePlateTitle('${{p.plate_num}}', this.value)">
        </div>
        
        <div>
          <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
            <div class="field-label" style="margin:0;">Calibrated Landmarks (${{p.pins.length}}):</div>
            <button style="background:#1e293b; color:#00e5ff; border:1px solid #334155; padding:3px 8px; border-radius:6px; font-size:11px; cursor:pointer;" onclick="addPin('${{p.plate_num}}')">+ Add Pin</button>
          </div>
          <div style="display:flex; flex-direction:column; gap:8px; max-height:220px; overflow-y:auto; padding-right:4px;">
            ${{pinsRows}}
          </div>
        </div>

        <div>
          <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
            <div class="field-label" style="margin:0;">Dissection Sequence (${{p.steps.length}}):</div>
            <button style="background:#1e293b; color:#00e5ff; border:1px solid #334155; padding:3px 8px; border-radius:6px; font-size:11px; cursor:pointer;" onclick="addStep('${{p.plate_num}}')">+ Add Step</button>
          </div>
          <div style="display:flex; flex-direction:column; gap:6px;">
            ${{stepsRows || '<span style="font-size:11px; color:#64748b;">(Section hidden in app if blank)</span>'}}
          </div>
        </div>

        <div>
          <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
            <div class="field-label" style="margin:0;">Catastrophic Operative Hazards (${{p.hazards.length}}):</div>
            <button style="background:#1e293b; color:#f43f5e; border:1px solid #334155; padding:3px 8px; border-radius:6px; font-size:11px; cursor:pointer;" onclick="addHazard('${{p.plate_num}}')">+ Add Hazard</button>
          </div>
          <div style="display:flex; flex-direction:column; gap:6px;">
            ${{hazardsRows || '<span style="font-size:11px; color:#64748b;">(Section hidden in app if blank)</span>'}}
          </div>
        </div>

        <button class="save-btn" id="save-btn-${{p.plate_num}}" onclick="savePlateToSwift('${{p.plate_num}}')">
          💾 Save Plate to Swift
        </button>
      </div>
    `;

    container.appendChild(card);
    setupDragEvents(p.plate_num);
  }});
}}

function getPinColor(c) {{
  if (!c) return '#00e5ff';
  c = c.toLowerCase();
  if (c.includes('red') || c.includes('rose')) return '#f43f5e';
  if (c.includes('green') || c.includes('emerald')) return '#10b981';
  if (c.includes('blue') || c.includes('cyan')) return '#00e5ff';
  if (c.includes('orange') || c.includes('amber')) return '#f59e0b';
  if (c.includes('purple')) return '#a855f7';
  return '#00e5ff';
}}

function setupDragEvents(plateNum) {{
  const viewport = document.getElementById(`viewport-${{plateNum}}`);
  if (!viewport) return;

  const plateObj = appData.atlas.find(p => p.plate_num === plateNum);
  if (!plateObj) return;

  plateObj.pins.forEach((pin, idx) => {{
    const marker = document.getElementById(`marker-${{plateNum}}-${{idx}}`);
    if (!marker) return;

    let isDragging = false;

    marker.addEventListener('mousedown', (e) => {{
      isDragging = true;
      e.preventDefault();
      e.stopPropagation();

      const onMouseMove = (moveEvt) => {{
        if (!isDragging) return;
        const rect = viewport.getBoundingClientRect();
        let newX = (moveEvt.clientX - rect.left) / rect.width;
        let newY = (moveEvt.clientY - rect.top) / rect.height;

        newX = Math.max(0.01, Math.min(0.99, newX));
        newY = Math.max(0.01, Math.min(0.99, newY));

        pin.x = parseFloat(newX.toFixed(3));
        pin.y = parseFloat(newY.toFixed(3));

        marker.style.left = `${{pin.x * 100}}%`;
        marker.style.top = `${{pin.y * 100}}%`;

        const posXElem = document.getElementById(`pos-x-${{plateNum}}-${{idx}}`);
        const posYElem = document.getElementById(`pos-y-${{plateNum}}-${{idx}}`);
        if (posXElem) posXElem.innerText = pin.x.toFixed(3);
        if (posYElem) posYElem.innerText = pin.y.toFixed(3);
      }};

      const onMouseUp = () => {{
        isDragging = false;
        window.removeEventListener('mousemove', onMouseMove);
        window.removeEventListener('mouseup', onMouseUp);
      }};

      window.addEventListener('mousemove', onMouseMove);
      window.addEventListener('mouseup', onMouseUp);
    }});
  }});
}}

function updatePlateTitle(pNum, val) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) p.title = val;
}}

function updatePin(pNum, idx, field, val) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p && p.pins[idx]) p.pins[idx][field] = val;
}}

function deletePin(pNum, idx) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    p.pins.splice(idx, 1);
    p.pins.forEach((pin, i) => pin.num = i + 1);
    renderAtlas();
  }}
}}

function addPin(pNum) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    const newNum = p.pins.length + 1;
    p.pins.push({{
      id: `pin_${{pNum}}_${{newNum}}`,
      num: newNum,
      title: "New Anatomical Landmark",
      structureType: "ANATOMICAL LANDMARK",
      color: "neonCyan",
      x: 0.5,
      y: 0.5,
      description: "",
      surgicalPearl: ""
    }});
    renderAtlas();
  }}
}}

function updateStep(pNum, idx, field, val) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p && p.steps[idx]) p.steps[idx][field] = val;
}}

function deleteStep(pNum, idx) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    p.steps.splice(idx, 1);
    p.steps.forEach((st, i) => st.step = i + 1);
    renderAtlas();
  }}
}}

function addStep(pNum) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    p.steps.push({{
      step: p.steps.length + 1,
      title: "New Operative Step",
      detail: ""
    }});
    renderAtlas();
  }}
}}

function updateHazard(pNum, idx, val) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p && p.hazards[idx] !== undefined) p.hazards[idx] = val;
}}

function deleteHazard(pNum, idx) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    p.hazards.splice(idx, 1);
    renderAtlas();
  }}
}}

function addHazard(pNum) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (p) {{
    p.hazards.push("Catastrophic Pitfall: ");
    renderAtlas();
  }}
}}

async function savePlateToSwift(pNum) {{
  const p = appData.atlas.find(x => x.plate_num === pNum);
  if (!p) return;

  const btn = document.getElementById(`save-btn-${{pNum}}`);
  btn.innerText = "⏳ Saving...";

  try {{
    const res = await fetch("/api/save-plate", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{
        plate_num: pNum,
        title: p.title,
        pins: p.pins,
        steps: p.steps,
        hazards: p.hazards
      }})
    }});
    const data = await res.json();
    if (data.status === "ok") {{
      btn.innerText = "✓ Saved to Swift!";
      btn.classList.add("saved");
      showToast(`Plate ${{pNum}} saved directly to Swift codebase!`);
      setTimeout(() => {{
        btn.innerText = "💾 Save Plate to Swift";
        btn.classList.remove("saved");
      }}, 3000);
    }} else {{
      alert("Error saving: " + data.message);
      btn.innerText = "💾 Save Plate to Swift";
    }}
  }} catch (e) {{
    alert("Connection error: " + e);
    btn.innerText = "💾 Save Plate to Swift";
  }}
}}

// ==========================================
// 2. CRISIS RENDER
// ==========================================
function renderCrisis() {{
  const tGrid = document.getElementById('crisisThresholdGrid');
  tGrid.innerHTML = '';

  appData.crisis.thresholds.forEach((spec, idx) => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{spec.title}}</span>
        <span class="badge badge-red">BTF SURGICAL MANDATE</span>
      </div>
      <div class="media-card-grid">
        <div class="viewport-container">
          <img src="${{spec.image_file}}" alt="${{spec.title}}" title="Click to view full size">
          <div class="viewport-caption">High-Contrast Emergency CT Viewport</div>
        </div>
        <div style="display:flex; flex-direction:column; gap:10px;">
          <div>
            <div class="field-label">Emergency Protocol Title:</div>
            <input type="text" class="edit-input" value="${{spec.title}}" onchange="spec.title = this.value">
          </div>
          <div>
            <div class="field-label">Thickness Threshold:</div>
            <input type="text" class="edit-input" value="${{spec.thicknessThreshold}}" onchange="spec.thicknessThreshold = this.value">
          </div>
          <div>
            <div class="field-label">Midline Shift Threshold:</div>
            <input type="text" class="edit-input" value="${{spec.shiftThreshold}}" onchange="spec.shiftThreshold = this.value">
          </div>
          <div>
            <div class="field-label">Volume Threshold:</div>
            <input type="text" class="edit-input" value="${{spec.volumeThreshold}}" onchange="spec.volumeThreshold = this.value">
          </div>
          <div>
            <div class="field-label">Neurological Trigger:</div>
            <input type="text" class="edit-input" value="${{spec.neurologicalTrigger}}" onchange="spec.neurologicalTrigger = this.value">
          </div>
          <div>
            <div class="field-label">Operative Procedure:</div>
            <input type="text" class="edit-input" value="${{spec.operativeProcedure}}" onchange="spec.operativeProcedure = this.value">
          </div>
          <button class="save-btn" onclick="saveCrisisSpec('${{spec.id}}', ${{idx}})">💾 Save Spec to Swift</button>
        </div>
      </div>
    `;
    tGrid.appendChild(card);
  }});

  // Checklists (Herniation Pupils)
  const cGrid = document.getElementById('crisisChecklistGrid');
  cGrid.innerHTML = '';
  appData.crisis.checklists.forEach((cl, idx) => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    const stepsHtml = cl.steps.map((st, i) => `
      <div style="display:flex; gap:8px; align-items:center;">
        <span style="color:#00e5ff; font-weight:800;">${{i+1}}.</span>
        <input type="text" class="edit-input" value="${{st}}" onchange="cl.steps[${{i}}] = this.value">
      </div>
    `).join('');

    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{cl.title}}</span>
        <span class="badge badge-amber">CRITICAL RESUSCITATION</span>
      </div>
      <div class="media-card-grid">
        <div class="viewport-container">
          <img src="${{cl.image_file}}" alt="${{cl.title}}">
          <div class="viewport-caption">Pupillary Light Reflex & Herniation Anisocoria</div>
        </div>
        <div style="display:flex; flex-direction:column; gap:10px;">
          <div class="field-label">Resuscitation Stepwise Actions:</div>
          ${{stepsHtml}}
          <button class="save-btn" onclick="saveCrisisChecklist('${{cl.id}}', ${{idx}})">💾 Save Checklist to Swift</button>
        </div>
      </div>
    `;
    cGrid.appendChild(card);
  }});

  // Reversals
  const rGrid = document.getElementById('crisisReversalGrid');
  rGrid.innerHTML = '';
  appData.crisis.reversals.forEach(rev => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{rev.drug}}</span>
        <span class="badge badge-purple">${{rev.agent}}</span>
      </div>
      <div style="font-size:12px; color:#94a3b8;">${{rev.mechanism}}</div>
      <div style="background:#090d15; padding:10px; border-radius:8px; border:1px solid #1e2638; display:flex; flex-direction:column; gap:4px;">
        <div><strong style="color:#fff;">Dose:</strong> ${{rev.dose}}</div>
        <div><strong style="color:#00e5ff;">Target:</strong> ${{rev.target}}</div>
      </div>
    `;
    rGrid.appendChild(card);
  }});
}}

async function saveCrisisSpec(specId, idx) {{
  const spec = appData.crisis.thresholds[idx];
  try {{
    const res = await fetch("/api/save-crisis", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{ spec_id: specId, spec: spec }})
    }});
    const data = await res.json();
    if (data.status === "ok") showToast(`Crisis spec ${{spec.title}} saved to Swift!`);
    else alert("Error: " + data.message);
  }} catch (e) {{ alert("Connection error: " + e); }}
}}

async function saveCrisisChecklist(clId, idx) {{
  const cl = appData.crisis.checklists[idx];
  try {{
    const res = await fetch("/api/save-crisis", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{ checklists: [cl] }})
    }});
    const data = await res.json();
    if (data.status === "ok") showToast(`Herniation checklist saved to Swift!`);
    else alert("Error: " + data.message);
  }} catch (e) {{ alert("Connection error: " + e); }}
}}

// ==========================================
// 3. ER CONSULTS RENDER
// ==========================================
let currentConsultCategory = 'all';

function filterConsults(cat) {{
  currentConsultCategory = cat;
  document.getElementById('filter-all').classList.toggle('active', cat === 'all');
  document.getElementById('filter-cranial').classList.toggle('active', cat === 'cranial');
  document.getElementById('filter-spine').classList.toggle('active', cat === 'spine');
  renderConsults();
}}

function renderConsults() {{
  const grid = document.getElementById('consultsGrid');
  const search = document.getElementById('consultSearch').value.toLowerCase();
  grid.innerHTML = '';

  const filtered = appData.consults.filter(c => {{
    const matchCat = (currentConsultCategory === 'all') || (c.category === currentConsultCategory);
    const matchSearch = c.title.toLowerCase().includes(search) || c.case.toLowerCase().includes(search) || c.shortTitle.toLowerCase().includes(search);
    return matchCat && matchSearch;
  }});

  filtered.forEach(c => {{
    const card = document.createElement('div');
    card.className = 'studio-card';

    const pitfallsRows = c.pitfalls.map((pit, idx) => `
      <div style="display:flex; gap:6px; align-items:flex-start;">
        <span style="font-size:11px; font-weight:800; color:#f43f5e; margin-top:4px;">⚠️</span>
        <textarea class="edit-textarea" style="min-height:44px;" onchange="c.pitfalls[${{idx}}] = this.value">${{pit}}</textarea>
        <button style="background:none; border:none; color:#f43f5e; cursor:pointer; font-size:14px; margin-top:6px;" onclick="deleteConsultPitfall('${{c.case}}', ${{idx}})">✕</button>
      </div>
    `).join('');

    const triadHtml = c.clinicalTriad.map(t => `<li style="margin-left:16px; margin-bottom:2px;">${{t}}</li>`).join('');

    card.innerHTML = `
      <div class="card-header">
        <div>
          <span class="card-title">${{c.title}}</span>
          <div style="font-size:11px; color:#64748b; margin-top:2px;">Enum Case: .${{c.case}} | Category: ${{c.category.toUpperCase()}}</div>
        </div>
        <span class="badge badge-red">${{c.acuityLabel || 'EMERGENCY'}}</span>
      </div>

      <div class="media-card-grid">
        <div>
          <div class="viewport-container">
            <img src="${{c.image_file}}" alt="${{c.title}}" title="Click to view full size">
            <div class="viewport-caption">Authentic Clinical Radiological Plate (${{c.assetImageName}})</div>
          </div>
          ${{triadHtml ? `<div style="background:#090d15; padding:10px; border-radius:8px; border:1px solid #1e2638; margin-top:10px; font-size:11px; color:#94a3b8;"><div style="font-weight:800; color:#00e5ff; margin-bottom:4px;">CLINICAL TRIAD / PRESENTATION:</div><ul>${{triadHtml}}</ul></div>` : ''}}
        </div>

        <div style="display:flex; flex-direction:column; gap:12px;">
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
            <div>
              <div class="field-label">Full Module Title:</div>
              <input type="text" class="edit-input" value="${{c.title}}" onchange="c.title = this.value">
            </div>
            <div>
              <div class="field-label">Short Carousel Title:</div>
              <input type="text" class="edit-input" value="${{c.shortTitle}}" onchange="c.shortTitle = this.value">
            </div>
          </div>

          <div>
            <div class="field-label">Acuity Status Label:</div>
            <input type="text" class="edit-input" value="${{c.acuityLabel}}" onchange="c.acuityLabel = this.value">
          </div>

          <div>
            <div class="field-label">Imaging Diagnostic Pearl:</div>
            <textarea class="edit-textarea" onchange="c.imagingPearl = this.value">${{c.imagingPearl}}</textarea>
          </div>

          <div>
            <div class="field-label">Definitive Operative Plan:</div>
            <textarea class="edit-textarea" onchange="c.operativePlan = this.value">${{c.operativePlan}}</textarea>
          </div>

          <div>
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
              <div class="field-label" style="margin:0;">Catastrophic Pitfalls & Fatal Errors (${{c.pitfalls.length}}):</div>
              <button style="background:#1e293b; color:#f43f5e; border:1px solid #334155; padding:2px 8px; border-radius:6px; font-size:11px; cursor:pointer;" onclick="addConsultPitfall('${{c.case}}')">+ Add Pitfall</button>
            </div>
            <div style="display:flex; flex-direction:column; gap:6px;">
              ${{pitfallsRows}}
            </div>
          </div>

          <button class="save-btn" onclick="saveConsultToSwift('${{c.case}}')">💾 Save Consult to Swift</button>
        </div>
      </div>
    `;
    grid.appendChild(card);
  }});
}}

function deleteConsultPitfall(cCase, idx) {{
  const c = appData.consults.find(x => x.case === cCase);
  if (c) {{
    c.pitfalls.splice(idx, 1);
    renderConsults();
  }}
}}

function addConsultPitfall(cCase) {{
  const c = appData.consults.find(x => x.case === cCase);
  if (c) {{
    c.pitfalls.push("Catastrophic Pitfall: ");
    renderConsults();
  }}
}}

async function saveConsultToSwift(cCase) {{
  const c = appData.consults.find(x => x.case === cCase);
  if (!c) return;

  try {{
    const res = await fetch("/api/save-consult", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{ case: cCase, data: c }})
    }});
    const data = await res.json();
    if (data.status === "ok") showToast(`Consult ${{c.shortTitle}} saved directly to Swift!`);
    else alert("Error: " + data.message);
  }} catch (e) {{ alert("Connection error: " + e); }}
}}

// ==========================================
// 4. BEDSIDE PROCEDURES RENDER
// ==========================================
let currentProcedureFilter = 'all';

function filterProcedures(procId) {{
  currentProcedureFilter = procId;
  document.querySelectorAll('[id^="filter-proc-"]').forEach(btn => btn.classList.remove('active'));
  document.getElementById(`filter-proc-${{procId === 'all' ? 'all' : (procId === 'camino_bolt' ? 'camino' : procId.replace('lumbar_', ''))}}`)?.classList.add('active');
  renderProcedures();
}}

function renderProcedures() {{
  const grid = document.getElementById('proceduresGrid');
  grid.innerHTML = '';

  const filtered = appData.procedures.filter(p => {{
    return (currentProcedureFilter === 'all') || (p.id === currentProcedureFilter);
  }});

  filtered.forEach(proc => {{
    const card = document.createElement('div');
    card.className = 'studio-card';

    const stepsHtml = proc.steps.map((st, idx) => `
      <div style="background:#131a26; padding:10px 12px; border-radius:8px; border:1px solid #232c40; display:flex; flex-direction:column; gap:6px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <span style="font-size:12px; font-weight:800; color:#00e5ff;">STEP ${{st.number}}:</span>
          <button class="save-btn" style="padding:4px 8px; font-size:11px;" onclick="saveProcedureStep('${{proc.card_name}}', '${{st.number}}', ${{idx}})">💾 Save Step</button>
        </div>
        <div>
          <div class="field-label">Step Title:</div>
          <input type="text" class="edit-input" value="${{st.title}}" onchange="proc.steps[${{idx}}].title = this.value">
        </div>
        <div>
          <div class="field-label">Anatomical Trajectory / Coordinates Detail:</div>
          <textarea class="edit-textarea" onchange="proc.steps[${{idx}}].detail = this.value">${{st.detail}}</textarea>
        </div>
      </div>
    `).join('');

    card.innerHTML = `
      <div class="card-header">
        <div>
          <span class="card-title">${{proc.title}}</span>
          <div style="font-size:11px; color:#64748b; margin-top:2px;">Swift Component: ${{proc.card_name}}</div>
        </div>
        <span class="badge badge-cyan">BEDSIDE HARDWARE PROTOCOL</span>
      </div>

      <div class="media-card-grid">
        <div class="viewport-container">
          <img src="${{proc.image_file}}" alt="${{proc.title}}">
          <div class="viewport-caption">High-Definition Anatomical Schematic (${{proc.id}})</div>
        </div>

        <div style="display:flex; flex-direction:column; gap:12px;">
          <div style="font-size:12px; color:#94a3b8;">${{proc.summary}}</div>
          <div style="display:flex; flex-direction:column; gap:10px;">
            ${{stepsHtml}}
          </div>
        </div>
      </div>
    `;
    grid.appendChild(card);
  }});
}}

async function saveProcedureStep(cardName, stepNum, idx) {{
  const proc = appData.procedures.find(p => p.card_name === cardName);
  if (!proc || !proc.steps[idx]) return;

  const st = proc.steps[idx];
  try {{
    const res = await fetch("/api/save-procedure", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{
        card_name: cardName,
        number: stepNum,
        title: st.title,
        detail: st.detail
      }})
    }});
    const data = await res.json();
    if (data.status === "ok") showToast(`Step ${{stepNum}} (${{st.title}}) saved directly to Swift!`);
    else alert("Error: " + data.message);
  }} catch (e) {{ alert("Connection error: " + e); }}
}}

// ==========================================
// 5. CALCULATORS RENDER
// ==========================================
function renderCalculators() {{
  const grid = document.getElementById('calculatorsGrid');
  grid.innerHTML = '';

  appData.calculators.forEach(calc => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{calc.title}}</span>
        <span class="badge badge-amber">CLINICAL SCORING</span>
      </div>
      <div>
        <div class="field-label">Score Formula / Point Allocation:</div>
        <textarea class="edit-textarea" readonly style="background:#090d15;">${{calc.formula}}</textarea>
      </div>
      <div>
        <div class="field-label">Target / Stratification:</div>
        <input type="text" class="edit-input" readonly style="background:#090d15;" value="${{calc.target}}">
      </div>
      <div style="font-size:11px; color:#64748b;">Evidence: ${{calc.evidence}}</div>
    `;
    grid.appendChild(card);
  }});
}}

// Initial Render
renderAtlas();
renderCrisis();
renderConsults();
renderProcedures();
renderCalculators();
</script>
</body>
</html>
"""

out_path = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector\index.html"
with open(out_path, "w", encoding="utf-8") as f:
    f.write(html_template)

print(f"Generated Full App Studio HTML at {out_path} ({len(html_template)} bytes)")
