import json
import re
import os

SWIFT_PATHS = {
    "atlas_data": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift",
    "atlas_view": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift",
    "crisis": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\EmergencyProtocolsView.swift",
    "consults": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\ERConsultsView.swift",
    "procedures": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgicalProceduresView.swift",
    "calculators": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgeryCalculatorsView.swift",
    "icp_ladder": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\TieredICPLadderView.swift",
    "reversal_engine": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\EmergencyReversalEngineView.swift",
    "or_setup": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\ORSetupBridgeView.swift",
    "brainstem_ladder": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\RostrocaudalBrainstemLadderView.swift"
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

    # Domain tag (Master 096 first, Cranial second, Spine third, Pediatric fourth)
    pediatric_plates = {"002", "043", "046", "095", "105"}
    spine_plates = {
        "001", "013", "014", "035", "047", "049", "088", "097",
        "015", "031", "034", "042", "044", "050", "064", "076", "080", "091", "098",
        "026", "036", "038", "048", "054", "058", "068", "072", "073", "078", "085", "094", "103",
        "011", "007", "037", "029", "028", "032", "083", "087", "100", "101", "106",
        "023", "024", "039", "071", "075", "081", "099", "102", "104",
        "089", "090", "092"
    }
    if p_str == "096":
        domain_tag = "Master"
    elif p_str in pediatric_plates:
        domain_tag = "Pediatric"
    elif p_str in spine_plates:
        domain_tag = "Spine"
    else:
        domain_tag = "Cranial"

    plates_data.append({
        "plate_num": p_str,
        "title": plate_title,
        "batch_tag": batch_tag,
        "domain": domain_tag,
        "image_file": f"/plates/plate_{p_str}.jpg",
        "pins": pins,
        "steps": steps,
        "hazards": hazards
    })

# Check if custom saved order exists
order_file = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector\plate_order.json"
if os.path.exists(order_file):
    try:
        with open(order_file, "r", encoding="utf-8") as f:
            saved_order = json.load(f).get("order", [])
        if saved_order:
            plates_by_num = {p["plate_num"]: p for p in plates_data}
            ordered = []
            for p_num in saved_order:
                if p_num in plates_by_num:
                    ordered.append(plates_by_num[p_num])
            for p in plates_data:
                if p not in ordered:
                    ordered.append(p)
            plates_data = ordered
            print(f"Applied saved custom plate order ({len(plates_data)} plates)")
    except Exception as e:
        print(f"Note: Could not load plate_order.json: {e}")

# ==========================================
# 2. PARSE 2 AM CRISIS (5 SUB-MODULES)
# ==========================================
# A. Acute Triage
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

# B. BTF ICP Ladder
icp_tiers = [
    {
        "tier": "Tier 0: Universal Baseline",
        "subtitle": "Foundational Neuro-ICU Measures for all severe TBI",
        "color": "neonGreen",
        "interventions": [
            "Elevate Head of Bed (HOB) 30° with neutral neck alignment to maximize jugular venous return.",
            "Ensure endotracheal tube ties and cervical collar are not compressing internal jugular veins.",
            "Maintain normothermia (36.0°C – 37.5°C); aggressively treat fevers with antipyretics and surface cooling.",
            "Target PaCO2 35 – 38 mmHg (eucapnia); avoid hyperventilation in first 24 hours.",
            "Maintain MAP ≥ 80 mmHg to preserve CPP ≥ 60 mmHg; avoid hypotensive episodes (SBP < 100 mmHg).",
            "Maintain serum sodium 135 – 145 mEq/L; avoid hypotonic IV crystalloids (e.g., D5W, 0.45% NaCl)."
        ],
        "rationale": "Every 1°C increase in core temperature increases cerebral metabolic demand (CMRO2) by ~10%, triggering reactive cerebral vasodilation and intracranial volume expansion."
    },
    {
        "tier": "Tier 1: Early ICP > 22 mmHg",
        "subtitle": "Sedation deepening, osmotherapy, CSF drainage",
        "color": "neonCyan",
        "interventions": [
            "Deepen sedation: Titrate Propofol or Dexmedetomidine; short trial of neuromuscular blockade.",
            "Osmotherapy: Administer 3% Hypertonic Saline 250 mL IV bolus over 15 min OR Mannitol 20% 1 g/kg IV.",
            "CSF Drainage: Open ventriculostomy (EVD) at 10 – 15 cm H2O to drain 5 – 10 mL CSF.",
            "Neuromonitoring: Verify ICP transducer calibration and rule out waveform dampening or artifact.",
            "Repeat Head CT: STAT non-contrast CT head to assess for progressive mass effect or delayed hematoma."
        ],
        "rationale": "Do not administer Mannitol if SBP < 90 mmHg or patient is hypovolemic; osmotic diuresis will drop MAP and collapse CPP, precipitating secondary brainstem ischemia."
    },
    {
        "tier": "Tier 2: Sustained ICP > 22 mmHg",
        "subtitle": "Paralytics, hyperosmolar targets, mild hyperventilation",
        "color": "neonAmber",
        "interventions": [
            "Neuromuscular Blockade: Continuous Cisatracurium infusion titrated to 1-2 twitches on Train-of-Four.",
            "Hyperosmolar Titration: Push serum sodium to 150 – 155 mEq/L using continuous 3% NaCl (1 – 2 mL/kg/hr).",
            "Mild Hyperventilation: Temporarily target PaCO2 30 – 35 mmHg ONLY with continuous jugular bulb (SjvO2) or brain tissue oxygen (PbtO2) monitoring.",
            "Therapeutic Normothermia: Target 35.0°C – 36.0°C via endovascular or advanced surface cooling.",
            "MAP Optimization: Escalate vasopressors (Norepinephrine / Phenylephrine) to maintain CPP ≥ 60 – 70 mmHg."
        ],
        "rationale": "Hyperventilation below PaCO2 30 mmHg causes severe cerebral vasoconstriction, cutting cerebral blood flow (CBF) and causing profound ischemic tissue hypoxia despite lower ICP numbers."
    },
    {
        "tier": "Tier 3: Refractory Crisis",
        "subtitle": "Decompressive hemicraniectomy vs Pentobarbital coma",
        "color": "neonRed",
        "interventions": [
            "Surgical Decompression: Emergent Unilateral Decompressive Hemicraniectomy (≥12 x 15 cm) with dural patch expansion OR Bifrontal Craniectomy.",
            "High-Dose Barbiturate Coma: Pentobarbital bolus (10 mg/kg over 30 min) then 1 – 3 mg/kg/hr titrated to burst suppression (3 – 5 bursts/min) on continuous EEG.",
            "Moderate Hypothermia (32°C – 34°C): Salvage rescue only; slow rewarming (≤0.25°C/hr) to avoid rebound cerebral edema.",
            "Invasive Hemodynamic Monitoring: Arterial line + central line mandatory; prepare for high vasopressor requirements during barbiturate myocardial depression."
        ],
        "rationale": "Hemicraniectomy bone flaps MUST measure at least 12 x 15 cm. Small bone flaps cause mushroom herniation and venous strangulation against the rigid cut bone edges."
    }
]

# C. Reversal Engine
reversal_engine_modules = [
    {
        "drug": "Warfarin (Coumadin)",
        "target": "Target INR ≤ 1.3 within 30 min",
        "firstLine": "4-Factor Prothrombin Complex Concentrate (4F-PCC / Kcentra) + Vitamin K 10 mg IV slow infusion over 30 min",
        "dosing": "INR 2.0-3.9: 25 U/kg (max 2,500 U) | INR 4.0-6.0: 35 U/kg (max 3,500 U) | INR >6.0: 50 U/kg (max 5,000 U)",
        "pearl": "Repeat INR at 30 minutes post-infusion. Vitamin K is mandatory because 4F-PCC half-life is only 6-8 hours while warfarin effect persists for days."
    },
    {
        "drug": "Apixaban (Eliquis) / Rivaroxaban (Xarelto)",
        "target": "Immediate cessation of Factor Xa inhibition",
        "firstLine": "Andexanet Alfa (Andexxa) OR 4-Factor PCC (Kcentra) 50 U/kg (max 5,000 U)",
        "dosing": "Low Dose: 400 mg bolus (30 mg/min) + 4 mg/min infusion x 120 min | High Dose: 800 mg bolus + 8 mg/min x 120 min",
        "pearl": "High-dose Andexxa indicated if last dose < 8h or unknown, or dose was Apixaban >5mg / Rivaroxaban >10mg. If Andexxa unavailable, give 4F-PCC 50 U/kg."
    },
    {
        "drug": "Dabigatran (Pradaxa)",
        "target": "Complete normalization of Thrombin Time in 15 min",
        "firstLine": "Idarucizumab (Praxbind) 5 g IV (two consecutive 2.5 g vials)",
        "dosing": "5 g IV bolus (vial 1 followed immediately by vial 2; no infusion delay)",
        "pearl": "Humanized monoclonal antibody fragment with 350x higher affinity for dabigatran than thrombin. If unavailable, use 4F-PCC 50 U/kg or emergent hemodialysis."
    },
    {
        "drug": "Antiplatelets (Aspirin, Clopidogrel / Plavix, Ticagrelor)",
        "target": "Restoration of primary platelet aggregation plug",
        "firstLine": "Platelet Transfusion + DDAVP (Desmopressin)",
        "dosing": "1-2 Single-Donor Apheresis Units (or 6-pack pooled) + DDAVP 0.3 mcg/kg IV in 50 mL saline over 20 min",
        "pearl": "PATCH trial cautioned against routine platelet transfusion in spontaneous ICH on aspirin alone; however in traumatic ICH or urgent neurosurgery, platelets + DDAVP are standard."
    },
    {
        "drug": "Heparin & Low Molecular Weight Heparin (LMWH / Lovenox)",
        "target": "Neutralization of unfractionated heparin and anti-Xa inhibition",
        "firstLine": "Protamine Sulfate IV",
        "dosing": "UFH: 1 mg per 100 units heparin given in last 2-3 hours (max 50 mg) | Enoxaparin <8h: 1 mg protamine per 1 mg enoxaparin | Enoxaparin 8-12h: 0.5 mg per 1 mg",
        "pearl": "Infuse slowly (≤5 mg/min) to prevent severe anaphylactoid hypotension, pulmonary vasoconstriction, and catastrophic bradycardia."
    }
]

# D. OR Spec Sheets
or_spec_sheets = [
    {
        "procedure": "Emergent Trauma Craniectomy / Craniotomy",
        "positioning": "Supine on gel horseshoe or 3-pin Mayfield (Torque: 60 lbs; pin avoidance: temporal muscle & thin squama).",
        "drill": "High-speed electric/pneumatic drill, 14 mm perforator with auto-clutch, footplate craniotome bit.",
        "hemostasis": "Bipolar forceps (irrigation line attached, setting 25-35), Surgicel Fibrillar (x3), Floseal/Surgiflo (2 kits), Gelita-Spon, Bone Wax.",
        "duralPatch": "3x3 inch bovine pericardium (DuraGuard) or DuraGen onlay + 4-0 Nurolon braided retention sutures.",
        "closure": "0.6 mm dynamic titanium cranial mesh + 4 mm self-drilling cross-pin screws; 10 Fr Blake/JP subgaleal drain to gravity."
    },
    {
        "procedure": "Goel-Harms C1–C2 Posterior Cervical Fusion",
        "positioning": "Prone on Jackson table with chest rolls; 3-pin Mayfield with rocker arm inverted (military chin tuck, cross-table fluoro clearance).",
        "drill": "3.5 mm polyaxial screws (C1 Lateral Mass: 28 mm & 30 mm; C2 Pedicle/Pars: 26 mm & 28 mm).",
        "hemostasis": "C2 epidural venous plexus bleeding: bipolar coagulation, Surgicel Nu-Knit packing, thrombin-soaked gelfoam.",
        "duralPatch": "Torx T15 / T20 star-shaped set-screw drivers with 5.0 Nm torque-limiting handle.",
        "closure": "Demineralized bone matrix (DBM) putty + autologous local spinous process bone graft chips."
    },
    {
        "procedure": "L4–L5 TLIF Interbody Fusion",
        "positioning": "Prone on radiolucent Jackson spinal table (Wilson frame or flat radiolucent top).",
        "drill": "Four 6.5 mm x 45 mm (or 7.5 mm) pedicle screws + two 5.5 mm titanium rods.",
        "hemostasis": "McCulloch retractor frame, Scoville nerve root retractor, bayoneted disc rongeurs, bone graft funnel.",
        "duralPatch": "Porous 3D-printed titanium or PEEK curved banana cage (Heights: 9 mm, 10 mm, 11 mm; 4-8° lordosis).",
        "closure": "Recombinant BMP-2 (Infuse small kit) or DBM putty + autologous local facet bone."
    },
    {
        "procedure": "Emergency Bedside Ventriculostomy (EVD) Kit",
        "positioning": "Kocher's point (11 cm posterior from nasion, 3 cm lateral from midline).",
        "drill": "Hand twist drill with 5.5 mm bit and safety depth stop collar set to 1.0 cm.",
        "hemostasis": "Medial canthus in coronal plane; tragus in sagittal plane (Never advance > 7.0 cm; stop at 5.5-6.5 cm).",
        "duralPatch": "8.5 Fr or 9 Fr barium-impregnated silver/antibiotic ventriculostomy catheter with metallic stylet.",
        "closure": "External drainage system with laser zero level referenced to Tragus (Foramen of Monro)."
    },
    {
        "procedure": "Programmable Shunt Valve Sizing & Reprogramming Guide",
        "positioning": "Medtronic Strata II: Settings 0.5 (very low) to 2.5 (high). Requires Strata hand programmer magnet; affected by 1.5T/3T MRI (Verify post-MRI).",
        "drill": "Codman Certas Plus: Settings 1 (36 mmH2O) to 8 (238 mmH2O). MRI conditional to 3.0 Tesla; setting does NOT alter in magnetic field.",
        "hemostasis": "Sophysa Polaris: Micro-magnets with magnetic locking. MRI stable up to 3 Tesla.",
        "duralPatch": "Miethke proGAV 2.0: Gravitational ball-in-cone valve. Range 0 to 20 cmH2O. MRI conditional up to 3T without unintentional resetting.",
        "closure": "Check abdominal pseudocyst via abdominal ultrasound before surgical distal revision."
    }
]

# E. Operative Checklists
operative_checklists = [
    {
        "title": "Acute Herniation Resuscitation & Pupillary Asymmetry Protocol",
        "image_file": "/plates/plate_herniation_pupils.jpg",
        "steps": [
            "Immediately elevate head of bed to 30 degrees (promotes jugular venous drainage).",
            "Push Mannitol (1 g/kg IV bolus) or 3% Hypertonic Saline (250-500 mL bolus over 15 min).",
            "Brief hyperventilation to PaCO2 30-35 mmHg as temporary bridge to OR only.",
            "Obtain urgent non-contrast Head CT or mobilize OR team directly if known surgical lesion.",
            "Emergency bedside ventriculostomy (EVD) or decompressive hemicraniectomy."
        ]
    },
    {
        "title": "Emergency Bedside EVD Trajectory Checklist",
        "image_file": "/plates/plate_bedside_evd.jpg",
        "steps": [
            "Verify Kocher's point landmark: 1 cm anterior to coronal suture, 2.5-3.0 cm lateral to midline.",
            "Set twist drill safety stop collar strictly to 1.0 cm before perforating outer skull cortex.",
            "Perforate dura with 18G needle; puncture straight without stripping dural attachments.",
            "Aim catheter trajectory toward ipsilateral medial canthus (coronal) and external auditory meatus (sagittal).",
            "Stop advancement upon CSF flash at 4.5-5.5 cm; never advance beyond 6.5 cm from outer cortex."
        ]
    },
    {
        "title": "Trauma Decompressive Craniectomy Operative Checklist",
        "image_file": "/plates/plate_ct_sdh.jpg",
        "steps": [
            "Question mark (reverse-hockey stick) trauma incision starting at zygomatic arch (<1 cm anterior to tragus).",
            "Elevate myocutaneous flap forward preserving superficial temporal artery and frontal branch of facial nerve.",
            "Perform generous hemicraniectomy at least 12 x 15 cm; decompress down to middle cranial fossa floor.",
            "Open dura in stellate or C-shaped fashion with base toward superior sagittal sinus.",
            "Evacuate subdural/epidural hematoma, achieve meticulous hemostasis, perform expansile duraplasty."
        ]
    }
]

# ==========================================
# 3. PARSE ER CONSULTS (CRANIAL, SPINE, BRAINSTEM)
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

# Brainstem Reflex Ladder Data (6 stages with full Plum & Posner parameters)
brainstem_stages = [
    {
        "level": 0,
        "name": "0. Intact Consciousness",
        "anatomicalLevel": "Cortex & Diencephalon (Intact)",
        "reflexTrigger": "Normal Consciousness / Wakefulness",
        "pupils": "Round, regular, reactive to light (3-4 mm). Intact bilateral light reflex.",
        "motor": "Purposeful, commands-following or purposeful withdrawal.",
        "respiration": "Eupnea (normal rhythm, rate 12-16/min).",
        "statusBadge": "NORMAL CONSCIOUSNESS",
        "badgeColor": "green"
    },
    {
        "level": 1,
        "name": "1. Diencephalic Stage",
        "anatomicalLevel": "Thalamus / Hypothalamus (Compression)",
        "reflexTrigger": "Pupillary Dilation / Sympathetic",
        "pupils": "Small (1-2 mm) reactive 'diencephalic' pupils (loss of descending sympathetic tone).",
        "motor": "Bilateral paratonic rigidity or Decorticate Posturing (flexion of arms, extension of legs).",
        "respiration": "Cheyne-Stokes Respiration (waxing-waning tidal volume with interspersed apnea).",
        "statusBadge": "EARLY CENTRAL HERNIATION",
        "badgeColor": "cyan"
    },
    {
        "level": 2,
        "name": "2. Midbrain (Upper Brainstem) Stage",
        "anatomicalLevel": "Tectum & Edinger-Westphal Nucleus (CN III)",
        "reflexTrigger": "Pupillary Light Reflex (CN II / III)",
        "pupils": "Midposition (4-6 mm), irregular, fixed to light. Oculocephalic (doll's eyes) impaired.",
        "motor": "Decerebrate Posturing (extension, adduction, and internal rotation of upper extremities).",
        "respiration": "Central Neurogenic Hyperventilation (sustained, rapid, deep hyperpnea 25-40/min).",
        "statusBadge": "CRITICAL MIDBRAIN COMPRESSION",
        "badgeColor": "amber"
    },
    {
        "level": 3,
        "name": "3. Pontine (Middle Brainstem) Stage",
        "anatomicalLevel": "Basis Pontis & PPRF (CN V, VII, VIII)",
        "reflexTrigger": "Corneal & Oculocephalic Reflexes",
        "pupils": "Pinpoint (<1 mm) or small fixed. Loss of corneal reflex and cold caloric oculovestibular response.",
        "motor": "Flaccid or weak decerebrate posturing; bilateral Babinski signs.",
        "respiration": "Apneustic Breathing (prolonged inspiratory pauses of 2-3 sec followed by brief exhalation) or cluster breathing.",
        "statusBadge": "SEVERE PONTINE DECOMPENSATION",
        "badgeColor": "amber"
    },
    {
        "level": 4,
        "name": "4. Upper Medullary Stage",
        "anatomicalLevel": "Upper Medulla (Nucleus Ambiguus / Solitarius, CN IX, X)",
        "reflexTrigger": "Gag & Carinal Cough Reflexes",
        "pupils": "Fixed and dilated (6-8 mm) or midposition fixed.",
        "motor": "Completely flaccid tone; no motor response to painful stimuli.",
        "respiration": "Ataxic Breathing (Biot's respiration: irregular, completely chaotic breaths with variable pauses).",
        "statusBadge": "IMPENDING CONING / APNEA",
        "badgeColor": "red"
    },
    {
        "level": 5,
        "name": "5. Terminal Medullary Stage (Brain Death)",
        "anatomicalLevel": "Ventral Respiratory Group & Foramen Magnum (Tonsillar Coning)",
        "reflexTrigger": "Apnea / Loss of all Brainstem Reflexes",
        "pupils": "Fixed, dilated, unreactive bilateral pupils (mydriasis).",
        "motor": "No motor response; total flaccidity (triple flexion spinal reflex may persist).",
        "respiration": "Apnea (complete absence of spontaneous respiratory drive upon PaCO2 challenge ≥60 mmHg).",
        "statusBadge": "BRAIN DEATH (TONSILLAR HERNIATION)",
        "badgeColor": "red"
    }
]

# ==========================================
# 4. PARSE BEDSIDE HARDWARE & PROCEDURES
# ==========================================
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
        "icp_tiers": icp_tiers,
        "reversals": reversal_engine_modules,
        "or_specs": or_spec_sheets,
        "checklists": operative_checklists
    },
    "consults": {
        "cranial": cranial_consults,
        "spine": spine_consults,
        "brainstem": brainstem_stages
    },
    "procedures": procedure_defs,
    "calculators": calculators_data
}

