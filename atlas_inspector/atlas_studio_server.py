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

# ==========================================
# 1. UPDATE ATLAS PLATES (106 PLATES)
# ==========================================
def update_swift_plate_all(plate_num, title, pins, steps, hazards):
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

    # Update Title in PhotorealisticSurgicalAtlasView.swift
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

# ==========================================
# 2. UPDATE 2 AM CRISIS
# ==========================================
def update_swift_crisis(spec_id, spec_data, checklists, reversals):
    with open(SWIFT_PATHS["crisis"], "r", encoding="utf-8") as f:
        text = f.read()

    # Update Threshold Spec if provided
    if spec_id and spec_data:
        c_idx = text.find(f'case "{spec_id}":')
        if c_idx != -1:
            ret_idx = text.find("return EmergencyThresholdSpec(", c_idx)
            if ret_idx != -1:
                open_p = 0
                p_start = ret_idx + len("return EmergencyThresholdSpec")
                body_end = -1
                for i in range(p_start, len(text)):
                    if text[i] == '(':
                        open_p += 1
                    elif text[i] == ')':
                        open_p -= 1
                        if open_p == 0:
                            body_end = i
                            break
                if body_end != -1:
                    t_title = spec_data.get("title", "").replace('\\', '\\\\').replace('"', '\\"')
                    t_thick = spec_data.get("thicknessThreshold", "").replace('\\', '\\\\').replace('"', '\\"')
                    t_shift = spec_data.get("shiftThreshold", "").replace('\\', '\\\\').replace('"', '\\"')
                    t_vol = spec_data.get("volumeThreshold", "").replace('\\', '\\\\').replace('"', '\\"')
                    t_trig = spec_data.get("neurologicalTrigger", "").replace('\\', '\\\\').replace('"', '\\"')
                    t_op = spec_data.get("operativeProcedure", "").replace('\\', '\\\\').replace('"', '\\"')

                    new_spec = f"""return EmergencyThresholdSpec(
                title: "{t_title}",
                thicknessThreshold: "{t_thick}",
                shiftThreshold: "{t_shift}",
                volumeThreshold: "{t_vol}",
                neurologicalTrigger: "{t_trig}",
                operativeProcedure: "{t_op}"
            )"""
                    text = text[:ret_idx] + new_spec + text[body_end+1:]

    # Update Checklists if provided
    if checklists:
        for cl in checklists:
            cl_title = cl.get("title", "")
            cl_steps = cl.get("steps", [])
            pattern = rf'ChecklistCard\(\s*title:\s*"{re.escape(cl_title)}",\s*steps:\s*\[(.*?)\]\s*\)'
            m = re.search(pattern, text, re.DOTALL)
            if m:
                steps_formatted = ",\n                    ".join([f'"{s.replace(chr(92), chr(92)+chr(92)).replace(chr(34), chr(92)+chr(34))}"' for s in cl_steps])
                new_card = f"""ChecklistCard(
                    title: "{cl_title}",
                    steps: [
                    {steps_formatted}
                ])"""
                text = text[:m.start()] + new_card + text[m.end():]

    with open(SWIFT_PATHS["crisis"], "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[Studio] 2 AM Crisis spec {spec_id} updated in Swift.")

# ==========================================
# 3. UPDATE ER CONSULTS
# ==========================================
def update_consult_prop(text, prop_name, case_id, new_val):
    p_decl = f"public var {prop_name}: String {{"
    start = text.find(p_decl)
    if start == -1: return text
    end = text.find("public var ", start + 20)
    if end == -1: end = text.find("}\n\n", start + 20)
    sec = text[start:end]
    
    pattern = rf'(case\s+\.{case_id}:\s*return\s*)"((?:[^"\\]|\\.)*)"'
    escaped = new_val.replace('\\', '\\\\').replace('"', '\\"')
    sec_new, count = re.subn(pattern, lambda m: f'{m.group(1)}"{escaped}"', sec, count=1)
    if count > 0:
        return text[:start] + sec_new + text[end:]
    return text

def update_consult_pitfalls(text, case_id, pitfalls_list):
    p_decl = "public var pitfalls: [String] {"
    start = text.find(p_decl)
    if start == -1: return text
    end = text.find("public var ", start + 20)
    if end == -1: end = text.find("}\n\n", start + 20)
    sec = text[start:end]
    
    c_idx = sec.find(f"case .{case_id}:")
    if c_idx == -1: return text
    ret_idx = sec.find("return [", c_idx)
    if ret_idx == -1: return text
    close_bracket = sec.find("]", ret_idx)
    if close_bracket == -1: return text
    
    formatted_pitfalls = ",\n                ".join([f'"{p.replace(chr(92), chr(92)+chr(92)).replace(chr(34), chr(92)+chr(34))}"' for p in pitfalls_list])
    new_return = f"return [\n                {formatted_pitfalls}\n            ]"
    sec_new = sec[:ret_idx] + new_return + sec[close_bracket+1:]
    return text[:start] + sec_new + text[end:]

