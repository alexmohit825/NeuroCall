import http.server
import socketserver
import json
import re
import os
import sys

PORT = 8085
BASE_DIR = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector"
SWIFT_DATA_PATH = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift"
SWIFT_VIEW_PATH = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasView.swift"

def update_swift_plate_all(plate_num, title, pins, steps, hazards):
    # 1. Update PhotorealisticSurgicalAtlasData.swift (callouts, steps, hazards)
    with open(SWIFT_DATA_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    sec_c_header = "public var callouts: [SurgicalCallout] {"
    sec_s_header = "public var steps: [ApproachSequentialStep] {"
    sec_h_header = "public var catastrophicHazards: [String] {"

    idx_c = content.find(sec_c_header)
    idx_s = content.find(sec_s_header)
    idx_h = content.find(sec_h_header)

    if idx_c == -1 or idx_s == -1 or idx_h == -1:
        raise ValueError("Could not find sections in PhotorealisticSurgicalAtlasData.swift")

    part1 = content[:idx_c]
    sec_callouts = content[idx_c:idx_s]
    sec_steps = content[idx_s:idx_h]
    sec_hazards = content[idx_h:]

    # A) Update Callouts
    pin_blocks = []
    for idx, p in enumerate(pins):
        color_val = p.get("color", "neonCyan")
        if not color_val.startswith("ObsidianTheme.") and not color_val.startswith("Color."):
            color_val = f"ObsidianTheme.{color_val}"
        color_val = color_val.replace("ObsidianTheme.red", "ObsidianTheme.neonRed")
        color_val = color_val.replace("ObsidianTheme.purple", "ObsidianTheme.neonPurple")
        
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

    # B) Update Steps (if provided)
    if steps is not None:
        step_blocks = []
        for idx, s in enumerate(steps):
            s_num = idx + 1
            s_title = s.get("title", f"Step {s_num}").replace('"', '\\"')
            s_detail = s.get("detail", "").replace('"', '\\"')
            s_block = f"""                ApproachSequentialStep(stepNumber: {s_num}, title: "{s_title}", detail: "{s_detail}")"""
            step_blocks.append(s_block)

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

    # C) Update Hazards (if provided)
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
    with open(SWIFT_DATA_PATH, "w", encoding="utf-8") as f:
        f.write(updated_data)

    # 2. Update PhotorealisticSurgicalAtlasView.swift (Title) if provided
    if title:
        with open(SWIFT_VIEW_PATH, "r", encoding="utf-8") as f:
            view_text = f.read()

        st_start = view_text.find("public var shortTitle: String {")
        t_start = view_text.find("public var title: String {")
        ic_start = view_text.find("public var iconName: String {")

        if st_start != -1 and t_start != -1 and ic_start != -1:
            st_sec = view_text[st_start:t_start]
            t_sec = view_text[t_start:ic_start]

            clean_title = title.strip()
            # shortTitle e.g. "26: Costotransversectomy"
            p_int = int(plate_num)
            short_t = f"{p_int}: {clean_title}" if not clean_title.startswith(f"{p_int}:") else clean_title

            pattern_st = rf"case \.plate{plate_num}:\s*return\s*\"[^\"]+\""
            st_sec = re.sub(pattern_st, f'case .plate{plate_num}: return "{short_t}"', st_sec)

            pattern_t = rf"case \.plate{plate_num}:\s*return\s*\"[^\"]+\""
            t_sec = re.sub(pattern_t, f'case .plate{plate_num}: return "{clean_title}"', t_sec)

            view_text = view_text[:st_start] + st_sec + t_sec + view_text[ic_start:]
            with open(SWIFT_VIEW_PATH, "w", encoding="utf-8") as f:
                f.write(view_text)

    print(f"[Atlas Studio Server] Successfully updated Plate {plate_num} in Swift (Pins: {len(pins)}, Title: '{title}')!")

class AtlasStudioHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=BASE_DIR, **kwargs)

    def do_POST(self):
        if self.path == "/api/save-plate":
            content_length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(content_length).decode("utf-8")
            try:
                data = json.loads(body)
                plate_num = f"{int(data.get('plate_num')):03d}"
                title = data.get("title")
                pins = data.get("pins", [])
                steps = data.get("steps")
                hazards = data.get("hazards")

                update_swift_plate_all(plate_num, title, pins, steps, hazards)

                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Access-Control-Allow-Origin", "*")
                self.end_headers()
                self.wfile.write(json.dumps({"status": "ok", "plate_num": plate_num}).encode("utf-8"))
            except Exception as e:
                print(f"[Atlas Studio Server] Error saving plate: {e}")
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
    with socketserver.TCPServer(("", PORT), AtlasStudioHandler) as httpd:
        print(f"=======================================================")
        print(f"🚀 NeuroCall Atlas Studio Server Running on Port {PORT}")
        print(f"👉 Local URL: http://localhost:{PORT}/")
        print(f"=======================================================")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server.")
            httpd.server_close()