app_json = json.dumps(app_store, indent=2)

html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NeuroCall Full App Studio — Interactive Visual Desktop Inspector</title>
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

  /* Sub-tab Toolbar */
  .sub-nav-bar {{
    display: flex; gap: 8px; flex-wrap: wrap; align-items: center; background: #0c111c;
    padding: 10px 14px; border-radius: 12px; border: 1px solid #1f283d;
  }}
  .sub-tab-btn {{
    background: #131b28; border: 1px solid #243047; border-radius: 8px;
    padding: 7px 14px; color: #94a3b8; font-size: 12px; font-weight: 700; cursor: pointer; transition: 0.15s;
  }}
  .sub-tab-btn:hover {{ background: #1b2638; color: #fff; }}
  .sub-tab-btn.active {{ background: #00e5ff; color: #000; border-color: #00e5ff; font-weight: 800; }}

  .sub-content-panel {{ display: none; flex-direction: column; gap: 18px; }}
  .sub-content-panel.active {{ display: flex; }}

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
  .badge-green {{ background: rgba(16,185,129,0.15); color: var(--accent-green); border: 1px solid rgba(16,185,129,0.3); }}

  /* Side-by-side Image + Form Grid */
  .media-card-grid {{ display: grid; grid-template-columns: 340px 1fr; gap: 18px; }}
  @media (max-width: 950px) {{ .media-card-grid {{ grid-template-columns: 1fr; }} }}

  /* Extra-Wide Format for Complex Matrix Tables */
  .media-card-grid.fullwidth-table {{
    display: flex; flex-direction: column; gap: 18px;
  }}
  .media-card-grid.fullwidth-table .viewport-container img {{
    max-height: 650px; width: 100%; object-fit: contain;
  }}
  
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
    display: flex; justify-content: space-between; align-items: center;
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

  /* PowerPoint Slide Sorter Grid */
  :root {{
    --slide-size: 110px;
  }}
  .slide-sorter-grid {{
    display: grid; grid-template-columns: repeat(auto-fill, minmax(var(--slide-size, 110px), 1fr)); gap: 8px;
    padding: 10px; background: #080c14; border-radius: 10px; border: 1px solid #1a2338;
  }}
  .slide-tile {{
    background: #0f1623; border: 1.5px solid #202c42; border-radius: 6px; padding: 5px;
    display: flex; flex-direction: column; gap: 4px; cursor: grab; user-select: none;
    transition: transform 0.15s, border-color 0.15s, box-shadow 0.15s; position: relative;
  }}
  .slide-tile:hover {{
    transform: translateY(-2px); border-color: var(--accent-cyan);
    box-shadow: 0 4px 16px rgba(0,229,255,0.25);
  }}
  .slide-tile.dragging {{ opacity: 0.4; cursor: grabbing; }}
  .slide-tile.drag-over-before {{ border-left: 4px solid var(--accent-cyan); }}
  .slide-tile.drag-over-after {{ border-right: 4px solid var(--accent-cyan); }}
  .slide-thumb {{
    width: 100%; aspect-ratio: 1 / 1; background: #000; border-radius: 4px; overflow: hidden;
    border: 1px solid #25334c; position: relative; cursor: pointer;
  }}
  .slide-thumb img {{ width: 100%; height: 100%; object-fit: contain; pointer-events: none; }}
  .slide-badge-seq {{
    position: absolute; top: 2px; left: 2px; background: rgba(0,0,0,0.85); color: #00e5ff;
    padding: 1px 3px; border-radius: 3px; font-size: 9px; font-weight: 900; border: 1px solid #00e5ff;
  }}
  .slide-badge-orig {{
    position: absolute; top: 2px; right: 2px; background: rgba(0,0,0,0.85); color: #ffb300;
    padding: 1px 3px; border-radius: 3px; font-size: 8px; font-weight: 800; border: 1px solid #ffb300;
  }}
  .slide-title {{
    font-size: 10px; font-weight: 800; color: #fff; line-height: 1.25;
    overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
    min-height: 25px;
  }}
  .slide-section-divider {{
    grid-column: 1 / -1; margin-top: 14px; margin-bottom: 2px; padding: 6px 12px;
    background: linear-gradient(90deg, #101b2b, #090e18); border-radius: 6px;
    display: flex; align-items: center; justify-content: space-between; font-size: 11px; font-weight: 900;
  }}

  /* Interactive Brainstem Elevator */
  .brainstem-slider-container {{
    background: #0d121d; border: 1px solid #1e2638; border-radius: 12px; padding: 16px 20px;
    display: flex; flex-direction: column; gap: 12px;
  }}
  .brainstem-slider {{
    width: 100%; height: 8px; border-radius: 5px; outline: none; background: #1e293b;
    accent-color: #00e5ff; cursor: pointer;
  }}
  .elevator-board {{
    background: #090d15; border: 1px solid #1e2638; border-radius: 14px; padding: 18px;
    display: flex; flex-direction: column; gap: 10px;
  }}
  .elevator-stage {{
    background: #111723; border: 1.5px solid #202b3f; border-radius: 10px; padding: 12px 16px;
    display: flex; justify-content: space-between; align-items: center; gap: 14px; transition: 0.2s;
  }}
  .elevator-stage.active-stage {{
    border-color: #fff; background: #17243c; box-shadow: 0 0 12px rgba(0,229,255,0.3);
  }}
  .elevator-stage.collapsed {{
    background: #151a24; opacity: 0.9;
  }}

  /* Lightbox Modal */
  #lightbox {{
    display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
    background: rgba(0,0,0,0.92); z-index: 10000; flex-direction: column;
    align-items: center; justify-content: center; padding: 20px;
  }}
  #lightbox.active {{ display: flex; }}
  #lightbox img {{
    max-width: 95vw; max-height: 90vh; object-fit: contain; border-radius: 8px;
    box-shadow: 0 0 30px rgba(0,0,0,0.9); border: 1px solid #334155;
  }}
  #lightbox-close {{
    position: absolute; top: 20px; right: 24px; font-size: 28px; font-weight: 800;
    color: #fff; background: none; border: none; cursor: pointer; padding: 8px 14px;
    background: rgba(255,255,255,0.1); border-radius: 8px;
  }}
