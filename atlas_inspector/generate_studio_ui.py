import json
import re
import os

data_path = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift"
view_path = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift"

with open(data_path, "r", encoding="utf-8") as f:
    data_text = f.read()

with open(view_path, "r", encoding="utf-8") as f:
    view_text = f.read()

sec_c = data_text[data_text.find("public var callouts: [SurgicalCallout]"):data_text.find("public var steps: [ApproachSequentialStep]")]
sec_s = data_text[data_text.find("public var steps: [ApproachSequentialStep]"):data_text.find("public var catastrophicHazards: [String]")]
sec_h = data_text[data_text.find("public var catastrophicHazards: [String]")]

# Extract titles from PhotorealisticSurgicalAtlasView.swift
titles_map = {}
t_start = view_text.find("public var title: String {")
if t_start != -1:
    ic_start = view_text.find("public var iconName: String {", t_start)
    t_sec = view_text[t_start:ic_start] if ic_start != -1 else view_text[t_start:]
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
            
            raw_color = color_m.group(1).replace("ObsidianTheme.", "").replace("Color.", "").strip() if color_m else "neonAmber"
            if raw_color == "red": raw_color = "neonRed"
            if raw_color == "purple": raw_color = "neonPurple"

            pins.append({
                "id": f"pin_{p_str}_{idx+1}",
                "num": idx + 1,
                "title": title_m.group(1) if title_m else "Landmark",
                "structureType": type_m.group(1) if type_m else "ANATOMICAL LANDMARK",
                "color": raw_color,
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
        batch_tag = "Pending 047-106"

    plates_data.append({
        "plate_num": p_str,
        "title": plate_title,
        "batch_tag": batch_tag,
        "image_file": f"/plates/plate_{p_str}.jpg",
        "pins": pins,
        "steps": steps,
        "hazards": hazards
    })

plates_json = json.dumps(plates_data, indent=2)

html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NeuroCall Atlas Studio — Visual Drag-and-Drop & Text Editor</title>
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
  }}
  * {{ box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }}
  body {{ background: var(--bg-dark); color: var(--text-primary); padding: 20px; }}
  header {{
    max-width: 1540px; margin: 0 auto 16px auto;
    background: #0d121d; border: 1px solid var(--border-color); border-radius: 12px; padding: 16px 20px;
    display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px;
  }}
  h1 {{ font-size: 20px; font-weight: 800; color: #fff; display: flex; align-items: center; gap: 8px; }}
  .header-desc {{ font-size: 12px; color: var(--text-secondary); margin-top: 4px; }}
  .toolbar {{ display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }}
  .search-box {{
    background: #161f30; border: 1px solid #2d3b55; border-radius: 8px;
    padding: 7px 12px; color: #fff; font-size: 13px; min-width: 260px;
  }}
  .filter-btn {{
    background: #161f30; border: 1px solid #2d3b55; border-radius: 8px;
    padding: 6px 12px; color: #94a3b8; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.15s;
  }}
  .filter-btn.active, .filter-btn:hover {{ background: var(--accent-cyan); color: #000; border-color: var(--accent-cyan); }}
  .main-grid {{ display: flex; flex-direction: column; gap: 24px; max-width: 1540px; margin: 0 auto; }}
  .plate-card {{
    background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 14px;
    display: grid; grid-template-columns: 680px 1fr; gap: 20px; padding: 18px;
  }}
  @media (max-width: 1200px) {{ .plate-card {{ grid-template-columns: 1fr; }} }}
  .image-wrapper {{ display: flex; flex-direction: column; gap: 10px; }}
  .image-canvas-container {{
    position: relative; width: 100%; border-radius: 10px; overflow: hidden;
    background: #000; border: 1px solid #2d3b55; user-select: none;
  }}
  .plate-img {{ width: 100%; height: auto; display: block; }}
  
  /* Compact 15px Numbered Circles (~50% smaller) */
  .pin-marker {{
    position: absolute;
    width: 15px;
    height: 15px;
    transform: translate(-50%, -50%);
    border-radius: 50%;
    color: #000;
    font-size: 8.5px;
    font-weight: 900;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 0 8px rgba(0,0,0,0.85), 0 0 5px currentColor;
    border: 1.5px solid #fff;
    cursor: grab;
    z-index: 100;
    transition: box-shadow 0.15s, transform 0.1s;
  }}
  .pin-marker:active {{
    cursor: grabbing;
    transform: translate(-50%, -50%) scale(1.4);
    z-index: 200;
    box-shadow: 0 0 16px #00e5ff;
  }}

  .action-toolbar {{ display: flex; gap: 8px; }}
  .btn-action {{
    flex: 1; padding: 8px 12px; border-radius: 8px; font-size: 12px; font-weight: 700;
    border: 1px solid #334155; background: #1e293b; color: #f8fafc; cursor: pointer; transition: 0.15s;
  }}
  .btn-action:hover {{ background: #334155; }}
  .btn-save {{ background: #0284c7; border-color: #0284c7; color: #fff; }}
  .btn-save:hover {{ background: #0369a1; }}
  .btn-danger {{ background: #7f1d1d; border-color: #991b1b; color: #fecaca; }}
  .btn-danger:hover {{ background: #991b1b; }}
  .details-container {{ display: flex; flex-direction: column; gap: 12px; overflow-y: auto; max-height: 800px; padding-right: 6px; }}
  .card-top {{ display: flex; justify-content: space-between; align-items: center; }}
  .plate-num {{ font-size: 11px; font-weight: 900; letter-spacing: 1.5px; color: var(--accent-amber); }}
  .tag-badge {{ font-size: 10px; font-weight: 700; padding: 2px 8px; border-radius: 6px; background: #1e293b; color: #94a3b8; }}
  
  .title-input-row {{ display: flex; gap: 8px; align-items: center; }}
  .title-input {{
    flex: 1; font-size: 16px; font-weight: 800; background: #161f30; color: #fff;
    border: 1px solid #2d3b55; border-radius: 6px; padding: 6px 10px;
  }}
  .title-input:focus {{ outline: none; border-color: var(--accent-cyan); }}

  .section-header-row {{ display: flex; justify-content: space-between; align-items: center; margin-top: 4px; }}
  .section-label {{ font-size: 11px; font-weight: 800; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px; }}

  .pins-list {{ display: flex; flex-direction: column; gap: 8px; }}
  .pin-item {{
    background: #141b27; border: 1px solid #253047; border-left: 4px solid #fff;
    border-radius: 8px; padding: 10px; display: flex; flex-direction: column; gap: 6px;
  }}
  .pin-title-row {{ display: flex; justify-content: space-between; align-items: center; gap: 8px; }}
  .pin-edit-title {{ font-size: 12px; font-weight: 800; background: #1c2638; color: #fff; border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; flex: 1; }}
  .pin-edit-type {{ font-size: 9.5px; font-weight: 700; background: #1c2638; color: var(--accent-cyan); border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; width: 140px; }}
  .pin-edit-desc {{ font-size: 11px; background: #1c2638; color: #cbd5e1; border: 1px solid #3b4c68; border-radius: 4px; padding: 4px 6px; height: 38px; width: 100%; }}
  .pin-edit-pearl {{ font-size: 10.5px; background: #1c2638; color: var(--accent-amber); border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; width: 100%; }}
  .btn-delete-pin {{
    background: transparent; border: none; color: #ef4444; font-size: 13px; cursor: pointer; padding: 2px 6px; border-radius: 4px;
  }}
  .btn-delete-pin:hover {{ background: #7f1d1d; }}

  .steps-box, .hazards-box {{
    background: #141b27; border: 1px solid #253047; border-radius: 8px; padding: 10px;
    display: flex; flex-direction: column; gap: 8px;
  }}
  .box-title {{ font-size: 11px; font-weight: 900; letter-spacing: 0.8px; text-transform: uppercase; display: flex; justify-content: space-between; align-items: center; }}
  .step-row {{ display: flex; gap: 8px; align-items: flex-start; }}
  .step-title-input {{ width: 160px; font-size: 11px; font-weight: 700; background: #1c2638; color: #fff; border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; }}
  .step-detail-input {{ flex: 1; font-size: 11px; background: #1c2638; color: #cbd5e1; border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; height: 40px; }}
  .hazard-row {{ display: flex; gap: 8px; align-items: flex-start; }}
  .hazard-input {{ flex: 1; font-size: 11px; background: #1c2638; color: #fda4af; border: 1px solid #3b4c68; border-radius: 4px; padding: 3px 6px; height: 36px; }}
  .btn-mini-delete {{ background: #7f1d1d; border: 1px solid #991b1b; color: #fecaca; border-radius: 4px; padding: 3px 6px; cursor: pointer; font-size: 10px; }}
  .btn-mini-add {{ background: #1e293b; border: 1px solid #334155; color: #94a3b8; border-radius: 4px; padding: 3px 8px; cursor: pointer; font-size: 10px; font-weight: 700; }}
  .btn-mini-add:hover {{ background: #334155; color: #fff; }}

  .toast {{
    position: fixed; bottom: 24px; right: 24px; background: #0284c7; color: #fff;
    padding: 12px 20px; border-radius: 8px; font-size: 13px; font-weight: 700;
    box-shadow: 0 4px 14px rgba(0,0,0,0.4); display: none; z-index: 1000;
  }}
</style>
</head>
<body>

<header>
  <div>
    <h1>NeuroCall Surgical Atlas Studio</h1>
    <div class="header-desc">
      Dr. Mohit: Drag pins on artwork, edit text boxes & titles directly, or delete empty sections. Click <strong>"Save Changes to Swift"</strong> per plate.
    </div>
  </div>
  <div class="toolbar">
    <input type="text" id="searchInput" class="search-box" placeholder="Search plates, landmarks, pathology..." oninput="renderPlates()">
    <button class="filter-btn active" onclick="setFilter('ALL', this)">All (106)</button>
    <button class="filter-btn" onclick="setFilter('Dr. Mohit Calibrated (001-025)', this)">Calibrated (001-025)</button>
    <button class="filter-btn" onclick="setFilter('Reviewed 026-046', this)">Plates 026-046</button>
    <button class="filter-btn" onclick="setFilter('Pending 047-106', this)">Pending 047-106</button>
  </div>
</header>

<div class="main-grid" id="plateGrid"></div>
<div class="toast" id="toast"></div>

<script>
let plates = {plates_json};
let currentFilter = 'ALL';
let activeDropPlate = null;

function getColorHex(colorName) {{
  const map = {{
    'neonAmber': '#f59e0b',
    'neonCyan': '#00e5ff',
    'neonRose': '#f43f5e',
    'neonGreen': '#10b981',
    'neonEmerald': '#059669',
    'neonPurple': '#a855f7',
    'neonRed': '#ef4444',
    'neonBlue': '#3b82f6'
  }};
  return map[colorName] || '#00e5ff';
}}

function showToast(msg) {{
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.style.display = 'block';
  setTimeout(() => {{ t.style.display = 'none'; }}, 2500);
}}

function renderPlates() {{
  const grid = document.getElementById('plateGrid');
  const search = document.getElementById('searchInput').value.toLowerCase();
  grid.innerHTML = '';

  const filtered = plates.filter(p => {{
    const matchesFilter = currentFilter === 'ALL' || p.batch_tag === currentFilter;
    const matchesSearch = p.plate_num.includes(search) || 
                          p.title.toLowerCase().includes(search) || 
                          p.pins.some(pin => pin.title.toLowerCase().includes(search) || pin.description.toLowerCase().includes(search));
    return matchesFilter && matchesSearch;
  }});

  filtered.forEach(p => {{
    const card = document.createElement('div');
    card.className = 'plate-card';
    card.id = `plate-card-${{p.plate_num}}`;

    // Markers on image (compact 15px)
    let pinMarkersHtml = p.pins.map((pin, idx) => {{
      const hex = getColorHex(pin.color);
      return `<div class="pin-marker" id="marker-${{p.plate_num}}-${{idx}}" 
                   style="left: ${{pin.x * 100}}%; top: ${{pin.y * 100}}%; background: ${{hex}};" 
                   onmousedown="startPinDrag(event, '${{p.plate_num}}', ${{idx}})" 
                   title="Pin ${{idx+1}}: ${{pin.title}} (Drag to reposition)">${{idx+1}}</div>`;
    }}).join('');

    // Pins list
    let pinsListHtml = p.pins.length === 0 ? '<div style="color: #64748b; font-size: 11px; font-style: italic; padding: 6px;">Zero pins on this plate (100% clean image). Click "+ Drop Pin" to place a landmark.</div>' : p.pins.map((pin, idx) => {{
      const hex = getColorHex(pin.color);
      return `
        <div class="pin-item" id="item-${{p.plate_num}}-${{idx}}" style="border-left-color: ${{hex}}">
          <div class="pin-title-row">
            <span style="font-size:11px; font-weight:900; color:#fff;">#${{idx+1}}</span>
            <input type="text" class="pin-edit-title" value="${{pin.title}}" onchange="updatePinTitle('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="Landmark Title" />
            <input type="text" class="pin-edit-type" value="${{pin.structureType}}" onchange="updatePinType('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="STRUCTURE TYPE" />
            <span class="coord-pill" id="coord-${{p.plate_num}}-${{idx}}" style="font-size:10px; color:#94a3b8; font-family:monospace;">X:${{(pin.x*100).toFixed(1)}}% Y:${{(pin.y*100).toFixed(1)}}%</span>
            <button class="btn-delete-pin" onclick="deletePin('${{p.plate_num}}', ${{idx}})" title="Delete this pin">🗑️</button>
          </div>
          <textarea class="pin-edit-desc" onchange="updatePinDesc('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="Landmark anatomic description...">${{pin.description}}</textarea>
          <input type="text" class="pin-edit-pearl" value="${{pin.surgicalPearl || ''}}" onchange="updatePinPearl('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="★ Surgical Pearl (optional)" />
        </div>
      `;
    }}).join('');

    // Steps HTML (only if steps exist, or allow add)
    let stepsContentHtml = '';
    if (p.steps && p.steps.length > 0) {{
      const stepItems = p.steps.map((s, idx) => `
        <div class="step-row">
          <span style="font-size:11px; font-weight:bold; color:var(--accent-cyan); width:18px;">${{s.step}}.</span>
          <input type="text" class="step-title-input" value="${{s.title}}" onchange="updateStepTitle('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="Step Title" />
          <textarea class="step-detail-input" onchange="updateStepDetail('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="Dissection details...">${{s.detail}}</textarea>
          <button class="btn-mini-delete" onclick="deleteStep('${{p.plate_num}}', ${{idx}})">🗑️</button>
        </div>
      `).join('');
      stepsContentHtml = `
        <div class="steps-box">
          <div class="box-title" style="color: var(--accent-cyan);">
            <span>Dissection Sequence (${{p.steps.length}} Steps)</span>
            <div style="display:flex; gap:6px;">
              <button class="btn-mini-add" onclick="addStep('${{p.plate_num}}')">＋ Add Step</button>
              <button class="btn-mini-delete" onclick="clearAllSteps('${{p.plate_num}}')">🚫 Clear Section</button>
            </div>
          </div>
          ${{stepItems}}
        </div>
      `;
    }} else {{
      stepsContentHtml = `
        <div style="display:flex; justify-content:space-between; align-items:center; background:#101726; padding:8px 12px; border-radius:6px; border:1px dashed #23314d;">
          <span style="font-size:11px; color:#64748b; font-style:italic;">Dissection sequence: (Section removed / blank)</span>
          <button class="btn-mini-add" onclick="addStep('${{p.plate_num}}')">＋ Add Dissection Sequence</button>
        </div>
      `;
    }}

    // Hazards HTML (only if hazards exist, or allow add)
    let hazardsContentHtml = '';
    if (p.hazards && p.hazards.length > 0) {{
      const hazardItems = p.hazards.map((h, idx) => `
        <div class="hazard-row">
          <span style="font-size:11px; color:var(--accent-rose);">⚠️</span>
          <textarea class="hazard-input" onchange="updateHazard('${{p.plate_num}}', ${{idx}}, this.value)" placeholder="Catastrophic hazard description...">${{h}}</textarea>
          <button class="btn-mini-delete" onclick="deleteHazard('${{p.plate_num}}', ${{idx}})">🗑️</button>
        </div>
      `).join('');
      hazardsContentHtml = `
        <div class="hazards-box">
          <div class="box-title" style="color: var(--accent-rose);">
            <span>Catastrophic Hazards (${{p.hazards.length}} Hazards)</span>
            <div style="display:flex; gap:6px;">
              <button class="btn-mini-add" onclick="addHazard('${{p.plate_num}}')">＋ Add Hazard</button>
              <button class="btn-mini-delete" onclick="clearAllHazards('${{p.plate_num}}')">🚫 Clear Section</button>
            </div>
          </div>
          ${{hazardItems}}
        </div>
      `;
    }} else {{
      hazardsContentHtml = `
        <div style="display:flex; justify-content:space-between; align-items:center; background:#101726; padding:8px 12px; border-radius:6px; border:1px dashed #23314d;">
          <span style="font-size:11px; color:#64748b; font-style:italic;">Catastrophic hazards: (Section removed / blank)</span>
          <button class="btn-mini-add" onclick="addHazard('${{p.plate_num}}')">＋ Add Operative Hazard</button>
        </div>
      `;
    }}

    card.innerHTML = `
      <div class="image-wrapper">
        <div class="image-canvas-container" id="canvas-${{p.plate_num}}" onclick="handleCanvasClick(event, '${{p.plate_num}}')">
          <img src="${{p.image_file}}" class="plate-img" alt="${{p.title}}" loading="lazy">
          ${{pinMarkersHtml}}
        </div>
        <div class="action-toolbar">
          <button class="btn-action" onclick="enableDropMode('${{p.plate_num}}')">＋ Drop Pin</button>
          <button class="btn-action btn-danger" onclick="clearAllPins('${{p.plate_num}}')">🚫 Clear All Pins</button>
          <button class="btn-action btn-save" onclick="savePlate('${{p.plate_num}}')">💾 Save Changes to Swift</button>
        </div>
      </div>
      <div class="details-container">
        <div class="card-top">
          <span class="plate-num">PLATE ${{p.plate_num}}</span>
          <span class="tag-badge">${{p.batch_tag}}</span>
        </div>
        <div class="title-input-row">
          <input type="text" class="title-input" value="${{p.title}}" onchange="updatePlateTitle('${{p.plate_num}}', this.value)" placeholder="Plate Title" />
        </div>
        <div class="section-header-row">
          <span class="section-label">Interactive Landmarks (${{p.pins.length}} Pins — Drag on image):</span>
        </div>
        <div class="pins-list" id="pins-list-${{p.plate_num}}">${{pinsListHtml}}</div>
        
        ${{stepsContentHtml}}
        ${{hazardsContentHtml}}
      </div>
    `;
    grid.appendChild(card);
  }});
}}

// Pin Dragging
function startPinDrag(e, plateNum, pinIndex) {{
  e.preventDefault();
  e.stopPropagation();
  const plate = plates.find(p => p.plate_num === plateNum);
  const container = document.getElementById(`canvas-${{plateNum}}`);
  const marker = document.getElementById(`marker-${{plateNum}}-${{pinIndex}}`);
  const coordPill = document.getElementById(`coord-${{plateNum}}-${{pinIndex}}`);

  function onMouseMove(moveEvent) {{
    const rect = container.getBoundingClientRect();
    let x = (moveEvent.clientX - rect.left) / rect.width;
    let y = (moveEvent.clientY - rect.top) / rect.height;
    x = Math.max(0.01, Math.min(0.99, x));
    y = Math.max(0.01, Math.min(0.99, y));

    marker.style.left = `${{x * 100}}%`;
    marker.style.top = `${{y * 100}}%`;
    if (coordPill) coordPill.textContent = `X:${{(x*100).toFixed(1)}}% Y:${{(y*100).toFixed(1)}}%`;

    plate.pins[pinIndex].x = x;
    plate.pins[pinIndex].y = y;
  }}

  function onMouseUp() {{
    window.removeEventListener('mousemove', onMouseMove);
    window.removeEventListener('mouseup', onMouseUp);
    showToast(`📍 Repositioned Pin #${{pinIndex+1}}. Click 'Save Changes' to write to Swift.`);
  }}

  window.addEventListener('mousemove', onMouseMove);
  window.addEventListener('mouseup', onMouseUp);
}}

// Update Helpers
function updatePlateTitle(plateNum, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate) {{ plate.title = val; showToast(`✏️ Updated title for Plate ${{plateNum}}`); }}
}}
function updatePinTitle(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.pins[idx]) plate.pins[idx].title = val;
}}
function updatePinType(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.pins[idx]) plate.pins[idx].structureType = val;
}}
function updatePinDesc(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.pins[idx]) plate.pins[idx].description = val;
}}
function updatePinPearl(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.pins[idx]) plate.pins[idx].surgicalPearl = val;
}}
function deletePin(plateNum, pinIndex) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.pins.splice(pinIndex, 1);
  renderPlates();
  showToast(`🗑️ Removed pin from Plate ${{plateNum}}. Click 'Save' to commit.`);
}}
function clearAllPins(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  if (!confirm(`Clear all pins from Plate ${{plateNum}}?`)) return;
  plate.pins = [];
  renderPlates();
  showToast(`🚫 Cleared all pins from Plate ${{plateNum}}!`);
}}

// Steps Helpers
function updateStepTitle(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.steps[idx]) plate.steps[idx].title = val;
}}
function updateStepDetail(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.steps[idx]) plate.steps[idx].detail = val;
}}
function deleteStep(plateNum, idx) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.steps.splice(idx, 1);
  plate.steps.forEach((s, i) => s.step = i + 1);
  renderPlates();
  showToast(`🗑️ Deleted step from Plate ${{plateNum}}`);
}}
function clearAllSteps(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.steps = [];
  renderPlates();
  showToast(`🚫 Cleared dissection steps from Plate ${{plateNum}}`);
}}
function addStep(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  if (!plate.steps) plate.steps = [];
  plate.steps.push({{
    step: plate.steps.length + 1,
    title: "New Dissection Step",
    detail: "Enter surgical corridor / exposure details here."
  }});
  renderPlates();
  showToast(`＋ Added Step ${{plate.steps.length}} to Plate ${{plateNum}}`);
}}

// Hazards Helpers
function updateHazard(plateNum, idx, val) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (plate && plate.hazards) plate.hazards[idx] = val;
}}
function deleteHazard(plateNum, idx) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.hazards.splice(idx, 1);
  renderPlates();
  showToast(`🗑️ Deleted hazard from Plate ${{plateNum}}`);
}}
function clearAllHazards(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.hazards = [];
  renderPlates();
  showToast(`🚫 Cleared hazards from Plate ${{plateNum}}`);
}}
function addHazard(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  if (!plate.hazards) plate.hazards = [];
  plate.hazards.push("MAJOR CATASTROPHIC PITFALL: Enter hazard description here.");
  renderPlates();
  showToast(`＋ Added hazard to Plate ${{plateNum}}`);
}}

// Drop Pin
function enableDropMode(plateNum) {{
  activeDropPlate = plateNum;
  showToast(`🎯 Click anywhere on Plate ${{plateNum}} artwork to drop a new pin.`);
}}
function handleCanvasClick(e, plateNum) {{
  if (activeDropPlate !== plateNum) return;
  activeDropPlate = null;
  const container = document.getElementById(`canvas-${{plateNum}}`);
  const rect = container.getBoundingClientRect();
  const x = Math.max(0.01, Math.min(0.99, (e.clientX - rect.left) / rect.width));
  const y = Math.max(0.01, Math.min(0.99, (e.clientY - rect.top) / rect.height));
  const title = prompt("Enter Landmark Title:", "Anatomical Target");
  if (!title) return;

  const plate = plates.find(p => p.plate_num === plateNum);
  plate.pins.push({{
    id: `pin_${{plateNum}}_${{plate.pins.length + 1}}`,
    num: plate.pins.length + 1,
    title: title,
    structureType: "SURGICAL TARGET",
    color: "neonCyan",
    x: x,
    y: y,
    description: "Verified anatomical target.",
    surgicalPearl: ""
  }});
  renderPlates();
  showToast(`✅ Dropped new pin on Plate ${{plateNum}}!`);
}}

// Save to Swift
async function savePlate(plateNum) {{
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;

  try {{
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
    const result = await res.json();
    if (result.status === 'ok') {{
      showToast(`💾 Plate ${{plateNum}} saved directly to Swift code!`);
    }} else {{
      alert("Error saving: " + result.message);
    }}
  }} catch (err) {{
    alert("Connection error to server: " + err);
  }}
}}

function setFilter(filter, btn) {{
  currentFilter = filter;
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  renderPlates();
}}

// Initial render
renderPlates();
</script>
</body>
</html>"""

output_path = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector\index.html"
with open(output_path, "w", encoding="utf-8") as f:
    f.write(html_template)

print("Atlas Studio interactive drag-and-drop & text editor UI generated successfully!")
