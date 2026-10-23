import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_radial_gradient(w, h, inner_color, outer_color, center=(0.5, 0.44), radius_factor=0.85):
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

def generate_bold_sagittal_icon():
    size = 1024
    scale = 2
    w = size * scale
    h = size * scale
    
    # 1. Vibrant, elegant light purple/lavender canvas with strong contrast
    # Inner light lilac: #f8f6ff (248, 246, 255) -> Outer lavender: #dcd4ff (220, 212, 255)
    bg = create_radial_gradient(
        w, h,
        inner_color=(250, 248, 255),
        outer_color=(218, 208, 252),
        center=(0.5, 0.42),
        radius_factor=0.85
    )
    
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")
    
    cx = w / 2.0
    cy = h * 0.42
    
    # BOLD PALETTE (Extracted from Original Icon & Amplified for Pop):
    # Deep Midnight Indigo (Strong Contrast Anchor): #2e268a / #3730a3
    c_indigo_deep = (46, 38, 138, 255)
    c_indigo = (67, 56, 202, 255)
    c_indigo_bright = (79, 70, 229, 255)
    
    # Vivid Electric Cyan / Turquoise (High-Visibility Glow): #00E5FF / #06b6d4
    c_cyan = (6, 182, 212, 255)
    c_cyan_bright = (0, 229, 255, 255)
    
    # Vibrant Purple / Violet: #9333ea / #a855f7
    c_violet = (147, 51, 234, 255)
    c_violet_bright = (168, 85, 247, 255)
    
    c_white = (255, 255, 255, 255)
    c_red = (239, 68, 68, 255)
    
    # 2. Outer Bold Navigation Trephine Ring (Confidence & Framing)
    ring_r = 540
    # Soft drop shadow behind ring
    draw.ellipse([cx - ring_r, cy - ring_r + 14, cx + ring_r, cy + ring_r + 14], fill=(79, 70, 229, 30))
    # Outer crisp indigo ring
    draw.ellipse([cx - ring_r, cy - ring_r, cx + ring_r, cy + ring_r], outline=(79, 70, 229, 120), width=16)
    # Inner vivid cyan precision arc
    draw.ellipse([cx - ring_r, cy - ring_r, cx + ring_r, cy + ring_r], outline=c_cyan_bright, width=6)
    
    # 4 Cardinal Navigation Compass Ticks (North, East, South, West) - Bold & Clear
    for deg in [0, 90, 180, 270]:
        rad = math.radians(deg)
        t_len = 36
        x1 = cx + (ring_r - t_len) * math.cos(rad)
        y1 = cy + (ring_r - t_len) * math.sin(rad)
        x2 = cx + (ring_r + 8) * math.cos(rad)
        y2 = cy + (ring_r + 8) * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=c_indigo_deep, width=12)
        draw.line([x1, y1, x2, y2], fill=c_cyan_bright, width=6)
        
    # 3. Main Anatomical Sagittal Neuro-Axis Silhouette (Facing Right)
    # Enlarged, bold anatomical coordinates
    head_poly = [
        (cx - 250, cy + 230),  # Foramen magnum / tonsillar notch
        (cx - 330, cy + 170),  # Cerebellum inferior border
        (cx - 390, cy + 60),   # Cerebellar apex
        (cx - 410, cy - 70),   # Occipital pole
        (cx - 370, cy - 230),  # Parietal slope
        (cx - 240, cy - 360),  # Cranial vertex
        (cx - 70, cy - 430),   # Superior frontal
        (cx + 120, cy - 430),  # Prefrontal convexity
        (cx + 300, cy - 330),  # Frontal pole
        (cx + 380, cy - 190),  # Anterior skull base / cribriform
        (cx + 310, cy - 50),   # Chiasmatic sulcus / sella
        (cx + 360, cy + 70),   # Temporal tip
        (cx + 250, cy + 160),  # Middle cranial fossa
        (cx + 120, cy + 240),  # Clivus / anterior pons
        (cx + 30, cy + 290),   # Anterior brainstem / cervicomedullary junction
        # Spinal column continues vertically downwards
        (cx + 30, cy + 680),   # Anterior spinal cord base
        (cx - 190, cy + 680),  # Posterior spinal cord base
        (cx - 190, cy + 290),  # Posterior cervicomedullary junction
    ]
    
    # 4. Bold Ambient Drop Shadow under the entire brain/spine
    for dy, alpha in [(24, 40), (12, 60), (6, 80)]:
        s_poly = [(p[0], p[1] + dy) for p in head_poly]
        draw.polygon(s_poly, fill=(46, 38, 138, alpha))
        
    # 5. SOLID BOLD FILL FOR THE BRAIN (Deep Royal Indigo Gradient)
    # A solid, rich fill gives immense presence and eliminates wispy lines!
    draw.polygon(head_poly, fill=c_indigo_deep)
    
    # 6. Bold Multi-Layer Outer Perimeter
    draw.line(head_poly + [head_poly[0]], fill=c_indigo_deep, width=28, joint="curve")
    draw.line(head_poly + [head_poly[0]], fill=c_violet_bright, width=16, joint="curve")
    draw.line(head_poly + [head_poly[0]], fill=c_white, width=6, joint="curve")
    
    # 7. High-Contrast Internal Gyral Crest & Sylvian Fissure (Vibrant Cyan)
    # Bold sweeping surgical corridors that define the cranial lobes instantly
    sylvian_pts = [
        (cx + 270, cy + 20),
        (cx + 150, cy - 40),
        (cx - 40, cy - 100),
        (cx - 190, cy - 150)
    ]
    draw.line(sylvian_pts, fill=c_cyan_bright, width=18, joint="curve")
    draw.line(sylvian_pts, fill=c_white, width=8, joint="curve")
    
    # Central Sulcus Crest (Vertex to Sylvian)
    central_pts = [
        (cx - 120, cy - 390),
        (cx - 10, cy - 250),
        (cx + 60, cy - 140)
    ]
    draw.line(central_pts, fill=c_violet_bright, width=14, joint="curve")
    draw.line(central_pts, fill=c_white, width=6, joint="curve")
    
    # 8. Bold Corpus Callosum Arc (The Definitive Sagittal Anatomic Landmark)
    callosum_pts = [
        (cx + 170, cy - 110),  # Genu
        (cx + 100, cy - 190),  # Rostrum / Anterior Body
        (cx - 50, cy - 220),   # Body apex
        (cx - 180, cy - 170),  # Posterior body
        (cx - 250, cy - 80),   # Splenium
    ]
    draw.line(callosum_pts, fill=(0, 229, 255, 120), width=32, joint="curve")
    draw.line(callosum_pts, fill=c_cyan_bright, width=20, joint="curve")
    draw.line(callosum_pts, fill=c_white, width=8, joint="curve")
    
    # Lateral Ventricle Interior C-Cavity
    ventricle_pts = [
        (cx + 130, cy - 60),  # Frontal horn
        (cx + 10, cy - 110),  # Body
        (cx - 140, cy - 70),  # Atrium
        (cx - 210, cy - 20),  # Occipital horn
        (cx - 140, cy + 30),  # Temporal loop
        (cx - 30, cy + 70)    # Temporal tip
    ]
    draw.line(ventricle_pts, fill=(79, 70, 229, 255), width=12, joint="curve")
    draw.line(ventricle_pts, fill=c_cyan_bright, width=5, joint="curve")
    
    # 9. Cerebellar Arbor Vitae Foliation (Crisp Cyan & Violet Foliation)
    c_x = cx - 250
    c_y = cy + 90
    draw.arc([c_x - 100, c_y - 80, c_x + 100, c_y + 80], 120, 310, fill=c_violet_bright, width=12)
    draw.arc([c_x - 70, c_y - 55, c_x + 70, c_y + 55], 130, 300, fill=c_cyan_bright, width=10)
    draw.arc([c_x - 40, c_y - 30, c_x + 40, c_y + 30], 140, 290, fill=c_white, width=6)
    
    # 10. BOLD SPINAL AXIS COLUMN (C1–C7 & Thoracic Segmented Blocks)
    # Highly distinct rectangular vertebral segments with bright neon cyan disc spaces
    spine_center_x = cx - 80
    vert_start_y = cy + 300
    vert_w = 210
    vert_h = 52
    vert_gap = 18
    
    for i in range(5):
        vy = vert_start_y + i * (vert_h + vert_gap)
        vx = spine_center_x - vert_w / 2.0
        
        # Drop shadow behind each vertebra
        draw.rounded_rectangle([vx, vy + 4, vx + vert_w, vy + vert_h + 4], radius=12, fill=(46, 38, 138, 80))
        # Bold Vertebral Body Block (Deep Indigo)
        draw.rounded_rectangle([vx, vy, vx + vert_w, vy + vert_h], radius=12, fill=c_indigo_deep, outline=c_violet_bright, width=6)
        
        # Superior and Inferior Endplate Laser Highlight
        draw.line([vx + 14, vy + 6, vx + vert_w - 14, vy + 6], fill=c_cyan_bright, width=5)
        draw.line([vx + 14, vy + vert_h - 6, vx + vert_w - 14, vy + vert_h - 6], fill=c_white, width=4)
        
        # Central Cord Canal Node (Alternating Electric Cyan & Titanium White)
        node_c = c_cyan_bright if i % 2 == 0 else c_white
        draw.ellipse([spine_center_x - 14, vy + vert_h/2 - 14, spine_center_x + 14, vy + vert_h/2 + 14], fill=node_c, outline=c_indigo_deep, width=4)
        
    # Vertical Central Spinal Cord Plumb Line (Neon Cyan Laser)
    draw.line([spine_center_x, cy + 240, spine_center_x, vert_start_y + 5 * (vert_h + vert_gap) + 10], fill=c_cyan_bright, width=10)
    draw.line([spine_center_x, cy + 240, spine_center_x, vert_start_y + 5 * (vert_h + vert_gap) + 10], fill=c_white, width=4)
    
    # 11. BOLD STEREOTACTIC TARGET RETICLE (Sella / Brainstem Hub)
    # The vivid surgical red accent from the original icon
    target_x = cx + 90
    target_y = cy + 100
    
    # Outer cyan reticle ring
    draw.ellipse([target_x - 42, target_y - 42, target_x + 42, target_y + 42], outline=c_cyan_bright, width=8)
    draw.ellipse([target_x - 22, target_y - 22, target_x + 22, target_y + 22], outline=c_violet_bright, width=6)
    
    # Crosshair lines
    draw.line([target_x - 65, target_y, target_x + 65, target_y], fill=c_cyan_bright, width=6)
    draw.line([target_x, target_y - 65, target_x, target_y + 65], fill=c_cyan_bright, width=6)
    
    # Center Red & White Pulse Dot
    draw.ellipse([target_x - 12, target_y - 12, target_x + 12, target_y + 12], fill=c_red, outline=c_white, width=3)
    
    # 12. Composite & Downsample with Lanczos to exactly 1024x1024 RGB
    final_rgba = Image.alpha_composite(bg.convert("RGBA"), overlay)
    final_rgb = final_rgba.convert("RGB").resize((size, size), Image.Resampling.LANCZOS)
    return final_rgb

if __name__ == "__main__":
    icon = generate_bold_sagittal_icon()
    out_brain = r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\sagittal_neuro_axis_bold_master.png"
    out_app = r"C:\Users\mohal\Documents\antigravity\Radix\Assets.xcassets\AppIcon.appiconset\AppIcon.png"
    
    icon.save(out_brain, "PNG")
    icon.save(out_app, "PNG")
    
    # Also save a 180x180 thumbnail preview so we can inspect mobile home screen resolution!
    thumb = icon.resize((180, 180), Image.Resampling.LANCZOS)
    out_thumb = r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\sagittal_neuro_axis_bold_thumb180.png"
    thumb.save(out_thumb, "PNG")
    
    print("BOLD Sagittal Neuro-Axis AppIcon generated successfully at 1024x1024 and 180x180 preview!")