</style>
</head>
<body>

<div id="toast">Saved to Swift!</div>

<!-- Full-Resolution Lightbox -->
<div id="lightbox" onclick="closeLightbox(event)">
  <button id="lightbox-close" onclick="closeLightbox(event)">✕ Close (Esc)</button>
  <img id="lightbox-img" src="" alt="Enlarged Medical Plate">
  <div id="lightbox-caption" style="color:#94a3b8; font-size:13px; font-weight:700; margin-top:10px;"></div>
</div>

<header>
  <div class="header-top">
    <div>
      <h1>🧠 NeuroCall Full App Studio</h1>
      <div class="header-desc">Dr. Mohit: Complete desktop interactive viewer across all clinical modules and sub-tabs matching the official app.</div>
    </div>
  </div>

  <div class="pillar-tabs">
    <button class="tab-btn active" onclick="switchPillar('atlas')">📖 1. Surgical Atlas (106 Plates)</button>
    <button class="tab-btn" onclick="switchPillar('crisis')">🚨 2. 2 AM Crisis (5 Sub-Modules)</button>
    <button class="tab-btn" onclick="switchPillar('consults')">🩺 3. Frontline ER Consults (Cranial, Spine, Brainstem)</button>
    <button class="tab-btn" onclick="switchPillar('procedures')">🎯 4. Bedside Hardware & Trajectories</button>
    <button class="tab-btn" onclick="switchPillar('calculators')">🔢 5. Calculators & Scoring</button>
  </div>
