import json
import re
import os

swift_path = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift"
with open(swift_path, "r", encoding="utf-8") as f:
    text = f.read()

sec_c = text[text.find("public var callouts: [SurgicalCallout]"):text.find("public var steps: [ApproachSequentialStep]")]
sec_s = text[text.find("public var steps: [ApproachSequentialStep]"):text.find("public var catastrophicHazards: [String]")]
sec_h = text[text.find("public var catastrophicHazards: [String]")]

titles_map = {}
enum_m = re.search(r"public var title: String \{(.*?)\n    \}", text, re.DOTALL)
if enum_m:
    for m in re.finditer(r'case \.plate(\d+):\s*return "(.*?)"', enum_m.group(1)):
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
                "color": color_m.group(1).replace("ObsidianTheme.", "").replace("Color.", "") if color_m else "neonAmber",
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
        hazards = [h for h in h_strings if h.strip()]

    plate_title = titles_map.get(p_str, f"Plate {p_str}")
    if plate_title == f"Plate {p_str}" and pins:
        plate_title = f"Plate {p_str}: {pins[0]['title']}"

    batch_tag = "Catalog Core"
    if 1 <= i <= 42:
        batch_tag = "Master Calibrated (001-042)"
    elif p_str in ["087", "058", "086", "088", "089"]:
        batch_tag = "Batch 4 Streamlined"

    plates_data.append({
        "plate_num": p_str,
        "title": plate_title,
        "image_file": f"plates/plate_{p_str}.jpg",
        "batch_tag": batch_tag,
        "pins": pins,
        "steps": steps,
        "hazards": hazards
    })

