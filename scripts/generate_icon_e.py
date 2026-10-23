import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_rich_background(w, h):
    img = Image.new("RGBA", (w, h))
    arr = np.zeros((h, w, 4), dtype=np.float32)
    cx, cy = w * 0.5, h * 0.44
    max_dist = math.sqrt((w * 0.7) ** 2 + (h * 0.7) ** 2)
    y, x = np.indices((h, w))
    dist = np.sqrt((x - cx) ** 2 + (y - cy) ** 2)
    t = np.clip(dist / max_dist, 0.0, 1.0)
    t_smooth = t * t * (3 - 2 * t)
    
    # Deep luxurious midnight sapphire into obsidian
    start_col = np.array([16, 26, 48, 255], dtype=np.float32)
    end_col = np.array([5, 7, 13, 255], dtype=np.float32)
    for c in range(4):
        arr[:, :, c] = start_col[c] * (1 - t_smooth) + end_col[c] * t_smooth
    return Image.fromarray(np.uint8(arr))

def bezier_curve(p0, p1, p2, p3, num_points=60):
    points = []
    for i in range(num_points + 1):
        t = i / float(num_points)
        x = (1-t)**3 * p0[0] + 3*(1-t)**2*t * p1[0] + 3*(1-t)*t**2 * p2[0] + t**3 * p3[0]
        y = (1-t)**3 * p0[1] + 3*(1-t)**2*t * p1[1] + 3*(1-t)*t**2 * p2[1] + t**3 * p3[1]
        points.append((x, y))
    return points