</header>

<!-- ========================================== -->
<!-- 1. SURGICAL ATLAS (SLIDE SORTER & EDITOR)  -->
<!-- ========================================== -->
<div id="pillar-atlas" class="section-container active">
  <div class="sub-nav-bar">
    <span style="font-size:12px; font-weight:800; color:#fff; margin-right:6px;">ATLAS VIEW MODES:</span>
    <button class="sub-tab-btn active" id="subtab-atlas-sorter" onclick="switchAtlasMode('sorter')">📑 PowerPoint Slide Sorter (106 Slides)</button>
    <button class="sub-tab-btn" id="subtab-atlas-inspector" onclick="switchAtlasMode('inspector')">🔍 Detailed Plate Inspector & Calibrator</button>
  </div>

  <!-- 1A. PowerPoint Slide Sorter View -->
  <div id="atlas-panel-sorter" class="sub-content-panel active">
    <div class="filter-bar" style="flex-wrap: wrap; gap: 8px;">
      <input type="text" id="sorterSearch" class="edit-input" style="max-width: 200px;" placeholder="Filter slides..." oninput="renderSlideSorter()">
      <button class="pill-filter active" id="filter-sorter-all" onclick="filterSorter('all')">All (106)</button>
      <button class="pill-filter" id="filter-sorter-master" onclick="filterSorter('Master')">🌟 Master (1)</button>
      <button class="pill-filter" id="filter-sorter-cranial" onclick="filterSorter('Cranial')">🧠 Cranial (45)</button>
      <button class="pill-filter" id="filter-sorter-spine" onclick="filterSorter('Spine')">🦴 Spine (55)</button>
      <button class="pill-filter" id="filter-sorter-pediatric" onclick="filterSorter('Pediatric')">👶 Pediatric (5)</button>
      
      <!-- Slide Zoom Controls -->
      <div style="display:flex; align-items:center; gap:6px; background:#0b1320; padding:3px 8px; border-radius:6px; border:1px solid #1a2338;">
        <span style="font-size:10px; color:#94a3b8; font-weight:700;">🔍 Zoom:</span>
        <input type="range" id="slideSizeSlider" min="70" max="220" value="110" step="5" style="width:75px; accent-color:#00e5ff; cursor:pointer;" oninput="setSlideSize(this.value)">
        <span id="slideSizeLabel" style="font-size:10px; color:#00e5ff; font-weight:800; min-width:32px;">110px</span>
        <button class="pill-filter" id="preset-tiny" style="padding:1px 5px; font-size:9px;" onclick="setSlideSize(80)">Tiny</button>
        <button class="pill-filter active" id="preset-compact" style="padding:1px 5px; font-size:9px;" onclick="setSlideSize(110)">Compact</button>
        <button class="pill-filter" id="preset-medium" style="padding:1px 5px; font-size:9px;" onclick="setSlideSize(150)">Medium</button>
        <button class="pill-filter" id="preset-large" style="padding:1px 5px; font-size:9px;" onclick="setSlideSize(200)">Large</button>
      </div>

      <span id="sorterMoveCountBadge" class="badge badge-cyan" style="margin-left:auto;">106 Slides Ready</span>
      <button class="pill-filter" style="border-color:#f43f5e; color:#f43f5e;" onclick="resetSlideOrder()">🔄 Reset Order</button>
      <button class="save-btn" id="save-order-btn" onclick="saveSlideOrderToSwift()">💾 Save Plate Order to Swift</button>
    </div>
    <div style="font-size:12px; color:#94a3b8; background:#0c111c; padding:8px 14px; border-radius:8px; border:1px solid #1f283d;">
      💡 <strong>Drag-and-Drop Reordering:</strong> Click and drag any slide thumbnail with the mouse to move it anywhere in the sequence. Visual insertion markers show exact landing spot.
    </div>
    <div id="slideSorterGrid" class="slide-sorter-grid"></div>
  </div>

  <!-- 1B. Detailed Plate Inspector View -->
  <div id="atlas-panel-inspector" class="sub-content-panel">
    <div class="filter-bar">
      <input type="text" id="atlasSearch" class="edit-input" style="max-width: 320px;" placeholder="Search 106 plates by title or plate number..." oninput="renderAtlas()">
      <span style="font-size:12px; color:#64748b;">💡 Drag any numbered circle to reposition. 15px markers ensure zero anatomical obscuration.</span>
    </div>
    <div id="atlasList" style="display:flex; flex-direction:column; gap:20px;"></div>
  </div>
</div>