def update_swift_consult(consult_case, data):
    with open(SWIFT_PATHS["consults"], "r", encoding="utf-8") as f:
        text = f.read()

    if "title" in data:
        text = update_consult_prop(text, "title", consult_case, data["title"])
    if "shortTitle" in data:
        text = update_consult_prop(text, "shortTitle", consult_case, data["shortTitle"])
    if "acuityLabel" in data:
        text = update_consult_prop(text, "acuityLabel", consult_case, data["acuityLabel"])
    if "imagingPearl" in data:
        text = update_consult_prop(text, "imagingPearl", consult_case, data["imagingPearl"])
    if "operativePlan" in data:
        text = update_consult_prop(text, "operativePlan", consult_case, data["operativePlan"])
    if "pitfalls" in data and isinstance(data["pitfalls"], list):
        text = update_consult_pitfalls(text, consult_case, data["pitfalls"])

    with open(SWIFT_PATHS["consults"], "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[Studio] ER Consult {consult_case} updated in Swift.")

# ==========================================
# 4. UPDATE BEDSIDE PROCEDURES
# ==========================================
def update_swift_procedure_step(card_name, step_number, new_title, new_detail):
    with open(SWIFT_PATHS["procedures"], "r", encoding="utf-8") as f:
        text = f.read()

    c_idx = text.find(f"struct {card_name}")
    if c_idx == -1:
        # Fallback search across whole file if card_name not found
        block = text
        start_replace = 0
        end_replace = len(text)
    else:
        c_end = text.find("struct ", c_idx + 20)
        if c_end == -1: c_end = len(text)
        block = text[c_idx:c_end]
        start_replace = c_idx
        end_replace = c_end

    pattern = rf'(TrajectoryStepRow\(\s*number:\s*"{step_number}",\s*title:\s*)"((?:[^"\\]|\\.)*)"(\s*,\s*detail:\s*)"((?:[^"\\]|\\.)*)"(\s*\))'
    esc_title = new_title.replace('\\', '\\\\').replace('"', '\\"')
    esc_detail = new_detail.replace('\\', '\\\\').replace('"', '\\"')

    new_block, count = re.subn(pattern, lambda m: f'{m.group(1)}"{esc_title}"{m.group(3)}"{esc_detail}"{m.group(5)}', block, count=1)
    if count > 0:
        text = text[:start_replace] + new_block + text[end_replace:]
        with open(SWIFT_PATHS["procedures"], "w", encoding="utf-8") as f:
            f.write(text)
        print(f"[Studio] Bedside Procedure {card_name} Step {step_number} updated in Swift.")
    else:
        print(f"[Studio Warning] Procedure step not matched for {card_name} Step {step_number}")

# ==========================================
# HTTP SERVER & API ROUTING
# ==========================================
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
                card_name = data.get("card_name", "EVDDetailCard")
                step_num = str(data.get("number", "1"))
                new_title = data.get("title", "")
                new_detail = data.get("detail", "")
                update_swift_procedure_step(card_name, step_num, new_title, new_detail)
                res = {"status": "ok", "section": "procedures", "id": step_num}

            elif self.path == "/api/save-plate-order":
                ordered_nums = data.get("order", [])
                order_path = os.path.join(BASE_DIR, "plate_order.json")
                with open(order_path, "w", encoding="utf-8") as f:
                    json.dump({"order": ordered_nums, "count": len(ordered_nums)}, f, indent=2)
                print(f"[Studio] Saved custom plate order ({len(ordered_nums)} plates) to {order_path}")
                res = {"status": "ok", "section": "plate-order", "count": len(ordered_nums)}

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

class ThreadingServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    daemon_threads = True
    allow_reuse_address = True

if __name__ == "__main__":
    print(f"Starting Multi-Threaded NeuroCall Full App Studio Server on port {PORT}...")
    with ThreadingServer(("", PORT), FullAppStudioHandler) as httpd:
        print(f"Serving at http://localhost:{PORT}/ (Multi-Threaded Concurrent Engine)")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server.")
            sys.exit(0)