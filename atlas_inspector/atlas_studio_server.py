import http.server
import socketserver
import json
import re
import os
import sys

PORT = 8085
BASE_DIR = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector"

SWIFT_PATHS = {
    "atlas_data": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift",
    "atlas_view": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift",
    "crisis": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\EmergencyProtocolsView.swift",
    "consults": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\ERConsultsView.swift",
    "procedures": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgicalProceduresView.swift",
    "calculators": r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\NeurosurgeryCalculatorsView.swift"
}

# 1. Update Atlas Plates
def update_swift_plate_all(plate_num, title, pins, steps, hazards):
    # Update Data
    with open(SWIFT_PATHS["atlas_data"], "r", encoding="utf-8") as f:
        content = f.read()

    sec_c_header = "public var callouts: [SurgicalCallout] {"
    sec_s_header = "public var steps: [ApproachSequentialStep] {"
    sec_h_header = "public var catastrophicHazards: [String] {"

    idx_c = content.find(sec_c_header)
    idx_s = content.find(sec_s_header)
    idx_h = content.find(sec_h_header)

    part1 = content[:idx_c]
    sec_callouts = content[idx_c:idx_s]
    sec_steps = content[idx_s:idx_h]
    sec_hazards = content[idx_h:]

    # Callouts
    pin_blocks = []
    color_map = {
        "green": "neonGreen", "blue": "neonBlue", "orange": "neonAmber",
        "red": "neonRed", "purple": "neonPurple", "amber": "neonAmber",
        "rose": "neonRose", "cyan": "neonCyan", "emerald": "neonEmerald"
    }
    for idx, p in enumerate(pins):
        raw_color = p.get("color", "neonCyan").replace("ObsidianTheme.", "").replace("Color.", "")
        c_val = color_map.get(raw_color, raw_color)
        color_val = f"ObsidianTheme.{c_val}"
        
        title_esc = p.get("title", "").replace('"', '\\"')
        type_esc = p.get("structureType", "ANATOMICAL LANDMARK").replace('"', '\\"')
        desc_esc = p.get("description", "").replace('"', '\\"')
        pearl_esc = p.get("surgicalPearl", "").replace('"', '\\"')
        x_val = f"{float(p.get('x', 0.5)):.3f}"
        y_val = f"{float(p.get('y', 0.5)):.3f}"

        block = f"""                SurgicalCallout(
                    id: "plate_{plate_num}_{idx+1}",
                    title: "{title_esc}",
                    structureType: "{type_esc}",
                    color: {color_val},
                    normalizedX: {x_val},
                    normalizedY: {y_val},
                    description: "{desc_esc}",
                    surgicalPearl: "{pearl_esc}"
                )"""
        pin_blocks.append(block)

    if pin_blocks:
        joined_pins = ",\n".join(pin_blocks)
        new_c_code = f"""        case .plate{plate_num}:
            return [
{joined_pins}
            ]"""
    else:
        new_c_code = f"""        case .plate{plate_num}:
            return []"""

    start_c = sec_callouts.find(f"case .plate{plate_num}:")
    if start_c != -1:
        m_next_c = re.search(r"\n\s*(case \.plate|default:|\}\s*\n\s*\})", sec_callouts[start_c:])
        end_c = start_c + m_next_c.start() if m_next_c else len(sec_callouts)
        sec_callouts = sec_callouts[:start_c] + new_c_code.strip() + sec_callouts[end_c:]

    # Steps
    if steps is not None:
        step_blocks = []
        for idx, s in enumerate(steps):
            s_num = idx + 1
            s_title = s.get("title", f"Step {s_num}").replace('"', '\\"')
            s_detail = s.get("detail", "").replace('"', '\\"')
            step_blocks.append(f"""                ApproachSequentialStep(stepNumber: {s_num}, title: "{s_title}", detail: "{s_detail}")""")

        if step_blocks:
            joined_steps = ",\n".join(step_blocks)
            new_s_code = f"""        case .plate{plate_num}:
            return [
{joined_steps}
            ]"""
        else:
            new_s_code = f"""        case .plate{plate_num}:
            return []"""

        start_s = sec_steps.find(f"case .plate{plate_num}:")
        if start_s != -1:
            m_next_s = re.search(r"\n\s*(case \.plate|default:|\}\s*\n\s*\})", sec_steps[start_s:])
            end_s = start_s + m_next_s.start() if m_next_s else len(sec_steps)
            sec_steps = sec_steps[:start_s] + new_s_code.strip() + sec_steps[end_s:]

    # Hazards
    if hazards is not None:
        hazard_blocks = []
        for h in hazards:
            h_text = h.strip().replace('"', '\\"')
            if h_text:
                hazard_blocks.append(f'                "{h_text}"')

        if hazard_blocks:
            joined_hazards = ",\n".join(hazard_blocks)
            new_h_code = f"""        case .plate{plate_num}:
            return [
{joined_hazards}
            ]"""
        else:
            new_h_code = f"""        case .plate{plate_num}:
            return []"""

        start_h = sec_hazards.find(f"case .plate{plate_num}:")
        if start_h != -1:
            m_next_h = re.search(r"\n\s*(case \.plate|default:|\}\s*\n\s*\})", sec_hazards[start_h:])
            end_h = start_h + m_next_h.start() if m_next_h else len(sec_hazards)
            sec_hazards = sec_hazards[:start_h] + new_h_code.strip() + sec_hazards[end_h:]

    updated_data = part1 + sec_callouts + sec_steps + sec_hazards
    with open(SWIFT_PATHS["atlas_data"], "w", encoding="utf-8") as f:
        f.write(updated_data)

    # Line-by-line update for PhotorealisticSurgicalAtlasView.swift (Title)
    if title:
        with open(SWIFT_PATHS["atlas_view"], "r", encoding="utf-8") as f:
            lines = f.readlines()
        clean_title = title.strip()
        p_int = int(plate_num)
        short_t = f"{p_int}: {clean_title}" if not clean_title.startswith(f"{p_int}:") else clean_title
        p_case = f"case .plate{plate_num}:"

        new_lines = []
        current_sec = None
        for line in lines:
            if "public var shortTitle: String {" in line:
                current_sec = "shortTitle"
            elif "public var title: String {" in line:
                current_sec = "title"
            elif "public var iconName: String {" in line:
                current_sec = "iconName"

            if current_sec == "shortTitle" and p_case in line:
                new_lines.append(f'        case .plate{plate_num}: return "{short_t}"\n')
            elif current_sec == "title" and p_case in line:
                new_lines.append(f'        case .plate{plate_num}: return "{clean_title}"\n')
            else:
                new_lines.append(line)

        with open(SWIFT_PATHS["atlas_view"], "w", encoding="utf-8") as f:
            f.writelines(new_lines)

    print(f"[Studio] Plate {plate_num} saved to Swift.")