<!-- ========================================== -->
<!-- 2. 2 AM CRISIS (5 EXACT SUB-TABS)          -->
<!-- ========================================== -->
<div id="pillar-crisis" class="section-container">
  <div class="sub-nav-bar">
    <span style="font-size:12px; font-weight:800; color:#fff; margin-right:6px;">2 AM CRISIS SUB-MODULES:</span>
    <button class="sub-tab-btn active" id="subtab-crisis-triage" onclick="switchCrisisSubTab('triage')">1. Acute Triage (4 CTs)</button>
    <button class="sub-tab-btn" id="subtab-crisis-icp" onclick="switchCrisisSubTab('icp')">2. BTF ICP Ladder</button>
    <button class="sub-tab-btn" id="subtab-crisis-reversal" onclick="switchCrisisSubTab('reversal')">3. Reversal Engine</button>
    <button class="sub-tab-btn" id="subtab-crisis-orsetup" onclick="switchCrisisSubTab('orsetup')">4. OR Spec Sheets</button>
    <button class="sub-tab-btn" id="subtab-crisis-checklists" onclick="switchCrisisSubTab('checklists')">5. OR Checklists</button>
  </div>

  <!-- 2A. Acute Triage -->
  <div id="crisis-panel-triage" class="sub-content-panel active">
    <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:14px;">
      <h2 style="font-size:15px; font-weight:800; color:#fff;">Acute Herniation & Emergency Operative Thresholds</h2>
      <div style="font-size:12px; color:#94a3b8; margin-top:3px;">BTF Surgical Criteria, High-Contrast Emergency CT Plates, and Operative Procedures</div>
    </div>
    <div id="crisisThresholdGrid" class="grid-2col"></div>
  </div>

  <!-- 2B. BTF ICP Ladder -->
  <div id="crisis-panel-icp" class="sub-content-panel">
    <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:14px;">
      <h2 style="font-size:15px; font-weight:800; color:#fff;">BTF Tiered Intracranial Pressure (ICP) Escalation Ladder</h2>
      <div style="font-size:12px; color:#94a3b8; margin-top:3px;">Tier 0 to Tier 3 Stepwise Escalation, Target CPP (60-70 mmHg), Osmotherapy, and Barbiturate Rescue</div>
    </div>
    <div id="icpLadderGrid" style="display:flex; flex-direction:column; gap:16px;"></div>
  </div>

  <!-- 2C. Reversal Engine -->
  <div id="crisis-panel-reversal" class="sub-content-panel">
    <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:14px;">
      <h2 style="font-size:15px; font-weight:800; color:#fff;">Emergency Anticoagulant & Antiplatelet Rapid Reversal Engine</h2>
      <div style="font-size:12px; color:#94a3b8; margin-top:3px;">Warfarin (4F-PCC + Vit K), DOACs (Andexxa / Kcentra), Dabigatran (Praxbind), Antiplatelets (Plts + DDAVP), Heparin (Protamine)</div>
    </div>
    <div id="reversalEngineGrid" style="display:flex; flex-direction:column; gap:16px;"></div>
  </div>

  <!-- 2D. OR Spec Sheets -->
  <div id="crisis-panel-orsetup" class="sub-content-panel">
    <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:14px;">
      <h2 style="font-size:15px; font-weight:800; color:#fff;">OR Setup & Implant Spec-Sheets for Circulators, Scrubs & Reps</h2>
      <div style="font-size:12px; color:#94a3b8; margin-top:3px;">Mayfield pin torques, screw diameters, drill footplates, dural patches, and programmable shunt valve settings</div>
    </div>
    <div id="orSetupGrid" style="display:flex; flex-direction:column; gap:16px;"></div>
  </div>

  <!-- 2E. Operative Checklists -->
  <div id="crisis-panel-checklists" class="sub-content-panel">
    <div style="background:#0d121d; border:1px solid #1e2638; border-radius:12px; padding:14px;">
      <h2 style="font-size:15px; font-weight:800; color:#fff;">Operative Resuscitation & Emergency Checklists</h2>
      <div style="font-size:12px; color:#94a3b8; margin-top:3px;">Pupillary Anisocoria Herniation Protocol, EVD Trajectory Checklist, and Trauma Craniectomy Checklist</div>
    </div>
    <div id="crisisChecklistGrid" style="display:flex; flex-direction:column; gap:16px;"></div>
  </div>
</div>

<!-- ========================================== -->
<!-- 3. ON-CALL ER CONSULTS SUITE               -->
<!-- ========================================== -->
<div id="pillar-consults" class="section-container">
  <div class="sub-nav-bar">
    <span style="font-size:12px; font-weight:800; color:#fff; margin-right:6px;">CONSULT CATEGORIES:</span>
    <button class="sub-tab-btn active" id="subtab-consult-cranial" onclick="switchConsultSubTab('cranial')">1. Cranial ER Consults (7)</button>
    <button class="sub-tab-btn" id="subtab-consult-spine" onclick="switchConsultSubTab('spine')">2. Spine ER Consults (6)</button>
    <button class="sub-tab-btn" id="subtab-consult-brainstem" onclick="switchConsultSubTab('brainstem')">3. Brainstem Reflex Ladder (Plum & Posner)</button>
    <input type="text" id="consultSearch" class="edit-input" style="max-width: 240px; margin-left:auto; padding:5px 8px; font-size:12px;" placeholder="Search consults..." oninput="renderConsults()">
  </div>

  <!-- 3A & 3B. Cranial / Spine Consults -->
  <div id="consult-panel-cases" class="sub-content-panel active">
    <div id="consultsGrid" style="display:flex; flex-direction:column; gap:20px;"></div>
  </div>

  <!-- 3C. Brainstem Reflex Ladder -->
  <div id="consult-panel-brainstem" class="sub-content-panel">
    <!-- Interactive Progression Slider (Exact match to iOS SwiftUI App) -->
    <div class="brainstem-slider-container">
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <div>
          <span style="font-size:14px; font-weight:800; color:#fff;">Brainstem Collapse Progression Depth:</span>
          <span id="sliderDepthLabel" style="font-size:14px; font-weight:900; color:#00e5ff; margin-left:8px;">0 Intact Consciousness</span>
        </div>
        <span id="sliderStatusBadge" class="badge badge-green">NORMAL CONSCIOUSNESS</span>
      </div>

      <input type="range" id="brainstemRangeSlider" class="brainstem-slider" min="0" max="5" step="1" value="0" oninput="handleBrainstemSliderChange(parseInt(this.value))">

      <div style="display:flex; justify-content:space-between; font-size:10px; font-weight:800; color:#94a3b8; padding:0 4px;">
        <span>0 Intact</span>
        <span>1 Diencephalon</span>
        <span>2 Midbrain</span>
        <span>3 Pons</span>
        <span>4 Upper Medulla</span>
        <span>5 Low Medulla / Apnea</span>
      </div>
    </div>

    <!-- Live Dynamic Clinical Readout Strip -->
    <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:12px;">
      <div style="background:#090d15; border:1px solid #1e2638; border-radius:10px; padding:12px;">
        <div style="font-size:10px; font-weight:800; color:#00e5ff; margin-bottom:4px;">👁️ PUPILLARY LIGHT REFLEX:</div>
        <div id="readoutPupils" style="font-size:12px; color:#f1f5f9; line-height:1.4;">Round, regular, reactive to light (3-4 mm). Intact bilateral light reflex.</div>
      </div>
      <div style="background:#090d15; border:1px solid #1e2638; border-radius:10px; padding:12px;">
        <div style="font-size:10px; font-weight:800; color:#f59e0b; margin-bottom:4px;">🏃 MOTOR POSTURING:</div>
        <div id="readoutMotor" style="font-size:12px; color:#f1f5f9; line-height:1.4;">Purposeful, commands-following or purposeful withdrawal.</div>
      </div>
      <div style="background:#090d15; border:1px solid #1e2638; border-radius:10px; padding:12px;">
        <div style="font-size:10px; font-weight:800; color:#f43f5e; margin-bottom:4px;">🫁 RESPIRATORY PATTERN:</div>
        <div id="readoutRespiration" style="font-size:12px; color:#f1f5f9; line-height:1.4;">Eupnea (normal rhythm, rate 12-16/min).</div>
      </div>
    </div>

    <!-- Vertical Anatomical Elevator Board -->
    <div id="brainstemElevatorBoard" class="elevator-board"></div>
  </div>
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
    <div style="font-size:12px; color:#94a3b8; margin-top:4px;">Validated peer-reviewed formulas, point allocations, and clinical management cutoffs.</div>
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

function openLightbox(src, caption) {{
  const lb = document.getElementById('lightbox');
  document.getElementById('lightbox-img').src = src;
  document.getElementById('lightbox-caption').innerText = caption || 'High-Resolution Medical Plate';
  lb.classList.add('active');
}}

function closeLightbox(e) {{
  if (e.target.id === 'lightbox' || e.target.id === 'lightbox-close') {{
    document.getElementById('lightbox').classList.remove('active');
  }}
}}

window.addEventListener('keydown', (e) => {{
  if (e.key === 'Escape') {{
    document.getElementById('lightbox').classList.remove('active');
  }}
}});

function switchPillar(pillarId) {{
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('.section-container').forEach(sec => sec.classList.remove('active'));

  event.currentTarget.classList.add('active');
  document.getElementById(`pillar-${{pillarId}}`).classList.add('active');
}}

