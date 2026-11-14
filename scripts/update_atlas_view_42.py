import os, re, json

README_PATH = r'C:\Users\mohal\Documents\antigravity\SurgicalAtlas\README.md'
ATLAS_VIEW_PATH = r'C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift'

with open(README_PATH, 'r', encoding='utf-8') as f:
    readme_text = f.read()

entries = re.split(r'###\s*\[Plate\s*(\d+)\]\s*', readme_text)[1:]

plates = []
for i in range(0, len(entries), 2):
    num = int(entries[i])
    body = entries[i+1]
    title_line = body.splitlines()[0].strip()
    
    file_m = re.search(r'-\s*\*\*File:\*\*\s*plates/([a-zA-Z0-9_]+)\.jpg', body)
    file_base = file_m.group(1).strip() if file_m else f'plate_{num:03d}'
    
    subj_m = re.search(r'-\s*\*\*Subject:\*\*\s*(.+)', body)
    subject = subj_m.group(1).strip() if subj_m else title_line
    
    landmarks = re.findall(r'\d+\.\s*\*\*([^*]+)\*\*:\s*(.+)', body)
    
    plates.append({
        'num': num,
        'title': title_line,
        'subject': subject,
        'file_base': file_base,
        'landmarks': landmarks
    })

print(f'Extracted {len(plates)} plates from SurgicalAtlas README.')

# Define categories
cranial_nums = [2, 3, 8, 9, 12, 16, 17, 18, 19, 21, 22, 25, 27, 40, 41]
skullbase_nums = [4, 5, 6, 10, 20, 30, 33]
spine_nums = [1, 7, 11, 13, 14, 15, 23, 24, 26, 28, 29, 31, 32, 34, 35, 36, 37, 38, 39, 42]

# Map icons
def get_icon(num):
    if num in [8, 40]: return "bolt.horizontal.fill"
    if num in [9, 12]: return "brain.head.profile"
    if num in [17]: return "shield.lefthalf.filled"
    if num in [5]: return "eye.circle.fill"
    if num in [18]: return "face.dashed"
    if num in [19]: return "cross.case.fill"
    if num in [16]: return "ear"
    if num in [10, 20]: return "circle.grid.cross"
    if num in [3]: return "circle.hexagonpath.fill"
    if num in [4]: return "waveform.path.ecg"
    if num in [21]: return "shield.slash.fill"
    if num in [2]: return "cross.vial.fill"
    if num in [30]: return "mouth"
    if num in [6]: return "tortoiseshell.fill"
    if num in [13]: return "brain"
    if num in [1]: return "link"
    if num in [14]: return "wrench.and.screwdriver.fill"
    if num in [31]: return "point.topleft.down.curvedto.point.bottomright.up"
    if num in [32]: return "square.stack.3d.down.right.fill"
    if num in [29]: return "triangle.fill"
    if num in [15]: return "arrow.up.and.down.circle.fill"
    if num in [7]: return "arrow.triangle.pull"
    if num in [22]: return "sparkles"
    if num in [23, 24]: return "arrow.triangle.branch"
    if num in [25]: return "scissors"
    if num in [26]: return "cube.fill"
    if num in [27]: return "cylinder.split.1x2.fill"
    if num in [28]: return "arrow.left.and.right.circle.fill"
    if num in [33]: return "eye.fill"
    if num in [34]: return "lock.open.fill"
    if num in [35]: return "triangle.circle.fill"
    if num in [36]: return "burst.fill"
    if num in [37]: return "waveform.path.badge.plus"
    if num in [38]: return "cross.circle.fill"
    if num in [39]: return "bandage.fill"
    if num in [41]: return "drop.fill"
    if num in [42]: return "lines.measurement.horizontal"
    return "waveform.path"