# 2. Update 2 AM Crisis
def update_swift_crisis(spec_id, spec_data, checklists, reversals):
    with open(SWIFT_PATHS["crisis"], "r", encoding="utf-8") as f:
        text = f.read()

    # Update Threshold Spec if provided
    if spec_id and spec_data:
        pattern = rf'case "{spec_id}":\s*return EmergencyThresholdSpec\((.*?)\)'
        m = re.search(pattern, text, re.DOTALL)
        if m:
            t_title = spec_data.get("title", "").replace('"', '\\"')
            t_thick = spec_data.get("thicknessThreshold", "").replace('"', '\\"')
            t_shift = spec_data.get("shiftThreshold", "").replace('"', '\\"')
            t_vol = spec_data.get("volumeThreshold", "").replace('"', '\\"')
            t_trig = spec_data.get("neurologicalTrigger", "").replace('"', '\\"')
            t_op = spec_data.get("operativeProcedure", "").replace('"', '\\"')

            new_spec = f"""case "{spec_id}":
            return EmergencyThresholdSpec(
                title: "{t_title}",
                thicknessThreshold: "{t_thick}",
                shiftThreshold: "{t_shift}",
                volumeThreshold: "{t_vol}",
                neurologicalTrigger: "{t_trig}",
                operativeProcedure: "{t_op}"
            )"""
            text = text[:m.start()] + new_spec + text[m.end():]

    # Update Checklists if provided
    if checklists:
        for cl in checklists:
            cl_title = cl.get("title", "")
            cl_steps = cl.get("steps", [])
            pattern = rf'ChecklistCard\(\s*title:\s*"{re.escape(cl_title)}",\s*steps:\s*\[(.*?)\]\s*\)'
            m = re.search(pattern, text, re.DOTALL)
            if m:
                steps_formatted = ",\n                    ".join([f'"{s.replace(chr(34), chr(92)+chr(34))}"' for s in cl_steps])
                new_card = f"""ChecklistCard(
                    title: "{cl_title}",
                    steps: [
                    {steps_formatted}
                ])"""
                text = text[:m.start()] + new_card + text[m.end():]

    with open(SWIFT_PATHS["crisis"], "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[Studio] 2 AM Crisis updated in Swift.")