// Atlas Modes
function switchAtlasMode(mode) {{
  document.querySelectorAll('[id^="subtab-atlas-"]').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('[id^="atlas-panel-"]').forEach(p => p.classList.remove('active'));

  document.getElementById(`subtab-atlas-${{mode}}`).classList.add('active');
  document.getElementById(`atlas-panel-${{mode}}`).classList.add('active');

  if (mode === 'sorter') {{
    renderSlideSorter();
  }} else {{
    renderAtlas();
  }}
}}

// 2 AM Crisis Sub-Tabs
function switchCrisisSubTab(tabId) {{
  document.querySelectorAll('[id^="subtab-crisis-"]').forEach(btn => btn.classList.remove('active'));
  document.querySelectorAll('[id^="crisis-panel-"]').forEach(panel => panel.classList.remove('active'));

  document.getElementById(`subtab-crisis-${{tabId}}`).classList.add('active');
  document.getElementById(`crisis-panel-${{tabId}}`).classList.add('active');
}}

// Consults Sub-Tabs
let currentConsultCategory = 'cranial';
function switchConsultSubTab(tabId) {{
  document.querySelectorAll('[id^="subtab-consult-"]').forEach(btn => btn.classList.remove('active'));
  document.getElementById(`subtab-consult-${{tabId}}`).classList.add('active');

  if (tabId === 'brainstem') {{
    document.getElementById('consult-panel-cases').classList.remove('active');
    document.getElementById('consult-panel-brainstem').classList.add('active');
    renderBrainstemElevator();
  }} else {{
    document.getElementById('consult-panel-brainstem').classList.remove('active');
    document.getElementById('consult-panel-cases').classList.add('active');
    currentConsultCategory = tabId;
    renderConsults();
  }}
}}

// ==========================================
// 1. SURGICAL ATLAS & POWERPOINT SLIDE SORTER
// ==========================================
let currentSorterFilter = 'all';
let draggedPlateNum = null;
let reorderCount = 0;

function setSlideSize(size) {{
  document.documentElement.style.setProperty('--slide-size', size + 'px');
  const lbl = document.getElementById('slideSizeLabel');
  if (lbl) lbl.textContent = size + 'px';
  const slider = document.getElementById('slideSizeSlider');
  if (slider) slider.value = size;
  ['preset-compact', 'preset-tiny', 'preset-medium', 'preset-large'].forEach(id => {{
    const el = document.getElementById(id);
    if (el) {{
      if (id === 'preset-tiny') el.classList.toggle('active', parseInt(size) === 80);
      if (id === 'preset-compact') el.classList.toggle('active', parseInt(size) === 110);
      if (id === 'preset-medium') el.classList.toggle('active', parseInt(size) === 150);
      if (id === 'preset-large') el.classList.toggle('active', parseInt(size) === 200);
    }}
  }});
  try {{ localStorage.setItem('neurocall_slide_size', size); }} catch(e){{}}
}}

function filterSorter(cat) {{
  currentSorterFilter = cat;
  document.getElementById('filter-sorter-all').classList.toggle('active', cat === 'all');
  document.getElementById('filter-sorter-master').classList.toggle('active', cat === 'Master');
  document.getElementById('filter-sorter-cranial').classList.toggle('active', cat === 'Cranial');
  document.getElementById('filter-sorter-spine').classList.toggle('active', cat === 'Spine');
  document.getElementById('filter-sorter-pediatric').classList.toggle('active', cat === 'Pediatric');
  renderSlideSorter();
}}

function renderSlideSorter() {{
  const grid = document.getElementById('slideSorterGrid');
  const search = document.getElementById('sorterSearch').value.toLowerCase();
  grid.innerHTML = '';

  const filtered = appData.atlas.filter((p) => {{
    const matchCat = (currentSorterFilter === 'all') || (p.domain === currentSorterFilter);
    const matchSearch = p.plate_num.includes(search) || p.title.toLowerCase().includes(search);
    return matchCat && matchSearch;
  }});

  let lastDomain = null;

  filtered.forEach((p, displayIndex) => {{
    const actualIndex = appData.atlas.findIndex(x => x.plate_num === p.plate_num);

    // Section Dividers when viewing presentation flow without search filter
    if (currentSorterFilter === 'all' && !search && p.domain !== lastDomain) {{
      lastDomain = p.domain;
      const div = document.createElement('div');
      div.className = 'slide-section-divider';
      if (p.domain === 'Master') {{
        div.style.borderLeft = '4px solid #a855f7';
        div.innerHTML = `<span style="color:#c084fc;">🌟 SECTION 1: THE NEUROCALL ATLAS (Plate 1)</span><span class="badge" style="background:rgba(168,85,247,0.25); color:#c084fc; border:1px solid #a855f7;">Master Overview</span>`;
      }} else if (p.domain === 'Cranial') {{
        div.style.borderLeft = '4px solid #00e5ff';
        div.innerHTML = `<span style="color:#00e5ff;">🧠 SECTION 2: CRANIAL & SKULL BASE (Plates 2 – 46)</span><span class="badge badge-cyan">45 Plates</span>`;
      }} else if (p.domain === 'Spine') {{
        div.style.borderLeft = '4px solid #ffb300';
        div.innerHTML = `<span style="color:#ffb300;">🦴 SECTION 3: SPINE & CVJ (Plates 47 – 101)</span><span class="badge badge-amber">55 Plates</span>`;
      }} else if (p.domain === 'Pediatric') {{
        div.style.borderLeft = '4px solid #f43f5e';
        div.innerHTML = `<span style="color:#f43f5e;">👶 SECTION 4: PEDIATRIC NEUROSURGERY (Plates 102 – 106)</span><span class="badge" style="background:rgba(244,63,94,0.25); color:#f43f5e; border:1px solid #f43f5e;">5 Plates</span>`;
      }}
      grid.appendChild(div);
    }}

    const tile = document.createElement('div');
    tile.className = 'slide-tile';
    tile.draggable = true;
    tile.dataset.plateNum = p.plate_num;
    tile.id = `slide-tile-${{p.plate_num}}`;

    const domainBadge = p.domain === 'Master'
      ? '<span class="badge" style="background:rgba(168,85,247,0.25); color:#c084fc; border:1px solid #a855f7; font-size:9px; padding:1px 4px;">Master</span>'
      : (p.domain === 'Cranial'
          ? '<span class="badge badge-cyan" style="font-size:9px; padding:1px 4px;">Cranial</span>'
          : (p.domain === 'Spine'
              ? '<span class="badge badge-amber" style="font-size:9px; padding:1px 4px;">Spine</span>'
              : '<span class="badge" style="background:rgba(244,63,94,0.25); color:#f43f5e; border:1px solid #f43f5e; font-size:9px; padding:1px 4px;">Pediatric</span>'));

    tile.innerHTML = `
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <span style="font-size:10px; font-weight:900; color:#00e5ff;">#${{actualIndex + 1}}</span>
        ${{domainBadge}}
      </div>
      <div class="slide-thumb" onclick="openLightbox('${{p.image_file}}', 'Plate ${{p.plate_num}}: ${{p.title.replace(/'/g, "\\'") }}')">
        <img src="${{p.image_file}}" alt="Plate ${{p.plate_num}}" loading="lazy">
        <span class="slide-badge-seq">#${{actualIndex + 1}}</span>
        <span class="slide-badge-orig">P-${{p.plate_num}}</span>
      </div>
      <div class="slide-title" title="${{p.title}}">${{p.title}}</div>
      <div style="display:flex; justify-content:space-between; align-items:center; margin-top:auto; font-size:9px; color:#64748b; border-top:1px solid #1a2436; padding-top:4px;">
        <span>📍${{p.pins.length}}</span>
        <span>📋${{p.steps.length}}</span>
        <button style="background:none; border:none; color:#00e5ff; font-weight:800; cursor:pointer; font-size:9px;" onclick="jumpToInspector('${{p.plate_num}}')">Edit ➔</button>
      </div>
    `;

    // HTML5 Drag Events
    tile.addEventListener('dragstart', (e) => {{
      draggedPlateNum = p.plate_num;
      tile.classList.add('dragging');
      e.dataTransfer.setData('text/plain', p.plate_num);
      e.dataTransfer.effectAllowed = 'move';
    }});

    tile.addEventListener('dragend', () => {{
      tile.classList.remove('dragging');
      document.querySelectorAll('.slide-tile').forEach(t => t.classList.remove('drag-over-before', 'drag-over-after'));
    }});

    tile.addEventListener('dragover', (e) => {{
      e.preventDefault();
      e.dataTransfer.dropEffect = 'move';
      const rect = tile.getBoundingClientRect();
      const midX = rect.left + rect.width / 2;
      tile.classList.toggle('drag-over-before', e.clientX < midX);
      tile.classList.toggle('drag-over-after', e.clientX >= midX);
    }});

    tile.addEventListener('dragleave', () => {{
      tile.classList.remove('drag-over-before', 'drag-over-after');
    }});

    tile.addEventListener('drop', (e) => {{
      e.preventDefault();
      tile.classList.remove('drag-over-before', 'drag-over-after');
      const targetPlateNum = p.plate_num;
      if (!draggedPlateNum || draggedPlateNum === targetPlateNum) return;

      const fromIdx = appData.atlas.findIndex(x => x.plate_num === draggedPlateNum);
      const toIdx = appData.atlas.findIndex(x => x.plate_num === targetPlateNum);
      if (fromIdx === -1 || toIdx === -1) return;

      const rect = tile.getBoundingClientRect();
      const insertAfter = e.clientX >= (rect.left + rect.width / 2);

      const [movedItem] = appData.atlas.splice(fromIdx, 1);
      const newTargetIdx = appData.atlas.findIndex(x => x.plate_num === targetPlateNum);
      const finalIdx = insertAfter ? newTargetIdx + 1 : newTargetIdx;
      appData.atlas.splice(finalIdx, 0, movedItem);

      reorderCount++;
      document.getElementById('sorterMoveCountBadge').innerText = `${{reorderCount}} Move(s) Made • New Order Ready`;
      document.getElementById('sorterMoveCountBadge').className = 'badge badge-amber';
      showToast(`Moved Plate ${{draggedPlateNum}} to position #${{finalIdx + 1}}!`);

      renderSlideSorter();
    }});

    grid.appendChild(tile);
  }});
}}