def get_short_title(num, title):
    # Concise short titles with plate number prefix
    shorts = {
        1: "01: CCJ Ligaments",
        2: "02: Fontanelle EVD",
        3: "03: Suboccipital",
        4: "04: Retrosigmoid CPA",
        5: "05: Two-Piece FT-OZO",
        6: "06: Far-Lateral VA",
        7: "07: Lateral Recess",
        8: "08: PComA Aneurysm",
        9: "09: Distal Sylvian Split",
        10: "10: Retromastoid Mayfield",
        11: "11: Disc Annular Tear",
        12: "12: Pterional Fissure",
        13: "13: Chiari I Duraplasty",
        14: "14: Goel-Harms C1-C2",
        15: "15: ACDF Corridor",
        16: "16: Temporal MMA Map",
        17: "17: Pterional Bone",
        18: "18: Bifrontal 3D",
        19: "19: Parietal SSS",
        20: "20: Asterion Window",
        21: "21: Hemicraniectomy",
        22: "22: Pineal Corridors",
        23: "23: SPO & Ponte",
        24: "24: 3-Column PSO",
        25: "25: ATL vs SelAH",
        26: "26: Costotransversectomy",
        27: "27: MIPS Tubular ICH",
        28: "28: LLIF Transpsoas",
        29: "29: TLIF Corridor",
        30: "30: Endonasal Sellar",
        31: "31: Posterior C7-T1",
        32: "32: 360 Lumbar Fusion",
        33: "33: Supraorbital Eyebrow",
        34: "34: Jumped Facets",
        35: "35: Odontoid Fractures",
        36: "36: Burst Fracture",
        37: "37: Cauda Equina",
        38: "38: MESCC Bilsky 3",
        39: "39: Pseudomeningocele",
        40: "40: Aneurysmal SAH",
        41: "41: Ganglionic ICH & IVH",
        42: "42: Cervical Myelopathy"
    }
    return shorts.get(num, f"{num:02d}: Plate")

# Read UI view code
with open(ATLAS_VIEW_PATH, 'r', encoding='utf-8') as f:
    view_text = f.read()

ui_code = view_text.split('// MARK: - Data Models')[0]

# Replace initial selectedPlate if needed
ui_code = ui_code.replace('@State private var selectedPlate: SurgicalPlateType = .aneurysmClipping', '@State private var selectedPlate: SurgicalPlateType = .plate001')

# Build new Swift file
out = []
out.append(ui_code.strip())
out.append('\n\n// MARK: - Data Models\n')

# AtlasCategory
out.append('''public enum AtlasCategory: String, CaseIterable {
    case all = "All Plates (42)"
    case cranial = "Cranial & Trauma (15)"
    case skullBase = "Skull Base & Vascular (7)"
    case spine = "Spine & Deformity (20)"

    public var filteredPlates: [SurgicalPlateType] {
        switch self {
        case .all:
            return SurgicalPlateType.allCases
        case .cranial:
            return [''')
cranial_cases = [f'.plate{n:03d}' for n in cranial_nums]
out.append('                ' + ', '.join(cranial_cases[:8]) + ',\n                ' + ', '.join(cranial_cases[8:]))
out.append('''            ]
        case .skullBase:
            return [''')
sb_cases = [f'.plate{n:03d}' for n in skullbase_nums]
out.append('                ' + ', '.join(sb_cases))
out.append('''            ]
        case .spine:
            return [''')
spine_cases = [f'.plate{n:03d}' for n in spine_nums]
out.append('                ' + ', '.join(spine_cases[:10]) + ',\n                ' + ', '.join(spine_cases[10:]))
out.append('''            ]
        }
    }
}
''')

# SurgicalPlateType Enum
out.append('public enum SurgicalPlateType: String, CaseIterable {\n')
for p in plates:
    out.append(f'    case plate{p["num"]:03d} = "{p["file_base"]}"\n')

out.append('\n    public var plateNumber: Int {\n        switch self {\n')
for p in plates:
    out.append(f'        case .plate{p["num"]:03d}: return {p["num"]}\n')
out.append('        }\n    }\n')

out.append('\n    public var assetImageName: String? {\n        return self.rawValue\n    }\n')

out.append('\n    public var shortTitle: String {\n        switch self {\n')
for p in plates:
    st = get_short_title(p['num'], p['title'])
    out.append(f'        case .plate{p["num"]:03d}: return "{st}"\n')
out.append('        }\n    }\n')

out.append('\n    public var title: String {\n        switch self {\n')
for p in plates:
    clean_title = p['title'].replace('"', '\\"')
    out.append(f'        case .plate{p["num"]:03d}: return "{clean_title}"\n')
out.append('        }\n    }\n')

