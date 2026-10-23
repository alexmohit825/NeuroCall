import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_rich_background(w, h):
    img = Image.new("RGBA", (w, h))
    arr = np.zeros((h, w, 4), dtype=np.float32)
    cx, cy = w * 0.5, h * 0.42
    max_dist = math.sqrt((w * 0.7) ** 2 + (h * 0.7) ** 2)
    y, x = np.indices((h, w))
    dist = np.sqrt((x - cx) ** 2 + (y - cy) ** 2)
    t = np.clip(dist / max_dist, 0.0, 1.0)
    t_smooth = t * t * (3 - 2 * t)
    
    start_col = np.array([20, 32, 58, 255], dtype=np.float32)
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

def generate_pro_icon_d():
    # Design D: "The Masterwork Neurosurgical Glyph"
    # A bold, solid, sculpted lateral brain profile with surgical caliper ring
    w, h = 2048, 2048
    bg = create_rich_background(w, h)
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx, cy = w / 2, h / 2 - 20
    
    # 1. Subtle, elegant stereotactic ring in background
    r_caliper = 680
    draw.ellipse([cx - r_caliper, cy - r_caliper, cx + r_caliper, cy + r_caliper], outline=(0, 229, 255, 30), width=4)
    for deg in range(0, 360, 30):
        rad = math.radians(deg)
        t_len = 24 if deg % 90 == 0 else 12
        color = (0, 229, 255, 180) if deg % 90 == 0 else (0, 229, 255, 60)
        width = 6 if deg % 90 == 0 else 3
        x1 = cx + (r_caliper - t_len) * math.cos(rad)
        y1 = cy + (r_caliper - t_len) * math.sin(rad)
        x2 = cx + r_caliper * math.cos(rad)
        y2 = cy + r_caliper * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=color, width=width)
        
    # 2. Solid Anatomical Cerebrum & Cerebellum & Brainstem
    # Smooth anatomical contours
    # Cerebrum polygon
    p_frontal_pole = (cx - 420, cy - 80)
    p_subfrontal = (cx - 360, cy + 40)
    p_temporal_pole = (cx - 320, cy + 180)
    p_temporal_base = (cx - 140, cy + 220)
    p_pons = (cx - 20, cy + 240)
    p_medulla = (cx + 20, cy + 480)
    p_cord_post = (cx + 80, cy + 480)
    p_tonsil = (cx + 80, cy + 340)
    p_cerebellum_inf = (cx + 280, cy + 320)
    p_cerebellum_post = (cx + 420, cy + 200)
    p_transverse_sinus = (cx + 340, cy + 100)
    p_occipital_pole = (cx + 460, cy - 20)
    p_parietal_slope = (cx + 400, cy - 260)
    p_vertex = (cx + 100, cy - 440)
    p_superior_frontal = (cx - 220, cy - 400)
    
    # Generate smooth bezier segments
    seg1 = bezier_curve(p_superior_frontal, (cx - 360, cy - 360), (cx - 440, cy - 240), p_frontal_pole, 30)
    seg2 = bezier_curve(p_frontal_pole, (cx - 420, cy - 20), (cx - 390, cy + 40), p_subfrontal, 20)
    seg3 = bezier_curve(p_subfrontal, (cx - 360, cy + 100), (cx - 340, cy + 160), p_temporal_pole, 20)
    seg4 = bezier_curve(p_temporal_pole, (cx - 280, cy + 240), (cx - 200, cy + 240), p_temporal_base, 20)
    seg5 = bezier_curve(p_temporal_base, (cx - 80, cy + 220), (cx - 40, cy + 230), p_pons, 15)
    seg6 = [(cx - 10, cy + 320), (cx + 10, cy + 400), p_medulla, p_cord_post, (cx + 70, cy + 400), p_tonsil]
    seg7 = bezier_curve(p_tonsil, (cx + 180, cy + 360), (cx + 240, cy + 360), p_cerebellum_inf, 20)
    seg8 = bezier_curve(p_cerebellum_inf, (cx + 360, cy + 300), (cx + 440, cy + 240), p_cerebellum_post, 20)
    seg9 = bezier_curve(p_cerebellum_post, (cx + 400, cy + 140), (cx + 360, cy + 120), p_transverse_sinus, 15)
    seg10 = bezier_curve(p_transverse_sinus, (cx + 420, cy + 60), (cx + 460, cy + 20), p_occipital_pole, 20)
    seg11 = bezier_curve(p_occipital_pole, (cx + 480, cy - 140), (cx + 440, cy - 220), p_parietal_slope, 25)
    seg12 = bezier_curve(p_parietal_slope, (cx + 340, cy - 360), (cx + 240, cy - 420), p_vertex, 30)
    seg13 = bezier_curve(p_vertex, (cx - 40, cy - 450), (cx - 140, cy - 440), p_superior_frontal, 25)
    
    full_brain_poly = seg1 + seg2 + seg3 + seg4 + seg5 + seg6 + seg7 + seg8 + seg9 + seg10 + seg11 + seg12 + seg13
    
    # 1. Soft ambient drop shadow underneath the brain
    shadow = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow, "RGBA")
    s_poly = [(pt[0] + 12, pt[1] + 24) for pt in full_brain_poly]
    s_draw.polygon(s_poly, fill=(0, 0, 0, 140))
    shadow = shadow.filter(ImageFilter.GaussianBlur(32))
    bg = Image.alpha_composite(bg, shadow)
    
    # 2. Solid Brain Silhouette Fill
    # Gradient tint: Clean titanium white with subtle surgical cyan base
    draw.polygon(full_brain_poly, fill=(245, 250, 255, 255))
    
    # 3. Elegant Anatomical Inset Sulcal Grooves (Dark navy negative space lines)
    # Sylvian fissure
    sylvian = bezier_curve((cx - 300, cy + 100), (cx - 180, cy + 60), (cx - 40, cy + 40), (cx + 140, cy - 20), 40)
    draw.line(sylvian, fill=(16, 26, 48, 255), width=24, joint="curve")
    
    # Central sulcus of Rolando
    central = bezier_curve((cx + 120, cy - 430), (cx + 80, cy - 280), (cx + 20, cy - 140), (cx - 10, cy + 20), 40)
    draw.line(central, fill=(16, 26, 48, 255), width=20, joint="curve")
    
    # Parieto-occipital sulcus
    pos = bezier_curve((cx + 320, cy - 320), (cx + 240, cy - 240), (cx + 180, cy - 160), (cx + 140, cy - 100), 30)
    draw.line(pos, fill=(16, 26, 48, 255), width=18, joint="curve")
    
    # Cerebellar horizontal folia groove
    folia = bezier_curve((cx + 180, cy + 260), (cx + 280, cy + 240), (cx + 360, cy + 220), (cx + 400, cy + 180), 30)
    draw.line(folia, fill=(16, 26, 48, 255), width=16, joint="curve")
    
    # 4. Focal Neon Cyan Crosshair Over Central Target (The Acute Call Focus)
    target_pt = (cx - 10, cy + 20)
    # Target crosshair arms
    arm_len = 120
    draw.line([(target_pt[0] - arm_len, target_pt[1]), (target_pt[0] + arm_len, target_pt[1])], fill=(0, 229, 255, 220), width=6)
    draw.line([(target_pt[0], target_pt[1] - arm_len), (target_pt[0], target_pt[1] + arm_len)], fill=(0, 229, 255, 220), width=6)
    
    # Concentric target reticles
    draw.ellipse([target_pt[0] - 40, target_pt[1] - 40, target_pt[0] + 40, target_pt[1] + 40], outline=(0, 229, 255, 255), width=5)
    draw.ellipse([target_pt[0] - 12, target_pt[1] - 12, target_pt[0] + 12, target_pt[1] + 12], fill=(0, 229, 255, 255))
    
    # 5. Composite and resize
    final_img = Image.alpha_composite(bg, overlay)
    rgb_img = Image.new("RGB", (w, h), (5, 7, 14))
    rgb_img.paste(final_img, mask=final_img.split()[3])
    res_1024 = rgb_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    return res_1024

if __name__ == "__main__":
    icon_d = generate_pro_icon_d()
    icon_d.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\pro_icon_d_anatomical_glyph.png")
    print("Icon D generated successfully!")