function jumpToInspector(pNum) {{
  switchAtlasMode('inspector');
  document.getElementById('atlasSearch').value = pNum;
  renderAtlas();
  const card = document.getElementById(`atlas-card-${{pNum}}`);
  if (card) card.scrollIntoView({{ behavior: 'smooth', block: 'start' }});
}}

function resetSlideOrder() {{
  if (!confirm("Reset plate order back to original sequential order 001 - 106?")) return;
  appData.atlas.sort((a, b) => parseInt(a.plate_num) - parseInt(b.plate_num));
  reorderCount = 0;
  document.getElementById('sorterMoveCountBadge').innerText = `Original Order Restored`;
  document.getElementById('sorterMoveCountBadge').className = 'badge badge-cyan';
  renderSlideSorter();
  showToast("Restored original sequential plate order!");
}}

async function saveSlideOrderToSwift() {{
  const orderedNums = appData.atlas.map(p => p.plate_num);
  const btn = document.getElementById('save-order-btn');
  btn.innerText = "⏳ Saving Order...";

  try {{
    const res = await fetch("/api/save-plate-order", {{
      method: "POST",
      headers: {{ "Content-Type": "application/json" }},
      body: JSON.stringify({{ order: orderedNums }})
    }});
    const data = await res.json();
    if (data.status === "ok") {{
      btn.innerText = "✓ Plate Order Saved!";
      btn.classList.add("saved");
      showToast(`Custom order of all 106 plates saved successfully!`);
      setTimeout(() => {{
        btn.innerText = "💾 Save Plate Reorder to Swift";
        btn.classList.remove("saved");
      }}, 3000);
    }} else {{
      alert("Error saving: " + data.message);
      btn.innerText = "💾 Save Plate Reorder to Swift";
    }}
  }} catch (e) {{
    alert("Connection error: " + e);
    btn.innerText = "💾 Save Plate Reorder to Swift";
  }}
}}