# 3. Update ER Consult
def update_swift_consult(consult_case, data):
    with open(SWIFT_PATHS["consults"], "r", encoding="utf-8") as f:
        text = f.read()

    title = data.get("title", "").replace('"', '\\"')
    short_title = data.get("shortTitle", "").replace('"', '\\"')
    acuity = data.get("acuity", "EMERGENCY").replace('"', '\\"')
    imaging_pearl = data.get("imagingPearl", "").replace('"', '\\"')
    operative_plan = data.get("operativePlan", "").replace('"', '\\"')
    pitfalls = data.get("pitfalls", [])

    # Update Title
    text = re.sub(rf'(public var title: String \{{.*?case \.{consult_case}:\s*return )"[^"]+"', rf'\1"{title}"', text, flags=re.DOTALL)
    # Update ShortTitle
    text = re.sub(rf'(public var shortTitle: String \{{.*?case \.{consult_case}:\s*return )"[^"]+"', rf'\1"{short_title}"', text, flags=re.DOTALL)
    # Update Acuity
    text = re.sub(rf'(public var acuityLabel: String \{{.*?case \.{consult_case}:\s*return )"[^"]+"', rf'\1"{acuity}"', text, flags=re.DOTALL)
    # Update Imaging Pearl
    text = re.sub(rf'(public var imagingPearl: String \{{.*?case \.{consult_case}:\s*return )"[^"]+"', rf'\1"{imaging_pearl}"', text, flags=re.DOTALL)
    # Update Operative Plan
    text = re.sub(rf'(public var operativePlan: String \{{.*?case \.{consult_case}:\s*return )"[^"]+"', rf'\1"{operative_plan}"', text, flags=re.DOTALL)

    # Update Pitfalls if provided
    if pitfalls:
        p_joined = ",\n                ".join([f'"{p.replace(chr(34), chr(92)+chr(34))}"' for p in pitfalls])
        pattern = rf'(public var pitfalls: \[String\] \{{.*?case \.{consult_case}:\s*return )\[(.*?)\]'
        m = re.search(pattern, text, re.DOTALL)
        if m:
            text = text[:m.start(2)] + f"[\n                {p_joined}\n            ]" + text[m.end(2)+1:]

    with open(SWIFT_PATHS["consults"], "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[Studio] Consult {consult_case} updated in Swift.")

# 4. Update Procedure Trajectory Step
def update_swift_procedure_step(step_number, old_title, new_title, new_detail):
    with open(SWIFT_PATHS["procedures"], "r", encoding="utf-8") as f:
        text = f.read()

    pattern = rf'TrajectoryStepRow\(\s*number:\s*"{step_number}",\s*title:\s*"[^"]*",\s*detail:\s*"[^"]*"\s*\)'
    new_code = f"""TrajectoryStepRow(number: "{step_number}", title: "{new_title.replace('"', '\\"')}", detail: "{new_detail.replace('"', '\\"')}")"""
    text = re.sub(pattern, new_code, text, count=1)

    with open(SWIFT_PATHS["procedures"], "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[Studio] Bedside Procedure Step {step_number} updated in Swift.")

# HTTP Request Handler
class FullAppStudioHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=BASE_DIR, **kwargs)

    def do_POST(self):
        content_length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(content_length).decode("utf-8")
        try:
            data = json.loads(body)

            if self.path == "/api/save-plate":
                plate_num = f"{int(data.get('plate_num')):03d}"
                title = data.get("title")
                pins = data.get("pins", [])
                steps = data.get("steps")
                hazards = data.get("hazards")
                update_swift_plate_all(plate_num, title, pins, steps, hazards)
                res = {"status": "ok", "section": "atlas", "id": plate_num}

            elif self.path == "/api/save-crisis":
                spec_id = data.get("spec_id")
                spec_data = data.get("spec")
                checklists = data.get("checklists")
                reversals = data.get("reversals")
                update_swift_crisis(spec_id, spec_data, checklists, reversals)
                res = {"status": "ok", "section": "crisis", "id": spec_id}

            elif self.path == "/api/save-consult":
                consult_case = data.get("case")
                consult_data = data.get("data")
                update_swift_consult(consult_case, consult_data)
                res = {"status": "ok", "section": "consults", "id": consult_case}

            elif self.path == "/api/save-procedure":
                step_num = data.get("number")
                old_title = data.get("old_title", "")
                new_title = data.get("title", "")
                new_detail = data.get("detail", "")
                update_swift_procedure_step(step_num, old_title, new_title, new_detail)
                res = {"status": "ok", "section": "procedures", "id": step_num}

            else:
                res = {"status": "error", "message": f"Unknown endpoint: {self.path}"}

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(json.dumps(res).encode("utf-8"))

        except Exception as e:
            print(f"[Studio Error] {e}")
            self.send_response(500)
            self.send_header("Content-Type", "application/json")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(json.dumps({"status": "error", "message": str(e)}).encode("utf-8"))

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

if __name__ == "__main__":
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), FullAppStudioHandler) as httpd:
        print(f"=======================================================")
        print(f"🚀 NeuroCall Full App Studio Server Running on Port {PORT}")
        print(f"👉 Local URL: http://localhost:{PORT}/")
        print(f"=======================================================")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server.")
            httpd.server_close()