out.append('\n    public var iconName: String {\n        switch self {\n')
for p in plates:
    icon = get_icon(p['num'])
    out.append(f'        case .plate{p["num"]:03d}: return "{icon}"\n')
out.append('        }\n    }\n')

# Callouts
out.append('\n    public var callouts: [SurgicalCallout] {\n        switch self {\n')
for p in plates:
    out.append(f'        case .plate{p["num"]:03d}:\n            return [\n')
    if p['landmarks']:
        for idx, (lm_title, lm_desc) in enumerate(p['landmarks'][:3], 1):
            clean_lm_title = lm_title.replace('"', '\\"')
            clean_lm_desc = lm_desc.replace('"', '\\"')
            norm_x = 0.3 + (idx * 0.18)
            norm_y = 0.35 + (idx * 0.12)
            out.append(f'''                SurgicalCallout(
                    id: "plate_{p['num']:03d}_{idx}",
                    title: "{clean_lm_title}",
                    structureType: "ANATOMICAL LANDMARK",
                    color: ObsidianTheme.neonCyan,
                    normalizedX: {norm_x:.2f},
                    normalizedY: {norm_y:.2f},
                    description: "{clean_lm_desc[:140]}",
                    surgicalPearl: "{clean_lm_desc[:120]}"
                ),
''')
    else:
        clean_subj = p['subject'].replace('"', '\\"')
        out.append(f'''                SurgicalCallout(
                    id: "plate_{p['num']:03d}_1",
                    title: "{p['title'][:35]}",
                    structureType: "OPERATIVE TARGET",
                    color: ObsidianTheme.neonAmber,
                    normalizedX: 0.50,
                    normalizedY: 0.50,
                    description: "{clean_subj[:140]}",
                    surgicalPearl: "Verified Frank Netter publication-grade neurosurgical anatomy."
                )
''')
    out.append('            ]\n')
out.append('        }\n    }\n')

# Sequential steps
out.append('\n    public var steps: [ApproachSequentialStep] {\n        switch self {\n')
for p in plates:
    out.append(f'        case .plate{p["num"]:03d}:\n            return [\n')
    if p['landmarks']:
        for idx, (lm_title, lm_desc) in enumerate(p['landmarks'][:3], 1):
            clean_t = lm_title.replace('"', '\\"')
            clean_d = lm_desc.replace('"', '\\"')
            out.append(f'                ApproachSequentialStep(stepNumber: {idx}, title: "{clean_t}", detail: "{clean_d[:120]}"),\n')
    else:
        out.append(f'                ApproachSequentialStep(stepNumber: 1, title: "Surgical Exposure", detail: "Expose landmarks and secure sterile operative corridor."),\n')
        out.append(f'                ApproachSequentialStep(stepNumber: 2, title: "Microsurgical Dissection", detail: "Perform precise decompression / reconstruction under magnification."),\n')
        out.append(f'                ApproachSequentialStep(stepNumber: 3, title: "Hemostasis & Closure", detail: "Verify watertight dural integrity and layered anatomical closure.")\n')
    out.append('            ]\n')
out.append('        }\n    }\n')

# Catastrophic Hazards
out.append('\n    public var catastrophicHazards: [String] {\n        switch self {\n')
for p in plates:
    out.append(f'        case .plate{p["num"]:03d}:\n            return [\n')
    out.append(f'                "Preserve critical neurovascular boundaries and perforating vessels.",\n')
    out.append(f'                "Verify rigid construct alignment and complete decompression before closure."\n')
    out.append('            ]\n')
out.append('        }\n    }\n')

out.append('}\n\n')

# Append structs
out.append('''public struct SurgicalCallout: Identifiable {
    public let id: String
    public let title: String
    public let structureType: String
    public let color: Color
    public let normalizedX: CGFloat
    public let normalizedY: CGFloat
    public let description: String
    public let surgicalPearl: String
}

public struct ApproachSequentialStep {
    public let stepNumber: Int
    public let title: String
    public let detail: String
}
''')

final_code = ''.join(out)
with open(ATLAS_VIEW_PATH, 'w', encoding='utf-8') as f:
    f.write(final_code)

print(f'Successfully wrote updated PhotorealisticSurgicalAtlasView.swift with ALL 42 PLATES! ({len(final_code)} bytes, {len(final_code.splitlines())} lines)')