html_content = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NeuroCall Atlas Studio — Visual Drag-and-Drop Pin Calibration</title>
<style>
  :root {
    --bg-dark: #070a12;
    --card-bg: #0f172a;
    --card-border: #1e293b;
    --accent-cyan: #00e5ff;
    --accent-amber: #f59e0b;
    --accent-rose: #f43f5e;
    --accent-green: #10b981;
    --text-main: #f8fafc;
    --text-muted: #94a3b8;
  }
  body {
    background-color: var(--bg-dark);
    color: var(--text-main);
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    margin: 0;
    padding: 20px;
    user-select: none;
  }
  .header {
    max-width: 1480px;
    margin: 0 auto 20px auto;
    padding-bottom: 16px;
    border-bottom: 1px solid var(--card-border);
  }
  .header h1 {
    margin: 0 0 6px 0;
    font-size: 26px;
    font-weight: 800;
    color: #fff;
    letter-spacing: -0.5px;
  }
  .header p {
    margin: 0;
    color: var(--text-muted);
    font-size: 13.5px;
    line-height: 1.5;
  }
  .controls {
    max-width: 1480px;
    margin: 0 auto 20px auto;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    align-items: center;
  }
  .search-box {
    flex: 1;
    min-width: 260px;
    padding: 10px 16px;
    border-radius: 8px;
    border: 1px solid var(--card-border);
    background: var(--card-bg);
    color: #fff;
    font-size: 13.5px;
  }
  .filter-btn {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    color: var(--text-muted);
    padding: 8px 14px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 12.5px;
    font-weight: 700;
  }
  .filter-btn.active, .filter-btn:hover {
    background: #1e293b;
    color: #fff;
    border-color: var(--accent-cyan);
  }
  .toast {
    position: fixed;
    top: 24px;
    right: 24px;
    background: #10b981;
    color: #000;
    padding: 12px 24px;
    border-radius: 8px;
    font-weight: 800;
    font-size: 14px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.8);
    display: none;
    z-index: 9999;
    animation: fadeIn 0.2s;
  }
  .plate-grid {
    max-width: 1480px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 32px;
  }
  .plate-card {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: 16px;
    padding: 20px;
    display: grid;
    grid-template-columns: 1.15fr 0.85fr;
    gap: 24px;
    align-items: start;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
  }
  @media (max-width: 1100px) {
    .plate-card {
      grid-template-columns: 1fr;
    }
  }
  .image-wrapper {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }
  .image-canvas-container {
    position: relative;
    width: 100%;
    border-radius: 12px;
    overflow: hidden;
    background: #000;
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 4px 20px rgba(0,0,0,0.6);
    cursor: crosshair;
  }
  .plate-img {
    width: 100%;
    height: auto;
    display: block;
    pointer-events: none;
    user-select: none;
  }
  .pin-marker {
    position: absolute;
    width: 28px;
    height: 28px;
    transform: translate(-50%, -50%);
    border-radius: 50%;
    color: #000;
    font-size: 12px;
    font-weight: 900;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 0 14px rgba(0,0,0,0.9), 0 0 10px currentColor;
    border: 2px solid #fff;
    cursor: grab;
    z-index: 100;
    transition: box-shadow 0.15s;
  }
  .pin-marker:active {
    cursor: grabbing;
    transform: translate(-50%, -50%) scale(1.35);
    z-index: 200;
    box-shadow: 0 0 20px #00e5ff;
  }
  .action-toolbar {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    align-items: center;
    background: #090e1a;
    padding: 10px 14px;
    border-radius: 10px;
    border: 1px solid var(--card-border);
  }
  .btn-action {
    background: #1e293b;
    border: 1px solid #334155;
    color: #fff;
    padding: 7px 14px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 700;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: all 0.15s;
  }
  .btn-action:hover {
    background: #334155;
  }
  .btn-save {
    background: #059669;
    border-color: #10b981;
    color: #fff;
    margin-left: auto;
    font-weight: 800;
  }
  .btn-save:hover {
    background: #10b981;
    color: #000;
  }
  .btn-danger {
    background: rgba(244, 63, 94, 0.15);
    border-color: rgba(244, 63, 94, 0.4);
    color: #fda4af;
  }
  .btn-danger:hover {
    background: #f43f5e;
    color: #fff;
  }
  .details-container {
    display: flex;
    flex-direction: column;
    user-select: text;
  }
  .card-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
  }
  .plate-num {
    font-size: 13.5px;
    font-weight: 800;
    color: var(--accent-cyan);
    letter-spacing: 0.5px;
  }
  .tag-badge {
    font-size: 10.5px;
    font-weight: 700;
    padding: 3px 8px;
    border-radius: 6px;
    background: rgba(16, 185, 129, 0.15);
    color: var(--accent-green);
    border: 1px solid rgba(16, 185, 129, 0.3);
  }
  .plate-title {
    font-size: 18px;
    font-weight: 800;
    color: #fff;
    margin: 0 0 14px 0;
    line-height: 1.3;
  }
  .pins-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-bottom: 14px;
  }
  .pin-item {
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 8px;
    padding: 10px 12px;
    border-left: 4px solid var(--accent-cyan);
  }
  .pin-title-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 4px;
  }
  .pin-name {
    font-size: 12.5px;
    font-weight: 700;
    color: #fff;
  }
  .coord-pill {
    font-size: 10px;
    font-family: monospace;
    color: #38bdf8;
    background: rgba(56, 189, 248, 0.12);
    padding: 2px 6px;
    border-radius: 4px;
    margin-left: 6px;
  }
  .pin-type {
    font-size: 9.5px;
    color: var(--accent-amber);
    font-weight: 700;
    text-transform: uppercase;
  }
  .btn-delete-pin {
    background: none;
    border: none;
    color: #94a3b8;
    cursor: pointer;
    font-size: 14px;
    padding: 2px 6px;
    border-radius: 4px;
    transition: all 0.15s;
  }
  .btn-delete-pin:hover {
    color: #f43f5e;
    background: rgba(244, 63, 94, 0.15);
  }
  .pin-desc {
    font-size: 11.5px;
    color: var(--text-muted);
    line-height: 1.4;
    margin: 0 0 4px 0;
  }
  .pin-pearl {
    font-size: 11px;
    color: var(--accent-cyan);
    font-style: italic;
    margin: 0;
    line-height: 1.35;
  }
  .steps-box, .hazards-box {
    margin-top: 10px;
    background: #1e293b;
    border-radius: 8px;
    padding: 10px 12px;
  }
  .box-title {
    font-size: 10.5px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 6px;
  }
  .step-text {
    font-size: 11px;
    color: #cbd5e1;
    margin-bottom: 4px;
    line-height: 1.35;
  }
  .hazard-text {
    font-size: 11px;
    color: #fda4af;
    margin-bottom: 4px;
    line-height: 1.35;
  }