def generate_pro_icon_e():
    w, h = 2048, 2048
    bg = create_rich_background(w, h)
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx, cy = w / 2, h / 2 - 10
    
    # 1. Subtle stereotactic outer ring
    r_outer = 640
    draw.ellipse([cx - r_outer, cy - r_outer, cx + r_outer, cy + r_outer], outline=(0, 229, 255, 35), width=6)
    
    # 4 Cardinal Flange Tabs (Stereotactic / Caliper Frame)
    flange_len = 50
    for deg in [0, 90, 180, 270]:
        rad = math.radians(deg)
        x1 = cx + (r_outer - flange_len / 2) * math.cos(rad)
        y1 = cy + (r_outer - flange_len / 2) * math.sin(rad)
        x2 = cx + (r_outer + flange_len / 2) * math.cos(rad)
        y2 = cy + (r_outer + flange_len / 2) * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=(0, 229, 255, 220), width=12)
        
    # 8 Minor Degree Ticks
    for deg in range(0, 360, 45):
        if deg % 90 != 0:
            rad = math.radians(deg)
            x1 = cx + (r_outer - 18) * math.cos(rad)
            y1 = cy + (r_outer - 18) * math.sin(rad)
            x2 = cx + (r_outer + 18) * math.cos(rad)
            y2 = cy + (r_outer + 18) * math.sin(rad)
            draw.line([x1, y1, x2, y2], fill=(0, 229, 255, 100), width=6)
            
    # 2. Master Symmetrical Brain Iconography
    # Beautiful, organic, smooth multi-lobed cerebral silhouette
    # Built using mathematically perfect bezier curves
    for side in [-1, 1]:
        # Left side = Surgical Cyan (#00E5FF), Right side = Titanium White (#FFFFFF)
        col = (0, 229, 255, 255) if side == -1 else (255, 255, 255, 255)
        glow_col = (0, 229, 255, 50) if side == -1 else (255, 255, 255, 35)
        
        # Outer Cortex Loop (Vertex -> Frontal Pole -> Temporal Lobe -> Occipital / Base)
        p_top = (cx + side * 40, cy - 380)
        p_frontal = (cx + side * 360, cy - 340)
        p_temporal = (cx + side * 440, cy - 40)
        p_temp_inf = (cx + side * 380, cy + 180)
        p_base = (cx + side * 180, cy + 280)
        p_stem_in = (cx + side * 40, cy + 240)
        
        arc1 = bezier_curve(p_top, (cx + side * 220, cy - 400), (cx + side * 340, cy - 360), p_frontal, 30)
        arc2 = bezier_curve(p_frontal, (cx + side * 420, cy - 240), (cx + side * 460, cy - 140), p_temporal, 30)
        arc3 = bezier_curve(p_temporal, (cx + side * 440, cy + 60), (cx + side * 420, cy + 140), p_temp_inf, 25)
        arc4 = bezier_curve(p_temp_inf, (cx + side * 340, cy + 260), (cx + side * 260, cy + 280), p_base, 25)
        arc5 = bezier_curve(p_base, (cx + side * 120, cy + 280), (cx + side * 60, cy + 260), p_stem_in, 20)
        
        cortex_path = arc1 + arc2 + arc3 + arc4 + arc5
        
        # Outer glow
        draw.line(cortex_path, fill=glow_col, width=42, joint="curve")
        draw.line(cortex_path, fill=glow_col, width=28, joint="curve")
        # Crisp solid stroke
        draw.line(cortex_path, fill=col, width=22, joint="curve")
        
        # Inner Sulcus 1 (Sylvian Fissure Sweep)
        s1_start = (cx + side * 360, cy + 40)
        s1_mid = (cx + side * 220, cy + 20)
        s1_end = (cx + side * 140, cy - 60)
        sulcus1 = bezier_curve(s1_start, (cx + side * 280, cy + 40), s1_mid, s1_end, 30)
        
        draw.line(sulcus1, fill=glow_col, width=30, joint="curve")
        draw.line(sulcus1, fill=col, width=16, joint="curve")
        
        # Inner Sulcus 2 (Central Sulcus Fold)
        s2_start = (cx + side * 280, cy - 240)
        s2_mid = (cx + side * 180, cy - 160)
        s2_end = (cx + side * 100, cy - 100)
        sulcus2 = bezier_curve(s2_start, (cx + side * 220, cy - 220), s2_mid, s2_end, 25)
        
        draw.line(sulcus2, fill=glow_col, width=26, joint="curve")
        draw.line(sulcus2, fill=col, width=14, joint="curve")
        
    # 3. Central Vertical Midline & Spinal Axis
    cord_top = cy - 440
    cord_bot = cy + 480
    
    # Midline ray glow
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(0, 229, 255, 45), width=28)
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(0, 229, 255, 255), width=12)
    draw.line([(cx, cord_top), (cx, cord_bot)], fill=(255, 255, 255, 255), width=4)
    
    # Spinal Column Vertebral Nodes (C1, C2, C3, C4)
    for seg_y in [cy + 250, cy + 320, cy + 390, cy + 460]:
        draw.ellipse([cx - 20, seg_y - 20, cx + 20, seg_y + 20], fill=(10, 16, 28), outline=(0, 229, 255, 255), width=6)
        draw.ellipse([cx - 7, seg_y - 7, cx + 7, seg_y + 7], fill=(255, 255, 255, 255))
        
    # 4. Focal Apex Call Pulse (Top Vertex / Kocher's Target)
    draw.ellipse([cx - 28, cord_top - 28, cx + 28, cord_top + 28], fill=(0, 229, 255, 60))
    draw.ellipse([cx - 16, cord_top - 16, cx + 16, cord_top + 16], fill=(0, 229, 255, 255))
    draw.ellipse([cx - 6, cord_top - 6, cx + 6, cord_top + 6], fill=(255, 255, 255, 255))
    
    final_img = Image.alpha_composite(bg, overlay)
    rgb_img = Image.new("RGB", (w, h), (5, 7, 14))
    rgb_img.paste(final_img, mask=final_img.split()[3])
    res_1024 = rgb_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    return res_1024

if __name__ == "__main__":
    icon_e = generate_pro_icon_e()
    icon_e.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\pro_icon_e_master_trephine.png")
    print("Icon E generated successfully!")
