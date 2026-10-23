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
    
    # Start: (15, 25, 45) Deep Sapphire Midnight
    # End: (4, 6, 12) Obsidian Void
    start_col = np.array([18, 28, 52, 255], dtype=np.float32)
    end_col = np.array([5, 7, 14, 255], dtype=np.float32)
    
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

def generate_pro_icon_a():
    # Super-sampled canvas for buttery-smooth anti-aliased curves
    w, h = 2048, 2048
    bg = create_rich_background(w, h)
    
    # We will draw on an overlay layer for glow and shadows
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx, cy = w / 2, h / 2 - 30
    
    # 1. Subtle, ultra-clean concentric radar ring (Subtle caliper frame)
    r_outer = 660
    draw.ellipse([cx - r_outer, cy - r_outer, cx + r_outer, cy + r_outer], outline=(0, 229, 255, 30), width=6)
    
    # 4 Precision Axis Tick Marks
    for deg in [0, 90, 180, 270]:
        rad = math.radians(deg)
        x1 = cx + (r_outer - 24) * math.cos(rad)
        y1 = cy + (r_outer - 24) * math.sin(rad)
        x2 = cx + (r_outer + 24) * math.cos(rad)
        y2 = cy + (r_outer + 24) * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=(0, 229, 255, 180), width=8)
        
    # 2. Sleek, iconic Dual-Hemisphere Brain Silhouette
    # Smooth organic bezier lobes
    gap = 22  # Interhemispheric fissure width
    
    # Left Hemisphere Path
    # Top vertex -> frontal curve -> temporal lobe -> occipital base -> midline
    left_top = (cx - gap, cy - 420)
    left_front_c1 = (cx - gap - 260, cy - 420)
    left_front_c2 = (cx - gap - 480, cy - 220)
    left_front_mid = (cx - gap - 480, cy - 40)
    
    pts_left_1 = bezier_curve(left_top, left_front_c1, left_front_c2, left_front_mid, 40)
    
    # Temporal & Base curve
    left_temp_c1 = (cx - gap - 480, cy + 180)
    left_temp_c2 = (cx - gap - 340, cy + 340)
    left_temp_mid = (cx - gap - 160, cy + 340)
    pts_left_2 = bezier_curve(left_front_mid, left_temp_c1, left_temp_c2, left_temp_mid, 40)
    
    # Curve back toward brainstem / midline
    left_base_c1 = (cx - gap - 80, cy + 340)
    left_base_c2 = (cx - gap, cy + 280)
    left_stem_entry = (cx - gap, cy + 220)
    pts_left_3 = bezier_curve(left_temp_mid, left_base_c1, left_base_c2, left_stem_entry, 30)
    
    left_poly = pts_left_1 + pts_left_2 + pts_left_3 + [(cx - gap, cy - 420)]
    
    # Right Hemisphere Path (Mirror)
    right_top = (cx + gap, cy - 420)
    right_front_c1 = (cx + gap + 260, cy - 420)
    right_front_c2 = (cx + gap + 480, cy - 220)
    right_front_mid = (cx + gap + 480, cy - 40)
    pts_right_1 = bezier_curve(right_top, right_front_c1, right_front_c2, right_front_mid, 40)
    
    right_temp_c1 = (cx + gap + 480, cy + 180)
    right_temp_c2 = (cx + gap + 340, cy + 340)
    right_temp_mid = (cx + gap + 160, cy + 340)
    pts_right_2 = bezier_curve(right_front_mid, right_temp_c1, right_temp_c2, right_temp_mid, 40)
    
    right_base_c1 = (cx + gap + 80, cy + 340)
    right_base_c2 = (cx + gap, cy + 280)
    right_stem_entry = (cx + gap, cy + 220)
    pts_right_3 = bezier_curve(right_temp_mid, right_base_c1, right_base_c2, right_stem_entry, 30)
    
    right_poly = pts_right_1 + pts_right_2 + pts_right_3 + [(cx + gap, cy - 420)]
    
    # Draw Left Hemisphere with rich surgical cyan / gradient feel
    # Base solid fill
    draw.polygon(left_poly, fill=(0, 185, 230, 240))
    # Elegant inner contour lines (Primary Sulci)
    # Sylvian fissure cut
    sylvian_left = bezier_curve((cx - gap - 440, cy + 20), (cx - gap - 320, cy + 20), (cx - gap - 220, cy - 60), (cx - gap - 140, cy - 60), 30)
    draw.line(sylvian_left, fill=(10, 25, 45, 230), width=24, joint="curve")
    
    # Central sulcus cut
    central_left = bezier_curve((cx - gap - 340, cy - 300), (cx - gap - 240, cy - 200), (cx - gap - 220, cy - 120), (cx - gap - 120, cy - 60), 30)
    draw.line(central_left, fill=(10, 25, 45, 230), width=20, joint="curve")
    
    # Draw Right Hemisphere with crisp titanium white / subtle platinum shade
    draw.polygon(right_poly, fill=(245, 250, 255, 255))
    
    # Right inner sulci
    sylvian_right = bezier_curve((cx + gap + 440, cy + 20), (cx + gap + 320, cy + 20), (cx + gap + 220, cy - 60), (cx + gap + 140, cy - 60), 30)
    draw.line(sylvian_right, fill=(18, 28, 48, 230), width=24, joint="curve")
    
    central_right = bezier_curve((cx + gap + 340, cy - 300), (cx + gap + 240, cy - 200), (cx + gap + 220, cy - 120), (cx + gap + 120, cy - 60), 30)
    draw.line(central_right, fill=(18, 28, 48, 230), width=20, joint="curve")
    
    # 3. Central Vertical Axis: Brainstem & Spinal Cord Column
    # Descends cleanly from foramen magnum
    stem_w = 40
    stem_top = cy + 210
    stem_bot = cy + 560
    
    # Glowing spinal column cord
    draw.rounded_rectangle([cx - stem_w / 2, stem_top, cx + stem_w / 2, stem_bot], radius=16, fill=(0, 229, 255, 255))
    
    # Segmented Cervical / Spine Beads (C1, C2, C3, C4)
    for y_pos in [stem_top + 60, stem_top + 140, stem_top + 220, stem_top + 300]:
        draw.ellipse([cx - 28, y_pos - 18, cx + 28, y_pos + 18], fill=(12, 18, 32), outline=(0, 229, 255, 255), width=8)
        draw.ellipse([cx - 10, y_pos - 8, cx + 10, y_pos + 8], fill=(255, 255, 255, 255))
        
    # 4. Acute On-Call Signal: Precision Vertex Caliper Pin
    # Centered right at vertex (Kocher's point / midline indicator)
    v_y = cy - 430
    draw.ellipse([cx - 32, v_y - 32, cx + 32, v_y + 32], fill=(0, 229, 255, 70))
    draw.ellipse([cx - 20, v_y - 20, cx + 20, v_y + 20], fill=(0, 229, 255, 255))
    draw.ellipse([cx - 8, v_y - 8, cx + 8, v_y + 8], fill=(255, 255, 255, 255))
    
    # Combine overlay with background
    final_img = Image.alpha_composite(bg, overlay)
    
    # Convert RGBA to RGB for standard App Store compliance (NO alpha channel)
    rgb_img = Image.new("RGB", (w, h), (5, 7, 14))
    rgb_img.paste(final_img, mask=final_img.split()[3])
    
    # Lanczos downscale to 1024x1024
    res_1024 = rgb_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    return res_1024