</style>
</head>
<body>

<div id="toast" class="toast">✅ Saved to Swift!</div>

<div class="header">
  <h1>NeuroCall Atlas Studio — Interactive Pin Calibration & Purge</h1>
  <p>Dr. Mohit: <strong>Click and drag any pin directly on the artwork</strong> to place it onto the exact anatomical landmark. Click <strong>🗑️</strong> to delete any pin that doesn't make sense, or <strong>"Clear All Pins"</strong> to wipe the plate completely clean. When satisfied, click <strong>"Save Changes to Swift"</strong> to write the exact coordinates directly to code!</p>
</div>

<div class="controls">
  <input type="text" id="searchInput" class="search-box" placeholder="Search by Plate # (e.g. 001, 010, 031, 087), procedure name, or keyword..." onkeyup="filterPlates()">
  <button class="filter-btn active" onclick="setFilter('ALL', this)">All 106 Plates</button>
  <button class="filter-btn" onclick="setFilter('Master Calibrated (001-042)', this)">Plates 001–042</button>
  <button class="filter-btn" onclick="setFilter('Batch 4 Streamlined', this)">Batch 4 (086–089, 058)</button>
</div>

<div class="plate-grid" id="plateGrid">
</div>

<script>
let plates = """ + json.dumps(plates_data) + """;
let currentFilter = 'ALL';
let activeDrag = null;

function getColorHex(colorName) {
  if (colorName.includes('Cyan')) return '#00e5ff';
  if (colorName.includes('Amber')) return '#f59e0b';
  if (colorName.includes('Rose') || colorName.includes('Red')) return '#f43f5e';
  if (colorName.includes('Green') || colorName.includes('Emerald')) return '#10b981';
  if (colorName.includes('Purple') || colorName.includes('Blue')) return '#8b5cf6';
  return '#00e5ff';
}

function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.style.display = 'block';
  setTimeout(() => { t.style.display = 'none'; }, 2200);
}

