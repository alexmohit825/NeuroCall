import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_rich_background(w, h):
    # Deep, luxurious aerospace dark gradient: navy-slate to obsidian void
    img = Image.new("RGBA", (w, h))
    arr = np.zeros((h, w, 4), dtype=np.float32)
    
    # Top-center radiant light source
    cx, cy = w * 0.5, h * 0.38
    max_dist = math.sqrt((w * 0.7) ** 2 + (h * 0.7) ** 2)
    
    y, x = np.indices((h, w))
    dist = np.sqrt((x - cx) ** 2 + (y - cy) ** 2)
    t = np.clip(dist / max_dist, 0.0, 1.0)
    t_smooth = t * t * (3 - 2 * t)
    
    start_col = np.array([16, 26, 48, 255], dtype=np.float32)
    end_col = np.array([6, 8, 14, 255], dtype=np.float32)
    
    for c in range(4):
        arr[:, :, c] = start_col[c] * (1 - t_smooth) + end_col[c] * t_smooth
        
    return Image.fromarray(np.uint8(arr))

def bezier_curve(p0, p1, p2, p3, num_points=50):
    points = []
    for i in range(num_points + 1):
        t = i / float(num_points)
        x = (1-t)**3 * p0[0] + 3*(1-t)**2*t * p1[0] + 3*(1-t)*t**2 * p2[0] + t**3 * p3[0]
        y = (1-t)**3 * p0[1] + 3*(1-t)**2*t * p1[1] + 3*(1-t)*t**2 * p2[1] + t**3 * p3[1]
        points.append((x, y))
    return points

def generate_pro_icon_c():
    # Design C: "The Minimalist Gyral Apex"
    # Modern Apple Design Language: 
    # Perfectly smooth, bold, organic cerebral arches with an emergency call signal & spinal axis
    w, h = 2048, 2048
    bg = create_rich_background(w, h)
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx, cy = w / 2, h / 2 - 40
    
    # Subtle ambient navigation ring
    draw.ellipse([cx - 680, cy - 680, cx + 680, cy + 680], outline=(0, 229, 255, 20), width=4)
    
    # The Brain: Composed of 3 harmonious, concentric, smooth anatomical folds per side
    # Built with precise cubic Bezier curves and rounded caps
    
    # Tier 1 (Outer Calvarial / Cortical Arch - Frontal to Occipital)
    # Left Outer Arch
    left_outer = bezier_curve((cx - 40, cy - 440), (cx - 460, cy - 440), (cx - 620, cy - 80), (cx - 420, cy + 240), 50)
    left_outer += bezier_curve((cx - 420, cy + 240), (cx - 320, cy + 340), (cx - 160, cy + 320), (cx - 40, cy + 260), 40)
    
    # Right Outer Arch
    right_outer = bezier_curve((cx + 40, cy - 440), (cx + 460, cy - 440), (cx + 620, cy - 80), (cx + 420, cy + 240), 50)
    right_outer += bezier_curve((cx + 420, cy + 240), (cx + 320, cy + 340), (cx + 160, cy + 320), (cx + 40, cy + 260), 40)
    
    # Draw Outer Arches: Left = Cyan glow, Right = Pure Titanium White
    # Glow pass
    for gw, g_op in [(48, 30), (32, 70)]:
        draw.line(left_outer, fill=(0, 229, 255, g_op), width=gw, joint="curve")
        draw.line(right_outer, fill=(255, 255, 255, int(g_op * 0.7)), width=gw, joint="curve")
        
    # Solid stroke
    draw.line(left_outer, fill=(0, 229, 255, 255), width=28, joint="curve")
    draw.line(right_outer, fill=(255, 255, 255, 255), width=28, joint="curve")
    
    # Tier 2 (Middle Gyral Fold - Parietal / Sylvian Contour)
    left_mid = bezier_curve((cx - 40, cy - 300), (cx - 320, cy - 300), (cx - 420, cy - 40), (cx - 280, cy + 160), 40)
    left_mid += bezier_curve((cx - 280, cy + 160), (cx - 200, cy + 220), (cx - 100, cy + 200), (cx - 40, cy + 160), 30)
    
    right_mid = bezier_curve((cx + 40, cy - 300), (cx + 320, cy - 300), (cx + 420, cy - 40), (cx + 280, cy + 160), 40)
    right_mid += bezier_curve((cx + 280, cy + 160), (cx + 200, cy + 220), (cx + 100, cy + 200), (cx + 40, cy + 160), 30)
    
    draw.line(left_mid, fill=(0, 229, 255, 220), width=22, joint="curve")
    draw.line(right_mid, fill=(240, 248, 255, 230), width=22, joint="curve")
    
    # Tier 3 (Inner Limbic / Cingulate Core)
    left_in = bezier_curve((cx - 40, cy - 160), (cx - 200, cy - 160), (cx - 220, cy + 20), (cx - 120, cy + 80), 30)
    right_in = bezier_curve((cx + 40, cy - 160), (cx + 200, cy - 160), (cx + 220, cy + 20), (cx + 120, cy + 80), 30)
    
    draw.line(left_in, fill=(0, 229, 255, 180), width=18, joint="curve")
    draw.line(right_in, fill=(230, 240, 255, 190), width=18, joint="curve")
    
    # Central Midline Plumbline & Spinal Cord Axis
    cord_top = cy - 480
    cord_bot = cy + 560
    
    # Subtle cord glow
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(0, 229, 255, 40), width=24)
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(0, 229, 255, 255), width=12)
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(255, 255, 255, 255), width=4)
    
    # Spinal Column Vertebral Beads (C1, C2, C3, C4, C5)
    bead_start = cy + 270
    for i, b_y in enumerate([bead_start, bead_start + 70, bead_start + 140, bead_start + 210]):
        r_b = 20 - i * 1.5
        draw.ellipse([cx - r_b, b_y - r_b, cx + r_b, b_y + r_b], fill=(12, 20, 36), outline=(0, 229, 255, 255), width=6)
        draw.ellipse([cx - 6, b_y - 6, cx + 6, b_y + 6], fill=(255, 255, 255, 255))
        
    # Top Vertex Target Pulse
    draw.ellipse([cx - 24, cord_top - 24, cx + 24, cord_top + 24], fill=(0, 229, 255, 60))
    draw.ellipse([cx - 14, cord_top - 14, cx + 14, cord_top + 14], fill=(0, 229, 255, 255))
    draw.ellipse([cx - 5, cord_top - 5, cx + 5, cord_top + 5], fill=(255, 255, 255, 255))
    
    final_img = Image.alpha_composite(bg, overlay)
    rgb_img = Image.new("RGB", (w, h), (5, 7, 14))
    rgb_img.paste(final_img, mask=final_img.split()[3])
    res_1024 = rgb_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    return res_1024

if __name__ == "__main__":
    icon_c = generate_pro_icon_c()
    icon_c.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\pro_icon_c_gyral_apex.png")
    print("Icon C generated successfully!")