// 1B. Detailed Plate Inspector
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
        <div class="plate-viewport" id="viewport-${{p.plate_num}}" onclick="openLightbox('${{p.image_file}}', 'Plate ${{p.plate_num}}: ${{p.title.replace(/'/g, "\\\\'") }}')">
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
// 2. 2 AM CRISIS RENDER
// ==========================================
function renderCrisis() {{
  // 2A. Acute Triage
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
        <div class="viewport-container" onclick="openLightbox('${{spec.image_file}}', '${{spec.title.replace(/'/g, "\\\\'") }}')">
          <img src="${{spec.image_file}}" alt="${{spec.title}}" title="Click to view full size">
          <div class="viewport-caption"><span>Emergency CT Viewport</span><span style="color:#00e5ff;">🔍 Zoom</span></div>
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

  // 2B. BTF ICP Ladder
  const icpGrid = document.getElementById('icpLadderGrid');
  icpGrid.innerHTML = '';
  appData.crisis.icp_tiers.forEach(tier => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    const itemsHtml = tier.interventions.map(it => `<li style="margin-left:18px; margin-bottom:4px; font-size:12px; color:#f1f5f9;">${{it}}</li>`).join('');
    card.innerHTML = `
      <div class="card-header">
        <div>
          <span class="card-title" style="color:#00e5ff;">${{tier.tier}}</span>
          <div style="font-size:12px; color:#94a3b8; margin-top:2px;">${{tier.subtitle}}</div>
        </div>
        <span class="badge badge-cyan">BTF PROTOCOL</span>
      </div>
      <div style="background:#090d15; padding:12px; border-radius:10px; border:1px solid #1e2638;">
        <div style="font-size:11px; font-weight:800; color:#00e5ff; margin-bottom:6px;">MANDATORY STEPWISE INTERVENTIONS:</div>
        <ul>${{itemsHtml}}</ul>
      </div>
      <div style="font-size:11px; color:#f59e0b; background:rgba(245,158,11,0.08); padding:8px 12px; border-radius:8px; border:1px solid rgba(245,158,11,0.2);">
        <strong>Clinical Rationale / Hazard Pearl:</strong> ${{tier.rationale}}
      </div>
    `;
    icpGrid.appendChild(card);
  }});

  // 2C. Reversal Engine
  const revGrid = document.getElementById('reversalEngineGrid');
  revGrid.innerHTML = '';
  appData.crisis.reversals.forEach(rev => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <div>
          <span class="card-title" style="color:#fff;">${{rev.drug}}</span>
          <div style="font-size:12px; color:#00e5ff; font-weight:700; margin-top:2px;">Target: ${{rev.target}}</div>
        </div>
        <span class="badge badge-purple">REVERSAL PROTOCOL</span>
      </div>
      <div style="background:#090d15; padding:12px; border-radius:10px; border:1px solid #1e2638; display:flex; flex-direction:column; gap:6px;">
        <div><strong style="color:#f43f5e;">First-Line Reversal Agent:</strong> <span style="color:#fff;">${{rev.firstLine}}</span></div>
        <div><strong style="color:#00e5ff;">Weight/INR Dosing Protocol:</strong> <span style="color:#cbd5e1;">${{rev.dosing}}</span></div>
      </div>
      <div style="font-size:11px; color:#94a3b8; background:rgba(148,163,184,0.06); padding:8px 12px; border-radius:8px; border:1px solid #1e2638;">
        <strong>Clinical Pharmacokinetics Pearl:</strong> ${{rev.pearl}}
      </div>
    `;
    revGrid.appendChild(card);
  }});

  // 2D. OR Spec Sheets
  const orGrid = document.getElementById('orSetupGrid');
  orGrid.innerHTML = '';
  appData.crisis.or_specs.forEach(spec => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title" style="color:#f59e0b;">${{spec.procedure}}</span>
        <span class="badge badge-amber">OR SETUP SPEC</span>
      </div>
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; background:#090d15; padding:12px; border-radius:10px; border:1px solid #1e2638;">
        <div><strong style="color:#00e5ff; font-size:11px;">PATIENT POSITIONING & MAYFIELD:</strong><div style="font-size:12px; color:#cbd5e1; margin-top:2px;">${{spec.positioning}}</div></div>
        <div><strong style="color:#00e5ff; font-size:11px;">DRILLS, SCREWS & HARDWARE:</strong><div style="font-size:12px; color:#cbd5e1; margin-top:2px;">${{spec.drill}}</div></div>
        <div><strong style="color:#00e5ff; font-size:11px;">HEMOSTASIS & RETRACTORS:</strong><div style="font-size:12px; color:#cbd5e1; margin-top:2px;">${{spec.hemostasis}}</div></div>
        <div><strong style="color:#00e5ff; font-size:11px;">DURAL PATCH & BIOLOGICS:</strong><div style="font-size:12px; color:#cbd5e1; margin-top:2px;">${{spec.duralPatch}}</div></div>
      </div>
      <div style="font-size:11px; color:#94a3b8;"><strong style="color:#fff;">Closure / Drains:</strong> ${{spec.closure}}</div>
    `;
    orGrid.appendChild(card);
  }});

  // 2E. Checklists
  const clGrid = document.getElementById('crisisChecklistGrid');
  clGrid.innerHTML = '';
  appData.crisis.checklists.forEach(cl => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    const stepsHtml = cl.steps.map((st, i) => `
      <div style="display:flex; gap:8px; align-items:flex-start; margin-bottom:4px;">
        <span style="color:#00e5ff; font-weight:800; font-size:12px;">${{i+1}}.</span>
        <span style="color:#f1f5f9; font-size:12px;">${{st}}</span>
      </div>
    `).join('');

    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{cl.title}}</span>
        <span class="badge badge-red">CRITICAL CHECKLIST</span>
      </div>
      <div class="media-card-grid">
        <div class="viewport-container" onclick="openLightbox('${{cl.image_file}}', '${{cl.title.replace(/'/g, "\\\\'") }}')">
          <img src="${{cl.image_file}}" alt="${{cl.title}}">
          <div class="viewport-caption"><span>Reference Diagnostic Plate</span><span style="color:#00e5ff;">🔍 Zoom</span></div>
        </div>
        <div style="display:flex; flex-direction:column; gap:8px; background:#090d15; padding:12px; border-radius:10px; border:1px solid #1e2638;">
          <div class="field-label" style="color:#00e5ff;">Action Steps:</div>
          ${{stepsHtml}}
        </div>
      </div>
    `;
    clGrid.appendChild(card);
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

// ==========================================
// 3. ER CONSULTS & BRAINSTEM RENDER
// ==========================================
function renderConsults() {{
  const grid = document.getElementById('consultsGrid');
  const search = document.getElementById('consultSearch').value.toLowerCase();
  grid.innerHTML = '';

  const list = currentConsultCategory === 'cranial' ? appData.consults.cranial : appData.consults.spine;
  const filtered = list.filter(c => {{
    return c.title.toLowerCase().includes(search) || c.case.toLowerCase().includes(search) || c.shortTitle.toLowerCase().includes(search);
  }});

  filtered.forEach(c => {{
    const card = document.createElement('div');
    card.className = 'studio-card';

    const isMatrixTable = (c.case === 'shuntProxVsDistal');

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
          <div style="font-size:11px; color:#64748b; margin-top:2px;">Case: .${{c.case}} | Category: ${{c.category.toUpperCase()}}</div>
        </div>
        <div style="display:flex; gap:8px; align-items:center;">
          ${{isMatrixTable ? '<span class="badge badge-amber">LARGE-FORMAT MATRIX TABLE</span>' : ''}}
          <span class="badge badge-red">${{c.acuityLabel || 'EMERGENCY'}}</span>
        </div>
      </div>

      <div class="media-card-grid ${{isMatrixTable ? 'fullwidth-table' : ''}}">
        <div>
          <div class="viewport-container" onclick="openLightbox('${{c.image_file}}', '${{c.title.replace(/'/g, "\\\\'") }}')">
            <img src="${{c.image_file}}" alt="${{c.title}}" title="Click to open Fullscreen Lightbox">
            <div class="viewport-caption">
              <span>${{isMatrixTable ? 'High-Definition Clinical Differentiation Matrix' : 'Clinical Scan Plate (' + c.assetImageName + ')'}}</span>
              <span style="color:#00e5ff; font-weight:800;">🔍 Click to Enlarge / Fullscreen</span>
            </div>
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
  const list = currentConsultCategory === 'cranial' ? appData.consults.cranial : appData.consults.spine;
  const c = list.find(x => x.case === cCase);
  if (c) {{
    c.pitfalls.splice(idx, 1);
    renderConsults();
  }}
}}

function addConsultPitfall(cCase) {{
  const list = currentConsultCategory === 'cranial' ? appData.consults.cranial : appData.consults.spine;
  const c = list.find(x => x.case === cCase);
  if (c) {{
    c.pitfalls.push("Catastrophic Pitfall: ");
    renderConsults();
  }}
}}

async function saveConsultToSwift(cCase) {{
  const list = currentConsultCategory === 'cranial' ? appData.consults.cranial : appData.consults.spine;
  const c = list.find(x => x.case === cCase);
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

// Brainstem Interactive Slider & Elevator Render
let currentBrainstemLevel = 0;

function handleBrainstemSliderChange(val) {{
  currentBrainstemLevel = val;
  const stage = appData.consults.brainstem.find(s => s.level === val) || appData.consults.brainstem[0];

  document.getElementById('sliderDepthLabel').innerText = `${{val}} - ${{stage.name}}`;
  const badge = document.getElementById('sliderStatusBadge');
  badge.innerText = stage.statusBadge;
  badge.className = `badge badge-${{stage.badgeColor}}`;

  document.getElementById('readoutPupils').innerText = stage.pupils;
  document.getElementById('readoutMotor').innerText = stage.motor;
  document.getElementById('readoutRespiration').innerText = stage.respiration;

  renderBrainstemElevator();
}}

function renderBrainstemElevator() {{
  const board = document.getElementById('brainstemElevatorBoard');
  board.innerHTML = '';

  appData.consults.brainstem.forEach(st => {{
    const isCollapsed = currentBrainstemLevel >= st.level && st.level > 0;
    const isCurrentFront = currentBrainstemLevel === st.level;

    const stageDiv = document.createElement('div');
    stageDiv.className = `elevator-stage ${{isCurrentFront ? 'active-stage' : ''}} ${{isCollapsed ? 'collapsed' : ''}}`;

    let statusPillHtml = '';
    if (st.level === 0) {{
      statusPillHtml = `<span class="badge badge-green" style="font-weight:900;">${{currentBrainstemLevel === 0 ? '✓ INTACT' : 'COMPROMISED'}}</span>`;
    }} else if (isCurrentFront) {{
      statusPillHtml = `<span class="badge badge-amber" style="font-weight:900; box-shadow:0 0 8px rgba(245,158,11,0.5);">⚡ ACTIVE FRONT</span>`;
    }} else if (isCollapsed) {{
      statusPillHtml = `<span class="badge badge-${{st.badgeColor}}" style="font-weight:900;">▼ COLLAPSED</span>`;
    }} else {{
      statusPillHtml = `<span class="badge badge-green" style="font-weight:900;">✓ INTACT</span>`;
    }}

    stageDiv.innerHTML = `
      <div style="display:flex; flex-direction:column; gap:4px; min-width:240px;">
        <div style="display:flex; align-items:center; gap:8px;">
          <span style="font-size:14px; font-weight:900; color:${{isCurrentFront ? '#00e5ff' : '#fff'}};">${{st.name}}</span>
          ${{statusPillHtml}}
        </div>
        <div style="font-size:11px; color:#00e5ff;">${{st.anatomicalLevel}}</div>
        <div style="font-size:10px; color:#94a3b8;">Trigger Correlate: ${{st.reflexTrigger}}</div>
      </div>
      <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:12px; flex:1; background:#080c14; padding:10px 14px; border-radius:8px; border:1px solid #1a2336;">
        <div>
          <div style="font-size:10px; font-weight:800; color:#00e5ff;">👁️ PUPILLARY LIGHT REFLEX:</div>
          <div style="font-size:11px; color:#cbd5e1; margin-top:2px;">${{st.pupils}}</div>
        </div>
        <div>
          <div style="font-size:10px; font-weight:800; color:#f59e0b;">🏃 MOTOR POSTURING:</div>
          <div style="font-size:11px; color:#cbd5e1; margin-top:2px;">${{st.motor}}</div>
        </div>
        <div>
          <div style="font-size:10px; font-weight:800; color:#f43f5e;">🫁 RESPIRATORY PATTERN:</div>
          <div style="font-size:11px; color:#cbd5e1; margin-top:2px;">${{st.respiration}}</div>
        </div>
      </div>
    `;
    board.appendChild(stageDiv);
  }});
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
        <div class="viewport-container" onclick="openLightbox('${{proc.image_file}}', '${{proc.title.replace(/'/g, "\\\\'") }}')">
          <img src="${{proc.image_file}}" alt="${{proc.title}}">
          <div class="viewport-caption"><span>High-Definition Anatomical Schematic</span><span style="color:#00e5ff;">🔍 Zoom</span></div>
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
try {{
  const savedSize = localStorage.getItem('neurocall_slide_size');
  if (savedSize) setSlideSize(savedSize);
}} catch(e) {{}}
renderSlideSorter();
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