function renderPlates() {
  const grid = document.getElementById('plateGrid');
  const search = document.getElementById('searchInput').value.toLowerCase();
  grid.innerHTML = '';

  const filtered = plates.filter(p => {
    const matchesFilter = currentFilter === 'ALL' || p.batch_tag === currentFilter;
    const matchesSearch = p.plate_num.includes(search) || 
                          p.title.toLowerCase().includes(search) || 
                          p.pins.some(pin => pin.title.toLowerCase().includes(search) || pin.description.toLowerCase().includes(search));
    return matchesFilter && matchesSearch;
  });

  filtered.forEach(p => {
    const card = document.createElement('div');
    card.className = 'plate-card';
    card.id = `plate-card-${p.plate_num}`;

    // Markers on image
    let pinMarkersHtml = p.pins.map((pin, idx) => {
      const hex = getColorHex(pin.color);
      return `<div class="pin-marker" id="marker-${p.plate_num}-${idx}" 
                   style="left: ${pin.x * 100}%; top: ${pin.y * 100}%; background: ${hex};" 
                   onmousedown="startPinDrag(event, '${p.plate_num}', ${idx})" 
                   title="Pin ${idx+1}: ${pin.title} (Drag to reposition)">${idx+1}</div>`;
    }).join('');

    // Pins list
    let pinsListHtml = p.pins.length === 0 ? '<div style="color: #64748b; font-size: 12px; font-style: italic; padding: 10px;">Zero pins on this plate (100% clean image). Click "+ Drop Pin" to add a landmark if needed.</div>' : p.pins.map((pin, idx) => {
      const hex = getColorHex(pin.color);
      return `
        <div class="pin-item" id="item-${p.plate_num}-${idx}" style="border-left-color: ${hex}">
          <div class="pin-title-row">
            <div>
              <span class="pin-name">Pin ${idx+1}: ${pin.title}</span>
              <span class="coord-pill" id="coord-${p.plate_num}-${idx}">X:${(pin.x*100).toFixed(1)}% Y:${(pin.y*100).toFixed(1)}%</span>
            </div>
            <div style="display:flex; align-items:center; gap:6px;">
              <span class="pin-type">${pin.structureType}</span>
              <button class="btn-delete-pin" onclick="deletePin('${p.plate_num}', ${idx})" title="Delete this pin">🗑️</button>
            </div>
          </div>
          <p class="pin-desc">${pin.description}</p>
          ${pin.surgicalPearl ? `<p class="pin-pearl">★ Pearl: ${pin.surgicalPearl}</p>` : ''}
        </div>
      `;
    }).join('');

    let stepsHtml = p.steps.map(s => `
      <div class="step-text"><strong>Step ${s.step}: ${s.title}</strong> — ${s.detail}</div>
    `).join('');

    let hazardsHtml = p.hazards.map(h => `
      <div class="hazard-text">⚠️ ${h}</div>
    `).join('');

    card.innerHTML = `
      <div class="image-wrapper">
        <div class="image-canvas-container" id="canvas-${p.plate_num}" onclick="handleCanvasClick(event, '${p.plate_num}')">
          <img src="${p.image_file}" class="plate-img" alt="${p.title}" loading="lazy">
          ${pinMarkersHtml}
        </div>
        <div class="action-toolbar">
          <button class="btn-action" onclick="enableDropMode('${p.plate_num}')">＋ Drop Pin</button>
          <button class="btn-action btn-danger" onclick="clearAllPins('${p.plate_num}')">🚫 Clear All Pins</button>
          <button class="btn-action btn-save" onclick="savePlate('${p.plate_num}')">💾 Save Changes to Swift</button>
        </div>
      </div>
      <div class="details-container">
        <div class="card-top">
          <span class="plate-num">PLATE ${p.plate_num}</span>
          <span class="tag-badge">${p.batch_tag}</span>
        </div>
        <div class="plate-title">${p.title}</div>
        <div style="font-size: 11px; font-weight: 800; color: #94a3b8; margin-bottom: 8px; text-transform: uppercase;">
          Interactive Callout Pins (${p.pins.length} Pins — Drag on artwork or delete below):
        </div>
        <div class="pins-list" id="pins-list-${p.plate_num}">${pinsListHtml}</div>
        
        <div class="steps-box">
          <div class="box-title" style="color: var(--accent-cyan);">Dissection Sequence:</div>
          ${stepsHtml}
        </div>

        <div class="hazards-box">
          <div class="box-title" style="color: var(--accent-rose);">Catastrophic Operative Hazards:</div>
          ${hazardsHtml}
        </div>
      </div>
    `;
    grid.appendChild(card);
  });
}