def generate_pro_icon_b():
    # Design B: "The Minimalist Titanium Trephine"
    # Extremely clean, iconic, bold symbol: Sleek solid-weight white & electric cyan trephine crosshair ring
    # with a razor-sharp stylized anatomical cerebrum in the center.
    w, h = 2048, 2048
    bg = create_rich_background(w, h)
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx, cy = w / 2, h / 2
    
    # Heavy, authoritative outer trephine caliper ring
    r_outer = 580
    ring_thick = 36
    draw.ellipse([cx - r_outer, cy - r_outer, cx + r_outer, cy + r_outer], outline=(0, 229, 255, 40), width=ring_thick + 24)
    draw.ellipse([cx - r_outer, cy - r_outer, cx + r_outer, cy + r_outer], outline=(0, 229, 255, 240), width=ring_thick)
    draw.ellipse([cx - r_outer, cy - r_outer, cx + r_outer, cy + r_outer], outline=(255, 255, 255, 255), width=8)
    
    # 4 Cardinal Surgical Flange Notches (like a stereotactic ring)
    flange_len = 60
    for deg in [0, 90, 180, 270]:
        rad = math.radians(deg)
        x1 = cx + (r_outer - flange_len / 2) * math.cos(rad)
        y1 = cy + (r_outer - flange_len / 2) * math.sin(rad)
        x2 = cx + (r_outer + flange_len / 2) * math.cos(rad)
        y2 = cy + (r_outer + flange_len / 2) * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=(255, 255, 255, 255), width=16)
        
    # Central Stylized Minimalist Brain Glyph (Clean, bold, bold vector lines)
    # Left & Right Lobe Arcs with high-contrast line weights
    # Symmetrical, modern, razor-sharp
    for side in [-1, 1]:
        lobe_col = (0, 229, 255, 255) if side == -1 else (255, 255, 255, 255)
        
        # Outer Lobe Arc
        p0 = (cx + side * 30, cy - 320)
        p1 = (cx + side * 320, cy - 320)
        p2 = (cx + side * 380, cy + 80)
        p3 = (cx + side * 180, cy + 240)
        p4 = (cx + side * 30, cy + 220)
        
        outer_arc = bezier_curve(p0, p1, p2, p3, 30) + bezier_curve(p3, (cx + side * 100, cy + 240), (cx + side * 60, cy + 220), p4, 20)
        draw.line(outer_arc, fill=lobe_col, width=28, joint="curve")
        
        # Inner Sulcus Arc
        s0 = (cx + side * 300, cy - 40)
        s1 = (cx + side * 180, cy - 40)
        s2 = (cx + side * 120, cy + 80)
        inner_arc = bezier_curve(s0, s1, (cx + side * 140, cy + 20), s2, 20)
        draw.line(inner_arc, fill=lobe_col, width=20, joint="curve")
        
    # Vertical Midline Plumbline & Spinal Cord
    draw.line([(cx, cy - 360), (cx, cy + 380)], fill=(0, 229, 255, 255), width=16)
    draw.line([(cx, cy - 360), (cx, cy + 380)], fill=(255, 255, 255, 255), width=6)
    
    # Central navigation crosshair dot
    draw.ellipse([cx - 24, cy - 24, cx + 24, cy + 24], fill=(12, 18, 30), outline=(0, 229, 255, 255), width=6)
    draw.ellipse([cx - 8, cy - 8, cx + 8, cy + 8], fill=(255, 255, 255, 255))
    
    final_img = Image.alpha_composite(bg, overlay)
    rgb_img = Image.new("RGB", (w, h), (5, 7, 14))
    rgb_img.paste(final_img, mask=final_img.split()[3])
    res_1024 = rgb_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    return res_1024

if __name__ == "__main__":
    icon_a = generate_pro_icon_a()
    icon_a.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\pro_icon_a_dual_cortex.png")
    
    icon_b = generate_pro_icon_b()
    icon_b.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\pro_icon_b_trephine_minimal.png")
    
    print("Professional icons A and B generated successfully!")
