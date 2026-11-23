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

threshold_specs = []
spec_pattern = r'case "([^"]+)":\s*return EmergencyThresholdSpec\((.*?)\)'
for m in re.finditer(spec_pattern, em_text, re.DOTALL):
    em_id = m.group(1)
    body = m.group(2)
    def get_f(field):
        fm = re.search(rf'{field}:\s*"([^"]+)"', body)
        return fm.group(1) if fm else ""
    threshold_specs.append({
        "id": em_id,
        "title": get_f("title"),
        "thicknessThreshold": get_f("thicknessThreshold"),
        "shiftThreshold": get_f("shiftThreshold"),
        "volumeThreshold": get_f("volumeThreshold"),
        "neurologicalTrigger": get_f("neurologicalTrigger"),
        "operativeProcedure": get_f("operativeProcedure")
    })

crisis_checklists = []
cl_pattern = r'ChecklistCard\(\s*title:\s*"([^"]+)",\s*steps:\s*\[(.*?)\]\s*\)'
for m in re.finditer(cl_pattern, em_text, re.DOTALL):
    cl_title = m.group(1)
    raw_steps = m.group(2)
    steps = [s.strip().strip('"') for s in re.findall(r'"([^"]+)"', raw_steps)]
    crisis_checklists.append({
        "title": cl_title,
        "steps": steps
    })

reversals = []
rev_pattern = r'ReversalCard\(\s*drug:\s*"([^"]+)",\s*mechanism:\s*"([^"]+)",\s*agent:\s*"([^"]+)",\s*dose:\s*"([^"]+)",\s*target:\s*"([^"]+)",\s*badgeColor:\s*([^)]+)\)'
for m in re.finditer(rev_pattern, em_text):
    reversals.append({
        "drug": m.group(1),
        "mechanism": m.group(2),
        "agent": m.group(3),
        "dose": m.group(4),
        "target": m.group(5),
        "badgeColor": m.group(6).replace("Color.", "")
    })

# ==========================================
# 3. PARSE ER CONSULTS
# ==========================================
with open(SWIFT_PATHS["consults"], "r", encoding="utf-8") as f:
    cs_text = f.read()

consult_types = []
for c_match in re.finditer(r'case (\w+) = "([^"]+)"', cs_text):
    consult_types.append((c_match.group(1), c_match.group(2)))

consults_data = []
for c_case, c_raw in consult_types:
    t_m = re.search(rf'public var title: String \{{.*?case \.{c_case}:\s*return "(.*?)".*?\}}', cs_text, re.DOTALL)
    st_m = re.search(rf'public var shortTitle: String \{{.*?case \.{c_case}:\s*return "(.*?)".*?\}}', cs_text, re.DOTALL)
    acuity_m = re.search(rf'public var acuityLabel: String \{{.*?case \.{c_case}:\s*return "(.*?)".*?\}}', cs_text, re.DOTALL)
    plan_m = re.search(rf'public var operativePlan: String \{{.*?case \.{c_case}:\s*return "(.*?)".*?\}}', cs_text, re.DOTALL)
    pearl_m = re.search(rf'public var imagingPearl: String \{{.*?case \.{c_case}:\s*return "(.*?)".*?\}}', cs_text, re.DOTALL)

    pit_m = re.search(rf'public var pitfalls: \[String\] \{{.*?case \.{c_case}:\s*return \[(.*?)\].*?\}}', cs_text, re.DOTALL)
    pitfalls = [s.strip().strip('"') for s in re.findall(r'"([^"]+)"', pit_m.group(1))] if pit_m else []

    tri_m = re.search(rf'public var clinicalTriad: \[String\] \{{.*?case \.{c_case}:\s*return \[(.*?)\].*?\}}', cs_text, re.DOTALL)
    triad = [s.strip().strip('"') for s in re.findall(r'"([^"]+)"', tri_m.group(1))] if tri_m else []

    consults_data.append({
        "case": c_case,
        "title": t_m.group(1) if t_m else c_raw,
        "shortTitle": st_m.group(1) if st_m else c_raw,
        "acuity": acuity_m.group(1) if acuity_m else "EMERGENCY",
        "triad": triad,
        "imagingPearl": pearl_m.group(1) if pearl_m else "",
        "operativePlan": plan_m.group(1) if plan_m else "",
        "pitfalls": pitfalls
    })

