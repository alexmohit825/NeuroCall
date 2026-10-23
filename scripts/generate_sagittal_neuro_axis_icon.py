import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_radial_gradient(w, h, inner_color, outer_color, center=(0.5, 0.45), radius_factor=0.85):
    cx = w * center[0]
    cy = h * center[1]
    max_r = math.hypot(w, h) * radius_factor
    
    y, x = np.ogrid[:h, :w]
    dist = np.hypot(x - cx, y - cy)
    t = np.clip(dist / max_r, 0.0, 1.0)
    
    # Smooth step
    t = t * t * (3 - 2 * t)
    
    r = (1.0 - t) * inner_color[0] + t * outer_color[0]
    g = (1.0 - t) * inner_color[1] + t * outer_color[1]
    b = (1.0 - t) * inner_color[2] + t * outer_color[2]
    
    arr = np.dstack([r, g, b]).astype(np.uint8)
    return Image.fromarray(arr, "RGB")

def generate_sagittal_neuro_axis_icon():
    size = 1024
    scale = 2
    w = size * scale
    h = size * scale
    
    # Light Purple / Lavender Palette:
    # Inner light: #fbf9ff (251, 249, 255), Outer perimeter: #e9e3ff (233, 227, 255)
    bg = create_radial_gradient(
        w, h,
        inner_color=(252, 250, 255),
        outer_color=(230, 222, 252),
        center=(0.5, 0.42),
        radius_factor=0.8
    )
    
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx = w / 2.0
    cy = h * 0.44
    
    # Original Icon Color Accents:
    # Deep Royal Indigo: #4338ca (67, 56, 202) & #4f46e5 (79, 70, 229)
    # Vibrant Violet: #9333ea (147, 51, 234) & #a855f7 (168, 85, 247)
    # Electric Cyan: #06b6d4 (6, 182, 212) & #0891b2 (8, 145, 178)
    # Pure White: #ffffff
    # Surgical Red: #ef4444 (239, 68, 68)
    
    c_indigo = (67, 56, 202, 255)
    c_indigo_bright = (79, 70, 229, 255)
    c_violet = (147, 51, 234, 255)
    c_violet_soft = (168, 85, 247, 180)
    c_cyan = (6, 182, 212, 255)
    c_cyan_bright = (8, 205, 240, 255)
    c_white = (255, 255, 255, 255)
    c_red = (239, 68, 68, 255)
    
    # 1. Subtle Precision Caliper / Trephine Circular Halo in background
    caliper_r = 520
    draw.ellipse([cx - caliper_r, cy - caliper_r, cx + caliper_r, cy + caliper_r], outline=(147, 51, 234, 35), width=8)
    draw.ellipse([cx - caliper_r, cy - caliper_r, cx + caliper_r, cy + caliper_r], outline=(79, 70, 229, 70), width=3)
    
    # Fine degree ticks around the caliper halo
    for deg in range(0, 360, 10):
        rad = math.radians(deg)
        t_len = 24 if deg % 90 == 0 else (16 if deg % 30 == 0 else 8)
        c_tick = (79, 70, 229, 140) if deg % 30 == 0 else (147, 51, 234, 60)
        t_w = 5 if deg % 90 == 0 else (3 if deg % 30 == 0 else 2)
        x1 = cx + (caliper_r - t_len) * math.cos(rad)
        y1 = cy + (caliper_r - t_len) * math.sin(rad)
        x2 = cx + caliper_r * math.cos(rad)
        y2 = cy + caliper_r * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=c_tick, width=t_w)
    
    # 2. Sagittal Neuro-Axis Anatomy (Facing Right):
    # Head & Brainstem Coordinates scaled and centered
    head_poly = [
        (cx - 240, cy + 220),  # Cerebellar tonsil / Foramen magnum
        (cx - 320, cy + 150),  # Suboccipital notch / lower cerebellum
        (cx - 370, cy + 40),   # Cerebellar apex
        (cx - 390, cy - 80),   # Occipital pole
        (cx - 350, cy - 230),  # Parietal curve
        (cx - 220, cy - 350),  # Cranial vertex
        (cx - 60, cy - 410),   # Superior frontal
        (cx + 120, cy - 410),  # Prefrontal curve
        (cx + 280, cy - 320),  # Frontal pole
        (cx + 350, cy - 190),  # Anterior fossa floor / cribriform
        (cx + 290, cy - 60),   # Chiasmatic sulcus / sella
        (cx + 340, cy + 50),   # Temporal pole
        (cx + 240, cy + 140),  # Middle fossa floor
        (cx + 120, cy + 220),  # Clivus slope
        (cx + 20, cy + 270),   # Anterior brainstem / pons
        (cx - 60, cy + 280),   # Anterior medulla / cervicomedullary junction
        # Spine column continues downwards
        (cx - 60, cy + 620),   # Anterior spinal cord base
        (cx - 160, cy + 620),  # Posterior spinal cord base
        (cx - 160, cy + 280),  # Posterior medulla
    ]
    
    # Soft anatomical fill (royal indigo / violet translucent glow)
    draw.polygon(head_poly, fill=(79, 70, 229, 22))
    
    # Soft drop shadow / ambient contour under the head
    for offset_y, blur_alpha in [(8, 25), (4, 45)]:
        shadow_pts = [(p[0], p[1] + offset_y) for p in head_poly]
        draw.polygon(shadow_pts, fill=(67, 56, 202, blur_alpha))
        
    # Main outer anatomical perimeter - thick multi-layer vector strokes
    # Deep royal indigo outer line
    draw.line(head_poly + [head_poly[0]], fill=(67, 56, 202, 220), width=18, joint="curve")
    # Vibrant violet middle highlight
    draw.line(head_poly + [head_poly[0]], fill=(147, 51, 234, 255), width=10, joint="curve")
    # Crisp titanium core line
    draw.line(head_poly + [head_poly[0]], fill=(255, 255, 255, 255), width=4, joint="curve")
    
    # 3. Internal Neuroanatomy: Corpus Callosum C-Shape Arc (Violet & Cyan)
    # The anatomical C-shaped roof of the lateral ventricles
    callosum_pts = [
        (cx + 160, cy - 110),  # Genu
        (cx + 90, cy - 180),   # Rostrum / Anterior Body
        (cx - 50, cy - 200),   # Body apex
        (cx - 170, cy - 160),  # Posterior body
        (cx - 230, cy - 80),   # Splenium
    ]
    draw.line(callosum_pts, fill=(6, 182, 212, 100), width=18, joint="curve")
    draw.line(callosum_pts, fill=(6, 182, 212, 255), width=10, joint="curve")
    draw.line(callosum_pts, fill=(255, 255, 255, 240), width=4, joint="curve")
    
    # Lateral Ventricle Interior Arc
    ventricle_pts = [
        (cx + 120, cy - 70),  # Frontal horn
        (cx + 10, cy - 110),  # Ventricle body
        (cx - 130, cy - 80),  # Atrium / Trigone
        (cx - 200, cy - 30),  # Occipital horn
        (cx - 130, cy + 20),  # Temporal horn
        (cx - 30, cy + 60)    # Temporal tip
    ]
    draw.line(ventricle_pts, fill=(79, 70, 229, 200), width=7, joint="curve")
    
    # Sylvian Fissure Gyral Crest (Electric Cyan)
    sylvian_pts = [
        (cx + 250, cy + 10),
        (cx + 130, cy - 30),
        (cx - 40, cy - 80),
        (cx - 170, cy - 130)
    ]
    draw.line(sylvian_pts, fill=(6, 182, 212, 240), width=7, joint="curve")
    
    # 4. Cerebellar Folia / Arbor Vitae Branching
    cerebellum_cx = cx - 230
    cerebellum_cy = cy + 90
    draw.arc([cerebellum_cx - 90, cerebellum_cy - 70, cerebellum_cx + 90, cerebellum_cy + 70], 120, 310, fill=(147, 51, 234, 180), width=6)
    draw.arc([cerebellum_cx - 60, cerebellum_cy - 50, cerebellum_cx + 60, cerebellum_cy + 50], 130, 300, fill=(6, 182, 212, 160), width=4)
    
    # 5. The Spinal Axis Column (C1 through C7 & Thoracic Neuro-Axis)
    # Vertebral segments with intervertebral disc spaces and central spinal cord canal
    spine_x = cx - 110
    vert_start_y = cy + 290
    vert_height = 42
    vert_gap = 14
    
    for i in range(5):
        vy = vert_start_y + i * (vert_height + vert_gap)
        vw = 180
        vx = spine_x - vw / 2.0
        
        # Vertebral body box with rounded corners
        draw.rounded_rectangle([vx, vy, vx + vw, vy + vert_height], radius=10, fill=(79, 70, 229, 30), outline=(67, 56, 202, 200), width=4)
        
        # Endplate highlighted lines (Anterior to Posterior)
        draw.line([vx + 8, vy + 4, vx + vw - 8, vy + 4], fill=(147, 51, 234, 240), width=3)
        draw.line([vx + 8, vy + vert_height - 4, vx + vw - 8, vy + vert_height - 4], fill=(6, 182, 212, 200), width=3)
        
        # Central spinal cord node
        node_color = c_cyan_bright if i % 2 == 0 else c_violet
        draw.ellipse([spine_x - 8, vy + vert_height/2 - 8, spine_x + 8, vy + vert_height/2 + 8], fill=node_color)
        
    # Spinal cord central canal vertical plumb line (Laser surgical guide)
    draw.line([spine_x, cy + 220, spine_x, vert_start_y + 5 * (vert_height + vert_gap)], fill=(6, 182, 212, 255), width=5)
    draw.line([spine_x, cy + 220, spine_x, vert_start_y + 5 * (vert_height + vert_gap)], fill=(255, 255, 255, 240), width=2)
    
    # 6. Radiologic Crosshair Reticle on Brainstem / Sella Axis (Stereotactic Target)
    cross_x = cx + 80
    cross_y = cy + 100
    
    # Target ring
    draw.ellipse([cross_x - 30, cross_y - 30, cross_x + 30, cross_y + 30], outline=(6, 182, 212, 120), width=4)
    draw.ellipse([cross_x - 14, cross_y - 14, cross_x + 14, cross_y + 14], outline=(147, 51, 234, 200), width=3)
    # Crosshair pins
    draw.line([cross_x - 45, cross_y, cross_x + 45, cross_y], fill=(6, 182, 212, 200), width=3)
    draw.line([cross_x, cross_y - 45, cross_x, cross_y + 45], fill=(6, 182, 212, 200), width=3)
    # Central pulse dot (Surgical Red accent from original icon)
    draw.ellipse([cross_x - 6, cross_y - 6, cross_x + 6, cross_y + 6], fill=c_red)
    draw.ellipse([cross_x - 2, cross_y - 2, cross_x + 2, cross_y + 2], fill=c_white)
    
    # Alpha composite onto light purple background
    final_rgba = Image.alpha_composite(bg.convert("RGBA"), overlay)
    
    # Downsample with high-grade Lanczos filtering to exactly 1024x1024 RGB
    final_rgb = final_rgba.convert("RGB").resize((size, size), Image.Resampling.LANCZOS)
    return final_rgb

if __name__ == "__main__":
    icon = generate_sagittal_neuro_axis_icon()
    out_brain = r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\sagittal_neuro_axis_light_purple_master.png"
    out_app = r"C:\Users\mohal\Documents\antigravity\Radix\Assets.xcassets\AppIcon.appiconset\AppIcon.png"
    
    icon.save(out_brain, "PNG")
    icon.save(out_app, "PNG")
    print(f"Successfully generated 1024x1024 Sagittal Neuro-Axis AppIcon on Light Purple background!")
    print(f"Saved to: {out_brain}")
    print(f"Saved to: {out_app}")