// Drag & Drop logic
function startPinDrag(e, plateNum, pinIndex) {
  e.preventDefault();
  e.stopPropagation();
  const plate = plates.find(p => p.plate_num === plateNum);
  const container = document.getElementById(`canvas-${plateNum}`);
  const marker = document.getElementById(`marker-${plateNum}-${pinIndex}`);
  const coordPill = document.getElementById(`coord-${plateNum}-${pinIndex}`);

  function onMouseMove(moveEvent) {
    const rect = container.getBoundingClientRect();
    let x = (moveEvent.clientX - rect.left) / rect.width;
    let y = (moveEvent.clientY - rect.top) / rect.height;
    x = Math.max(0.04, Math.min(0.96, x));
    y = Math.max(0.04, Math.min(0.96, y));

    marker.style.left = `${x * 100}%`;
    marker.style.top = `${y * 100}%`;
    if (coordPill) {
      coordPill.textContent = `X:${(x*100).toFixed(1)}% Y:${(y*100).toFixed(1)}%`;
    }
    plate.pins[pinIndex].x = x;
    plate.pins[pinIndex].y = y;
  }

  function onMouseUp() {
    window.removeEventListener('mousemove', onMouseMove);
    window.removeEventListener('mouseup', onMouseUp);
  }

  window.addEventListener('mousemove', onMouseMove);
  window.addEventListener('mouseup', onMouseUp);
}

// Delete a single pin
function deletePin(plateNum, pinIndex) {
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.pins.splice(pinIndex, 1);
  renderPlates();
  showToast(`🗑️ Removed pin from Plate ${plateNum}. Click 'Save' to commit to Swift.`);
}

// Clear all pins for a plate
function clearAllPins(plateNum) {
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;
  plate.pins = [];
  renderPlates();
  showToast(`🚫 Wiped all pins from Plate ${plateNum}. Click 'Save' to commit.`);
}

// Drop a new pin
let dropModePlate = null;
function enableDropMode(plateNum) {
  dropModePlate = plateNum;
  showToast(`Click anywhere on the image of Plate ${plateNum} to place the new pin.`);
}

function handleCanvasClick(e, plateNum) {
  if (dropModePlate !== plateNum) return;
  const container = document.getElementById(`canvas-${plateNum}`);
  const rect = container.getBoundingClientRect();
  let x = (e.clientX - rect.left) / rect.width;
  let y = (e.clientY - rect.top) / rect.height;
  x = Math.max(0.04, Math.min(0.96, x));
  y = Math.max(0.04, Math.min(0.96, y));

  const plate = plates.find(p => p.plate_num === plateNum);
  const pinTitle = prompt("Enter Landmark / Pin Title:", "Anatomical Target");
  if (!pinTitle) {
    dropModePlate = null;
    return;
  }

  plate.pins.push({
    id: `pin_${plateNum}_${plate.pins.length + 1}`,
    num: plate.pins.length + 1,
    title: pinTitle,
    structureType: "OPERATIVE TARGET",
    color: "neonCyan",
    x: x,
    y: y,
    description: "Operative landmark identified on visual review.",
    surgicalPearl: "Maintain precise anatomical orientation."
  });

  dropModePlate = null;
  renderPlates();
  showToast(`✅ Dropped new pin on Plate ${plateNum}!`);
}

// Save plate back to Swift
async function savePlate(plateNum) {
  const plate = plates.find(p => p.plate_num === plateNum);
  if (!plate) return;

  try {
    const res = await fetch('/api/save-plate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        plate_num: plateNum,
        pins: plate.pins
      })
    });
    const result = await res.json();
    if (result.status === 'success') {
      showToast(`✅ Plate ${plateNum} (${plate.pins.length} pins) saved directly to Swift!`);
    } else {
      alert("Error saving: " + result.message);
    }
  } catch (err) {
    alert("Connection error to studio server: " + err);
  }
}

function setFilter(filter, btn) {
  currentFilter = filter;
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  renderPlates();
}

function filterPlates() {
  renderPlates();
}

renderPlates();
</script>

</body>
</html>
"""

output_path = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector\index.html"
with open(output_path, "w", encoding="utf-8") as f:
    f.write(html_content)

print("Atlas Studio interactive drag-and-drop UI generated successfully!")