# ==========================================
# 4. PARSE BEDSIDE PROCEDURES
# ==========================================
with open(SWIFT_PATHS["procedures"], "r", encoding="utf-8") as f:
    pr_text = f.read()

procedures_steps = []
for sm in re.finditer(r'TrajectoryStepRow\(\s*number:\s*"([^"]+)",\s*title:\s*"([^"]+)",\s*detail:\s*"([^"]+)"\s*\)', pr_text):
    procedures_steps.append({
        "number": sm.group(1),
        "title": sm.group(2),
        "detail": sm.group(3)
    })

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
    "procedures": procedures_steps,
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
    padding: 18px; display: flex; flex-direction: column; gap: 12px;
  }}
  .card-header {{ display: flex; justify-content: space-between; align-items: center; }}
  .card-title {{ font-size: 15px; font-weight: 800; color: #fff; display: flex; align-items: center; gap: 8px; }}
  .badge {{ font-size: 10px; font-weight: 800; padding: 3px 8px; border-radius: 6px; text-transform: uppercase; }}
  .badge-red {{ background: rgba(244,63,94,0.15); color: var(--accent-rose); border: 1px solid rgba(244,63,94,0.3); }}
  .badge-cyan {{ background: rgba(0,229,255,0.15); color: var(--accent-cyan); border: 1px solid rgba(0,229,255,0.3); }}
  .badge-amber {{ background: rgba(245,158,11,0.15); color: var(--accent-amber); border: 1px solid rgba(245,158,11,0.3); }}

  /* Form inputs */
  .edit-input {{
    width: 100%; font-size: 12px; background: #141b27; color: #fff; border: 1px solid #253047;
    border-radius: 6px; padding: 6px 10px; transition: 0.15s;
  }}
  .edit-input:focus {{ outline: none; border-color: var(--accent-cyan); background: #182232; }}
  .edit-textarea {{
    width: 100%; font-size: 12px; background: #141b27; color: #cbd5e1; border: 1px solid #253047;
    border-radius: 6px; padding: 6px 10px; min-height: 48px; line-height: 1.4; resize: vertical;
  }}
  .edit-textarea:focus {{ outline: none; border-color: var(--accent-cyan); background: #182232; }}

  .field-label {{ font-size: 10.5px; font-weight: 800; text-transform: uppercase; color: #64748b; margin-bottom: 2px; }}
  .btn-save-section {{
    background: #0284c7; border: 1px solid #0369a1; color: #fff; font-size: 12px; font-weight: 800;
    padding: 8px 14px; border-radius: 8px; cursor: pointer; transition: 0.15s; display: flex; align-items: center; gap: 6px;
  }}
  .btn-save-section:hover {{ background: #0369a1; }}
  .btn-del-mini {{ background: #7f1d1d; border: 1px solid #991b1b; color: #fecaca; border-radius: 4px; padding: 3px 6px; cursor: pointer; font-size: 11px; }}
  .btn-add-mini {{ background: #1e293b; border: 1px solid #334155; color: #94a3b8; border-radius: 4px; padding: 4px 10px; cursor: pointer; font-size: 11px; font-weight: 700; }}
  .btn-add-mini:hover {{ background: #334155; color: #fff; }}

  /* Atlas specifics (preserved from earlier) */
  .atlas-card {{
    background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 14px;
    display: grid; grid-template-columns: 680px 1fr; gap: 20px; padding: 18px; margin-bottom: 20px;
  }}
  @media (max-width: 1200px) {{ .atlas-card {{ grid-template-columns: 1fr; }} }}
  .image-canvas-container {{ position: relative; width: 100%; border-radius: 10px; overflow: hidden; background: #000; border: 1px solid #2d3b55; }}
  .plate-img {{ width: 100%; height: auto; display: block; }}
  .pin-marker {{
    position: absolute; width: 15px; height: 15px; transform: translate(-50%, -50%);
    border-radius: 50%; color: #000; font-size: 8.5px; font-weight: 900;
    display: flex; align-items: center; justify-content: center;
    box-shadow: 0 0 8px rgba(0,0,0,0.85), 0 0 5px currentColor; border: 1.5px solid #fff; cursor: grab; z-index: 100;
  }}
  .pin-marker:active {{ cursor: grabbing; transform: translate(-50%, -50%) scale(1.4); z-index: 200; box-shadow: 0 0 16px #00e5ff; }}

  .toast {{
    position: fixed; bottom: 24px; right: 24px; background: #0284c7; color: #fff;
    padding: 12px 20px; border-radius: 8px; font-size: 13px; font-weight: 700;
    box-shadow: 0 4px 14px rgba(0,0,0,0.5); display: none; z-index: 2000;
  }}
</style>
</head>
<body>

<header>
  <div class="header-top">
    <div>
      <h1>NeuroCall Full App Studio</h1>
      <div class="header-desc">Dr. Mohit: Live inspection and editing across all 5 clinical pillars. Edits write directly to Swift codebase.</div>
    </div>
  </div>
  <div class="pillar-tabs">
    <button class="tab-btn active" onclick="switchPillar('atlas', this)">🧠 1. Surgical Atlas (106 Plates)</button>
    <button class="tab-btn" onclick="switchPillar('crisis', this)">🚨 2. 2 AM Crisis & ICP Ladders</button>
    <button class="tab-btn" onclick="switchPillar('consults', this)">🩺 3. Frontline ER Consults (16 Modules)</button>
    <button class="tab-btn" onclick="switchPillar('procedures', this)">🎯 4. Bedside Hardware & Trajectories</button>
    <button class="tab-btn" onclick="switchPillar('calculators', this)">🔢 5. Calculators & Scoring</button>
  </div>
</header>

<!-- PILLAR 1: SURGICAL ATLAS -->
<div id="section-atlas" class="section-container active">
  <div style="display:flex; justify-content:space-between; align-items:center; background:#0d121d; padding:12px 18px; border-radius:10px; border:1px solid #1e2638;">
    <input type="text" id="atlasSearch" class="edit-input" style="max-width:320px;" placeholder="Search 106 plates, anatomy, pathology..." oninput="renderAtlas()">
    <div style="font-size:12px; color:#94a3b8;">15px High-Precision Numbered Pins (Drag to Reposition)</div>
  </div>
  <div id="atlasList"></div>
</div>

<!-- PILLAR 2: 2 AM CRISIS -->
<div id="section-crisis" class="section-container">
  <div class="card-header" style="background:#0d121d; padding:12px 18px; border-radius:10px; border:1px solid #1e2638;">
    <div>
      <h2 style="font-size:16px; color:#fff;">2 AM Crisis Cockpit & Operative Thresholds</h2>
      <div style="font-size:11.5px; color:#94a3b8;">BTF Emergency Specifications, Herniation Resuscitation Checklists, and Anticoagulation Reversal</div>
    </div>
  </div>
  <div class="grid-2col" id="crisisThresholdGrid"></div>
  <div style="font-size:14px; font-weight:800; color:var(--accent-cyan); margin-top:10px;">Emergency Herniation & Crisis Checklists</div>
  <div class="grid-2col" id="crisisChecklistGrid"></div>
  <div style="font-size:14px; font-weight:800; color:var(--accent-amber); margin-top:10px;">Emergency Anticoagulation Reversal Protocols</div>
  <div class="grid-2col" id="crisisReversalGrid"></div>
</div>

<!-- PILLAR 3: ER CONSULTS -->
<div id="section-consults" class="section-container">
  <div class="card-header" style="background:#0d121d; padding:12px 18px; border-radius:10px; border:1px solid #1e2638;">
    <div>
      <h2 style="font-size:16px; color:#fff;">Frontline ER Neurosurgical Consults Suite</h2>
      <div style="font-size:11.5px; color:#94a3b8;">16 Clinical Pathways: Diagnostic Triads, Imaging Pearls, Operative Plans, and Pitfalls</div>
    </div>
    <input type="text" id="consultSearch" class="edit-input" style="max-width:280px;" placeholder="Filter consults (e.g. ASDH, Spine)..." oninput="renderConsults()">
  </div>
  <div class="grid-2col" id="consultsGrid"></div>
</div>

<!-- PILLAR 4: BEDSIDE PROCEDURES -->
<div id="section-procedures" class="section-container">
  <div class="card-header" style="background:#0d121d; padding:12px 18px; border-radius:10px; border:1px solid #1e2638;">
    <div>
      <h2 style="font-size:16px; color:#fff;">Bedside Procedural Atlas & Trajectory Guidance</h2>
      <div style="font-size:11.5px; color:#94a3b8;">Stepwise Hardware Insertion, Anatomical Coordinates, and Opening Pressures</div>
    </div>
  </div>
  <div class="grid-2col" id="proceduresGrid"></div>
</div>

<!-- PILLAR 5: CALCULATORS HUB -->
<div id="section-calculators" class="section-container">
  <div class="card-header" style="background:#0d121d; padding:12px 18px; border-radius:10px; border:1px solid #1e2638;">
    <div>
      <h2 style="font-size:16px; color:#fff;">Neurosurgical Calculators & Clinical Scoring Hub</h2>
      <div style="font-size:11.5px; color:#94a3b8;">8 Evidence-Based Grading Systems, Point Criteria, and Surgical Triage Rules</div>
    </div>
  </div>
  <div class="grid-2col" id="calculatorsGrid"></div>
</div>

<div class="toast" id="toast"></div>

<script>
const appData = {app_json};

function showToast(msg) {{
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.style.display = 'block';
  setTimeout(() => {{ t.style.display = 'none'; }}, 2600);
}}

function switchPillar(pillarId, btn) {{
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.querySelectorAll('.section-container').forEach(c => c.classList.remove('active'));
  btn.classList.add('active');
  document.getElementById(`section-${{pillarId}}`).classList.add('active');
}}

// ==========================================
// 1. RENDER ATLAS
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
           style="left: ${{pin.x * 100}}%; top: ${{pin.y * 100}}%; background: var(--accent-cyan);"
           onmousedown="startAtlasPinDrag(event, '${{p.plate_num}}', ${{idx}})">${{idx+1}}</div>
    `).join('');

    const pinRows = p.pins.map((pin, idx) => `
      <div style="background:#141b27; border:1px solid #253047; padding:8px; border-radius:6px; display:flex; flex-direction:column; gap:4px;">
        <div style="display:flex; justify-content:space-between; align-items:center;">
          <span style="font-size:11px; font-weight:bold; color:var(--accent-cyan);">#${{idx+1}}</span>
          <input type="text" class="edit-input" value="${{pin.title}}" onchange="p_updatePinTitle('${{p.plate_num}}', ${{idx}}, this.value)" style="width:200px;" />
          <input type="text" class="edit-input" value="${{pin.structureType}}" onchange="p_updatePinType('${{p.plate_num}}', ${{idx}}, this.value)" style="width:140px; color:var(--accent-amber);" />
          <button class="btn-del-mini" onclick="p_deletePin('${{p.plate_num}}', ${{idx}})">🗑️</button>
        </div>
        <textarea class="edit-textarea" onchange="p_updatePinDesc('${{p.plate_num}}', ${{idx}}, this.value)">${{pin.description}}</textarea>
      </div>
    `).join('');

    card.innerHTML = `
      <div>
        <div class="image-canvas-container" id="canvas-${{p.plate_num}}">
          <img src="${{p.image_file}}" class="plate-img" loading="lazy">
          ${{pinsHtml}}
        </div>
        <div style="margin-top:10px; display:flex; gap:8px;">
          <button class="btn-save-section" onclick="saveAtlasPlate('${{p.plate_num}}')">💾 Save Plate to Swift</button>
        </div>
      </div>
      <div style="display:flex; flex-direction:column; gap:10px;">
        <div style="font-size:11px; font-weight:bold; color:var(--accent-amber);">PLATE ${{p.plate_num}}</div>
        <input type="text" class="edit-input" value="${{p.title}}" onchange="p_updatePlateTitle('${{p.plate_num}}', this.value)" style="font-size:15px; font-weight:800;" />
        <div style="font-size:11px; font-weight:bold; color:#64748b;">Landmark Callouts (${{p.pins.length}} Pins):</div>
        <div style="display:flex; flex-direction:column; gap:6px; max-height:400px; overflow-y:auto;">${{pinRows || '<span style="font-size:11px; color:#64748b; font-style:italic;">No pins</span>'}}</div>
      </div>
    `;
    container.appendChild(card);
  }});
}}

function startAtlasPinDrag(e, plateNum, pinIdx) {{
  e.preventDefault(); e.stopPropagation();
  const plate = appData.atlas.find(p => p.plate_num === plateNum);
  const container = document.getElementById(`canvas-${{plateNum}}`);
  const marker = document.getElementById(`marker-${{plateNum}}-${{pinIdx}}`);

  function onMove(me) {{
    const r = container.getBoundingClientRect();
    let x = Math.max(0.01, Math.min(0.99, (me.clientX - r.left) / r.width));
    let y = Math.max(0.01, Math.min(0.99, (me.clientY - r.top) / r.height));
    marker.style.left = `${{x * 100}}%`;
    marker.style.top = `${{y * 100}}%`;
    plate.pins[pinIdx].x = x;
    plate.pins[pinIdx].y = y;
  }}
  function onUp() {{
    window.removeEventListener('mousemove', onMove);
    window.removeEventListener('mouseup', onUp);
    showToast(`📍 Repositioned Pin #${{pinIdx+1}}. Click 'Save' to commit.`);
  }}
  window.addEventListener('mousemove', onMove);
  window.addEventListener('mouseup', onUp);
}}

function p_updatePlateTitle(num, v) {{ const p = appData.atlas.find(x => x.plate_num === num); if (p) p.title = v; }}
function p_updatePinTitle(num, idx, v) {{ const p = appData.atlas.find(x => x.plate_num === num); if (p && p.pins[idx]) p.pins[idx].title = v; }}
function p_updatePinType(num, idx, v) {{ const p = appData.atlas.find(x => x.plate_num === num); if (p && p.pins[idx]) p.pins[idx].structureType = v; }}
function p_updatePinDesc(num, idx, v) {{ const p = appData.atlas.find(x => x.plate_num === num); if (p && p.pins[idx]) p.pins[idx].description = v; }}
function p_deletePin(num, idx) {{ const p = appData.atlas.find(x => x.plate_num === num); if (p) {{ p.pins.splice(idx, 1); renderAtlas(); }} }}

async function saveAtlasPlate(plateNum) {{
  const plate = appData.atlas.find(p => p.plate_num === plateNum);
  if (!plate) return;
  const res = await fetch('/api/save-plate', {{
    method: 'POST',
    headers: {{ 'Content-Type': 'application/json' }},
    body: JSON.stringify({{
      plate_num: plateNum,
      title: plate.title,
      pins: plate.pins,
      steps: plate.steps,
      hazards: plate.hazards
    }})
  }});
  const r = await res.json();
  if (r.status === 'ok') showToast(`💾 Plate ${{plateNum}} saved directly to Swift code!`);
}}

// ==========================================
// 2. RENDER 2 AM CRISIS
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
        <span class="badge badge-red">BTF MANDATE</span>
      </div>
      <div>
        <div class="field-label">Thickness Threshold:</div>
        <input type="text" class="edit-input" value="${{spec.thicknessThreshold}}" onchange="spec.thicknessThreshold=this.value" />
      </div>
      <div>
        <div class="field-label">Midline Shift Threshold:</div>
        <input type="text" class="edit-input" value="${{spec.shiftThreshold}}" onchange="spec.shiftThreshold=this.value" />
      </div>
      <div>
        <div class="field-label">Neurological Trigger:</div>
        <input type="text" class="edit-input" value="${{spec.neurologicalTrigger}}" onchange="spec.neurologicalTrigger=this.value" />
      </div>
      <div>
        <div class="field-label">Operative Procedure:</div>
        <input type="text" class="edit-input" value="${{spec.operativeProcedure}}" onchange="spec.operativeProcedure=this.value" />
      </div>
      <div style="display:flex; justify-content:flex-end;">
        <button class="btn-save-section" onclick="saveCrisisSpec('${{spec.id}}')">💾 Save Threshold to Swift</button>
      </div>
    `;
    tGrid.appendChild(card);
  }});

  const clGrid = document.getElementById('crisisChecklistGrid');
  clGrid.innerHTML = '';
  appData.crisis.checklists.forEach((cl, clIdx) => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    const stepRows = cl.steps.map((st, sIdx) => `
      <div style="display:flex; gap:8px; align-items:flex-start;">
        <span style="font-size:11px; font-weight:bold; color:var(--accent-cyan); width:16px;">${{sIdx+1}}.</span>
        <textarea class="edit-textarea" onchange="cl.steps[${{sIdx}}]=this.value">${{st}}</textarea>
        <button class="btn-del-mini" onclick="cl.steps.splice(${{sIdx}}, 1); renderCrisis();">🗑️</button>
      </div>
    `).join('');

    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{cl.title}}</span>
        <button class="btn-add-mini" onclick="cl.steps.push('New Emergency Action Step'); renderCrisis();">＋ Add Step</button>
      </div>
      <div style="display:flex; flex-direction:column; gap:8px;">${{stepRows}}</div>
      <div style="display:flex; justify-content:flex-end; margin-top:6px;">
        <button class="btn-save-section" onclick="saveCrisisAll()">💾 Save Checklists to Swift</button>
      </div>
    `;
    clGrid.appendChild(card);
  }});

  const rGrid = document.getElementById('crisisReversalGrid');
  rGrid.innerHTML = '';
  appData.crisis.reversals.forEach((r, idx) => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title" style="color:var(--accent-amber);">${{r.drug}} Reversal</span>
        <span class="badge badge-amber">${{r.agent}}</span>
      </div>
      <div>
        <div class="field-label">Mechanism:</div>
        <input type="text" class="edit-input" value="${{r.mechanism}}" onchange="r.mechanism=this.value" />
      </div>
      <div>
        <div class="field-label">Emergent Dosing Protocol:</div>
        <textarea class="edit-textarea" onchange="r.dose=this.value">${{r.dose}}</textarea>
      </div>
      <div>
        <div class="field-label">Therapeutic Reversal Target:</div>
        <input type="text" class="edit-input" value="${{r.target}}" onchange="r.target=this.value" />
      </div>
    `;
    rGrid.appendChild(card);
  }});
}}

async function saveCrisisSpec(specId) {{
  const spec = appData.crisis.thresholds.find(s => s.id === specId);
  const res = await fetch('/api/save-crisis', {{
    method: 'POST',
    headers: {{ 'Content-Type': 'application/json' }},
    body: JSON.stringify({{ spec_id: specId, spec: spec }})
  }});
  const r = await res.json();
  if (r.status === 'ok') showToast(`💾 2 AM Crisis (${{specId}}) saved to EmergencyProtocolsView.swift!`);
}}

async function saveCrisisAll() {{
  const res = await fetch('/api/save-crisis', {{
    method: 'POST',
    headers: {{ 'Content-Type': 'application/json' }},
    body: JSON.stringify({{ checklists: appData.crisis.checklists }})
  }});
  const r = await res.json();
  if (r.status === 'ok') showToast(`💾 All Crisis Checklists saved to EmergencyProtocolsView.swift!`);
}}

// ==========================================
// 3. RENDER ER CONSULTS
// ==========================================
function renderConsults() {{
  const grid = document.getElementById('consultsGrid');
  const search = document.getElementById('consultSearch').value.toLowerCase();
  grid.innerHTML = '';

  const filtered = appData.consults.filter(c => {{
    return c.title.toLowerCase().includes(search) || c.case.toLowerCase().includes(search);
  }});

  filtered.forEach(c => {{
    const card = document.createElement('div');
    card.className = 'studio-card';

    const pitfallsRows = c.pitfalls.map((pit, idx) => `
      <div style="display:flex; gap:6px; align-items:flex-start;">
        <span style="font-size:11px; color:var(--accent-rose);">⚠️</span>
        <textarea class="edit-textarea" onchange="c.pitfalls[${{idx}}]=this.value" style="color:#fda4af;">${{pit}}</textarea>
        <button class="btn-del-mini" onclick="c.pitfalls.splice(${{idx}}, 1); renderConsults();">🗑️</button>
      </div>
    `).join('');

    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">${{c.title}}</span>
        <span class="badge badge-red">${{c.acuity}}</span>
      </div>
      <div>
        <div class="field-label">Full Module Title:</div>
        <input type="text" class="edit-input" value="${{c.title}}" onchange="c.title=this.value" />
      </div>
      <div>
        <div class="field-label">Short Carousel Title:</div>
        <input type="text" class="edit-input" value="${{c.shortTitle}}" onchange="c.shortTitle=this.value" />
      </div>
      <div>
        <div class="field-label">Imaging Diagnostic Pearl:</div>
        <textarea class="edit-textarea" onchange="c.imagingPearl=this.value">${{c.imagingPearl}}</textarea>
      </div>
      <div>
        <div class="field-label">Definitive Operative Plan:</div>
        <textarea class="edit-textarea" onchange="c.operativePlan=this.value">${{c.operativePlan}}</textarea>
      </div>
      <div>
        <div class="field-label" style="display:flex; justify-content:space-between; align-items:center;">
          <span>Catastrophic Pitfalls (${{c.pitfalls.length}}):</span>
          <button class="btn-add-mini" onclick="c.pitfalls.push('New Catastrophic Pitfall'); renderConsults();">＋ Add Pitfall</button>
        </div>
        <div style="display:flex; flex-direction:column; gap:6px; margin-top:4px;">${{pitfallsRows}}</div>
      </div>
      <div style="display:flex; justify-content:flex-end; margin-top:6px;">
        <button class="btn-save-section" onclick="saveConsult('${{c.case}}')">💾 Save Consult to Swift</button>
      </div>
    `;
    grid.appendChild(card);
  }});
}}

async function saveConsult(cCase) {{
  const c = appData.consults.find(x => x.case === cCase);
  const res = await fetch('/api/save-consult', {{
    method: 'POST',
    headers: {{ 'Content-Type': 'application/json' }},
    body: JSON.stringify({{ case: cCase, data: c }})
  }});
  const r = await res.json();
  if (r.status === 'ok') showToast(`💾 ER Consult (${{cCase}}) saved to ERConsultsView.swift!`);
}}

// ==========================================
// 4. RENDER PROCEDURES
// ==========================================
function renderProcedures() {{
  const grid = document.getElementById('proceduresGrid');
  grid.innerHTML = '';

  appData.procedures.forEach((step, idx) => {{
    const card = document.createElement('div');
    card.className = 'studio-card';
    card.innerHTML = `
      <div class="card-header">
        <span class="card-title">Trajectory Step ${{step.number}}: ${{step.title}}</span>
        <span class="badge badge-cyan">BEDSIDE PROTOCOL</span>
      </div>
      <div>
        <div class="field-label">Step Title:</div>
        <input type="text" class="edit-input" value="${{step.title}}" onchange="step.title=this.value" />
      </div>
      <div>
        <div class="field-label">Anatomical Trajectory / Depth Detail:</div>
        <textarea class="edit-textarea" onchange="step.detail=this.value" style="min-height:70px;">${{step.detail}}</textarea>
      </div>
      <div style="display:flex; justify-content:flex-end;">
        <button class="btn-save-section" onclick="saveProcedureStep('${{step.number}}', '${{step.title}}')">💾 Save Step to Swift</button>
      </div>
    `;
    grid.appendChild(card);
  }});
}}

async function saveProcedureStep(stepNum, stepTitle) {{
  const s = appData.procedures.find(x => x.number === stepNum);
  const res = await fetch('/api/save-procedure', {{
    method: 'POST',
    headers: {{ 'Content-Type': 'application/json' }},
    body: JSON.stringify({{ number: stepNum, old_title: stepTitle, title: s.title, detail: s.detail }})
  }});
  const r = await res.json();
  if (r.status === 'ok') showToast(`💾 Bedside Step ${{stepNum}} saved to NeurosurgicalProceduresView.swift!`);
}}

// ==========================================
// 5. RENDER CALCULATORS
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
        <div class="field-label">Clinical Target & Surgical Stratification:</div>
        <textarea class="edit-textarea" readonly style="background:#090d15; color:var(--accent-cyan);">${{calc.target}}</textarea>
      </div>
      <div>
        <div class="field-label">Evidence Citation:</div>
        <input type="text" class="edit-input" readonly value="${{calc.evidence}}" style="background:#090d15; color:#64748b;" />
      </div>
    `;
    grid.appendChild(card);
  }});
}}

// Initial load
renderAtlas();
renderCrisis();
renderConsults();
renderProcedures();
renderCalculators();
</script>
</body>
</html>"""

with open(r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector\index.html", "w", encoding="utf-8") as f:
    f.write(html_template)

print("NeuroCall Full App Studio successfully compiled into index.html!")
