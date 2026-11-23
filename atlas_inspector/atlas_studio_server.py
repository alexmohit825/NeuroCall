import http.server
import socketserver
import json
import re
import os
import sys

PORT = 8085
BASE_DIR = r"C:\Users\mohal\Documents\antigravity\Radix\atlas_inspector"
SWIFT_PATH = r"C:\Users\mohal\Documents\antigravity\Radix\RadixApp\Views\PhotorealisticSurgicalAtlasData.swift"

def update_swift_plate_callouts(plate_num, pins):
    with open(SWIFT_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    sec1_header = "public var callouts: [SurgicalCallout] {"
    sec2_header = "public var steps: [ApproachSequentialStep] {"
    idx1 = content.find(sec1_header)
    idx2 = content.find(sec2_header)
    if idx1 == -1 or idx2 == -1:
        raise ValueError("Could not find callouts section in Swift file")

    part_prefix = content[:idx1]
    callouts_sec = content[idx1:idx2]
    part_suffix = content[idx2:]

    # Build new Swift callouts code for this plate
    p_int = int(plate_num)
    pin_blocks = []
    for idx, p in enumerate(pins):
        color_val = p.get("color", "neonCyan")
        if not color_val.startswith("ObsidianTheme.") and not color_val.startswith("Color."):
            color_val = f"ObsidianTheme.{color_val}"
        
        # Escape quotes in strings
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
        new_case_code = f"""        case .plate{plate_num}:
            return [
{joined_pins}
            ]"""
    else:
        new_case_code = f"""        case .plate{plate_num}:
            return []"""

    # Replace in callouts_sec
    start_str = f"case .plate{plate_num}:"
    idx_start = callouts_sec.find(start_str)
    if idx_start == -1:
        raise ValueError(f"Could not find {start_str} in callouts section")

    m_next = re.search(r"\n\s*(case \.plate|default:|\}\s*\n\s*\})", callouts_sec[idx_start:])
    if not m_next:
        raise ValueError(f"Could not find end of case {plate_num}")
    idx_end = idx_start + m_next.start()

    updated_callouts_sec = callouts_sec[:idx_start] + new_case_code.strip() + callouts_sec[idx_end:]
    final_content = part_prefix + updated_callouts_sec + part_suffix

    with open(SWIFT_PATH, "w", encoding="utf-8") as f:
        f.write(final_content)

    print(f"[Atlas Studio Server] Successfully updated Plate {plate_num} with {len(pins)} pins in Swift!")

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
                pins = data.get("pins", [])
                update_swift_plate_callouts(plate_num, pins)

                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Access-Control-Allow-Origin", "*")
                self.end_headers()
                resp = json.dumps({"status": "success", "plate_num": plate_num, "pin_count": len(pins)})
                self.wfile.write(resp.encode("utf-8"))
            except Exception as e:
                self.send_response(500)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                resp = json.dumps({"status": "error", "message": str(e)})
                self.wfile.write(resp.encode("utf-8"))
        else:
            self.send_response(404)
            self.end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

if __name__ == "__main__":
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("0.0.0.0", PORT), AtlasStudioHandler) as httpd:
        print(f"[Atlas Studio Server] Live on http://localhost:{PORT}")
        sys.stdout.flush()
        httpd.serve_forever()
