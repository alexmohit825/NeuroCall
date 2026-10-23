import math
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

def create_radial_gradient(width, height, center_color, edge_color, center_pos=(0.5, 0.45), radius_factor=0.85):
    img = Image.new("RGB", (width, height))
    arr = np.zeros((height, width, 3), dtype=np.float32)
    
    cx, cy = int(width * center_pos[0]), int(height * center_pos[1])
    max_radius = width * radius_factor
    
    y_indices, x_indices = np.indices((height, width))
    dist = np.sqrt((x_indices - cx) ** 2 + (y_indices - cy) ** 2)
    t = np.clip(dist / max_radius, 0.0, 1.0)
    
    # Smooth Hermite curve
    t_smooth = t * t * (3 - 2 * t)
    
    for c in range(3):
        c_start = center_color[c]
        c_end = edge_color[c]
        arr[:, :, c] = c_start * (1 - t_smooth) + c_end * t_smooth
        
    return Image.fromarray(np.uint8(arr))

# Let's create Option 1: "The Surgical Caliper & Cerebral Crest"
# Clean, modern, aerospace midnight blue, cyan/white precision vector lines.
def generate_icon_option_1():
    size = 1024
    scale = 2  # Super-sample 2048x2048 for razor-sharp anti-aliased rendering
    w = size * scale
    h = size * scale
    
    # Background: Deep luxury surgical navy / obsidian
    bg = create_radial_gradient(w, h, (18, 28, 48), (6, 8, 14), center_pos=(0.5, 0.46), radius_factor=0.9)
    draw = ImageDraw.Draw(bg, "RGBA")
    
    cx, cy = w / 2, h / 2 - 20
    
    # 1. Subtle stereotactic coordinate grid circles
    for r, op in [(480, 25), (680, 18), (860, 12)]:
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(0, 229, 255, op), width=3)
        
    # Subtle crosshair lines
    draw.line([cx, cy - 880, cx, cy + 880], fill=(255, 255, 255, 15), width=2)
    draw.line([cx - 880, cy, cx + 880, cy], fill=(255, 255, 255, 15), width=2)
    
    # 2. Main Outer Caliper Ring (Precision Trephine Frame)
    ring_r = 560
    # Outer glow
    for g_r, g_op in [(ring_r + 8, 40), (ring_r + 4, 80), (ring_r, 220)]:
        draw.ellipse([cx - g_r, cy - g_r, cx + g_r, cy + g_r], outline=(0, 229, 255, g_op), width=10)
    # Core bright white/cyan ring
    draw.ellipse([cx - ring_r, cy - ring_r, cx + ring_r, cy + ring_r], outline=(220, 250, 255, 240), width=8)
    
    # Cardinal Caliper Tick Marks
    tick_len = 36
    ticks = [
        ([cx, cy - ring_r - tick_len / 2, cx, cy - ring_r + tick_len / 2]),
        ([cx, cy + ring_r - tick_len / 2, cx, cy + ring_r + tick_len / 2]),
        ([cx - ring_r - tick_len / 2, cy, cx - ring_r + tick_len / 2, cy]),
        ([cx + ring_r - tick_len / 2, cy, cx + ring_r + tick_len / 2, cy])
    ]
    for t in ticks:
        draw.line(t, fill=(0, 229, 255, 255), width=8)
        
    # Angle tick marks at 45 degrees
    for deg in [45, 135, 225, 315]:
        rad = math.radians(deg)
        x1 = cx + (ring_r - 18) * math.cos(rad)
        y1 = cy + (ring_r - 18) * math.sin(rad)
        x2 = cx + (ring_r + 18) * math.cos(rad)
        y2 = cy + (ring_r + 18) * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=(0, 229, 255, 180), width=6)
        
    # 3. Central Iconography: Minimalist Brain & Spinal Cord Axis
    # Left hemisphere and right hemisphere stylized curvilinear lobes
    # Frontal, Parietal, Occipital, Temporal arc paths
    
    # We construct smooth bezier-like arcs for left and right cerebral lobes
    # Left cerebral perimeter arc
    left_cortex = [
        (cx - 30, cy - 360),
        (cx - 160, cy - 350),
        (cx - 290, cy - 280),
        (cx - 360, cy - 140),
        (cx - 370, cy + 30),
        (cx - 330, cy + 180),
        (cx - 240, cy + 280),
        (cx - 140, cy + 320),
        (cx - 50, cy + 290)
    ]
    
    # Right cerebral perimeter arc
    right_cortex = [
        (cx + 30, cy - 360),
        (cx + 160, cy - 350),
        (cx + 290, cy - 280),
        (cx + 360, cy - 140),
        (cx + 370, cy + 30),
        (cx + 330, cy + 180),
        (cx + 240, cy + 280),
        (cx + 140, cy + 320),
        (cx + 50, cy + 290)
    ]
    
    # Draw smooth cortex lines with neon glow
    for cortex, color, glow_color in [(left_cortex, (0, 229, 255, 255), (0, 180, 255, 60)), 
                                      (right_cortex, (255, 255, 255, 255), (200, 230, 255, 60))]:
        # Glow
        for gw in [24, 16]:
            draw.line(cortex, fill=glow_color, width=gw, joint="curve")
        # Solid stroke
        draw.line(cortex, fill=color, width=14, joint="curve")
        
    # Internal Gyral Sulcal Arcs (Minimalist anatomical sweeps)
    # Left inner sulcus
    l_sulcus_1 = [(cx - 60, cy - 220), (cx - 180, cy - 180), (cx - 240, cy - 80), (cx - 180, cy + 20), (cx - 90, cy + 100)]
    draw.line(l_sulcus_1, fill=(0, 229, 255, 200), width=10, joint="curve")
    
    l_sulcus_2 = [(cx - 240, cy + 60), (cx - 180, cy + 160), (cx - 100, cy + 190)]
    draw.line(l_sulcus_2, fill=(0, 229, 255, 180), width=9, joint="curve")
    
    # Right inner sulcus (symmetrical reflection)
    r_sulcus_1 = [(cx + 60, cy - 220), (cx + 180, cy - 180), (cx + 240, cy - 80), (cx + 180, cy + 20), (cx + 90, cy + 100)]
    draw.line(r_sulcus_1, fill=(255, 255, 255, 220), width=10, joint="curve")
    
    r_sulcus_2 = [(cx + 240, cy + 60), (cx + 180, cy + 160), (cx + 100, cy + 190)]
    draw.line(r_sulcus_2, fill=(255, 255, 255, 200), width=9, joint="curve")
    
    # 4. Central Brainstem & Spinal Cord Plumb Axis (The Vertical Core)
    # Straight vertical line descending from vertex to base
    stem_top = cy + 270
    stem_bottom = cy + 540
    
    # Glowing vertical cord
    draw.line([(cx, stem_top), (cx, stem_bottom)], fill=(0, 229, 255, 60), width=24)
    draw.line([(cx, stem_top), (cx, stem_bottom)], fill=(0, 229, 255, 255), width=14)
    draw.line([(cx, stem_top), (cx, stem_bottom)], fill=(255, 255, 255, 255), width=6)
    
    # Spinal Segment Beads / Nodes (C1, C2, C3, C4)
    for seg_y in [stem_top + 50, stem_top + 120, stem_top + 190, stem_top + 260]:
        draw.ellipse([cx - 18, seg_y - 18, cx + 18, seg_y + 18], fill=(10, 16, 28), outline=(0, 229, 255, 255), width=6)
        draw.ellipse([cx - 6, seg_y - 6, cx + 6, seg_y + 6], fill=(255, 255, 255, 255))
        
    # 5. Top Acute Call Pulse / Vertex Target Dot
    vertex_y = cy - 360
    draw.ellipse([cx - 24, vertex_y - 24, cx + 24, vertex_y + 24], fill=(0, 229, 255, 50))
    draw.ellipse([cx - 14, vertex_y - 14, cx + 14, vertex_y + 14], fill=(0, 229, 255, 255))
    draw.ellipse([cx - 6, vertex_y - 6, cx + 6, vertex_y + 6], fill=(255, 255, 255, 255))
    
    # Downsample with Lanczos high-quality resampling to exact 1024x1024
    img_1024 = bg.resize((size, size), Image.Resampling.LANCZOS)
    return img_1024

# Let's create Option 2: "The Minimalist Monogram Trephine"
# Clean geometric luxury: Stylized 'N' intersecting with a surgical trephine ring and subtle cerebellar curve.
def generate_icon_option_2():
    size = 1024
    scale = 2
    w = size * scale
    h = size * scale
    
    # Deep slate/obsidian gradient
    bg = create_radial_gradient(w, h, (14, 22, 38), (5, 7, 12), center_pos=(0.5, 0.48), radius_factor=0.9)
    draw = ImageDraw.Draw(bg, "RGBA")
    
    cx, cy = w / 2, h / 2
    
    # Concentric depth circles
    for r in [400, 600, 780]:
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(255, 255, 255, 12), width=3)
        
    # Modern Surgical Trephine Circle
    main_r = 480
    draw.ellipse([cx - main_r, cy - main_r, cx + main_r, cy + main_r], outline=(0, 229, 255, 40), width=18)
    draw.ellipse([cx - main_r, cy - main_r, cx + main_r, cy + main_r], outline=(0, 229, 255, 230), width=10)
    draw.ellipse([cx - main_r, cy - main_r, cx + main_r, cy + main_r], outline=(255, 255, 255, 255), width=4)
    
    # The 'N' Vector: Left pillar, diagonal trajectory ray, right pillar
    # Left pillar (Frontal-temporal axis)
    p1 = (cx - 240, cy + 320)
    p2 = (cx - 240, cy - 320)
    # Right pillar (Occipital-parietal axis)
    p3 = (cx + 240, cy + 320)
    p4 = (cx + 240, cy - 320)
    
    # Diagonal trajectory (The Operative Corridor)
    # Glowing diagonal ray
    draw.line([p2, p3], fill=(0, 229, 255, 60), width=28)
    draw.line([p2, p3], fill=(0, 229, 255, 255), width=16)
    draw.line([p2, p3], fill=(255, 255, 255, 255), width=8)
    
    # Vertical pillars
    for pt_a, pt_b in [(p1, p2), (p3, p4)]:
        draw.line([pt_a, pt_b], fill=(255, 255, 255, 240), width=14)
        
    # Caliper Crosshair Pins at the 4 Vertices
    for pt in [p1, p2, p3, p4]:
        draw.ellipse([pt[0] - 24, pt[1] - 24, pt[0] + 24, pt[1] + 24], fill=(10, 18, 32), outline=(0, 229, 255, 255), width=6)
        draw.ellipse([pt[0] - 8, pt[1] - 8, pt[0] + 8, pt[1] + 8], fill=(255, 255, 255, 255))
        
    # Subtle central pulse indicator
    draw.ellipse([cx - 16, cy - 16, cx + 16, cy + 16], fill=(0, 229, 255, 80))
    draw.ellipse([cx - 8, cy - 8, cx + 8, cy + 8], fill=(0, 229, 255, 255))
    
    img_1024 = bg.resize((size, size), Image.Resampling.LANCZOS)
    return img_1024

# Let's create Option 3: "The Pure Anatomic Silhouette"
# Crisp, pure medical silhouette: Stylized sagittal brain profile inside a glowing titanium surgical caliper ring.
def generate_icon_option_3():
    size = 1024
    scale = 2
    w = size * scale
    h = size * scale
    
    bg = create_radial_gradient(w, h, (20, 28, 46), (5, 7, 12), center_pos=(0.5, 0.46), radius_factor=0.92)
    draw = ImageDraw.Draw(bg, "RGBA")
    
    cx, cy = w / 2, h / 2
    
    # Outer Caliper Ring
    r = 540
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(0, 229, 255, 30), width=16)
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(0, 229, 255, 200), width=8)
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(255, 255, 255, 240), width=4)
    
    # Precision degree tick marks around ring
    for deg in range(0, 360, 15):
        rad = math.radians(deg)
        t_len = 24 if deg % 90 == 0 else (16 if deg % 45 == 0 else 8)
        color = (255, 255, 255, 240) if deg % 90 == 0 else (0, 229, 255, 140)
        width = 6 if deg % 90 == 0 else 3
        x1 = cx + (r - t_len) * math.cos(rad)
        y1 = cy + (r - t_len) * math.sin(rad)
        x2 = cx + r * math.cos(rad)
        y2 = cy + r * math.sin(rad)
        draw.line([x1, y1, x2, y2], fill=color, width=width)
        
    # Sagittal Cranial Silhouette (Facing Right)
    # Clean, iconic vector path: frontal pole, vertex, occiput, cerebellum, brainstem
    head_pts = [
        (cx - 180, cy + 280), # Brainstem
        (cx - 240, cy + 240), # Foramen magnum / tonsil
        (cx - 320, cy + 180), # Cerebellum
        (cx - 360, cy + 60),  # Occipital pole
        (cx - 340, cy - 140), # Parietal slope
        (cx - 240, cy - 280), # Vertex
        (cx - 100, cy - 350), # Superior frontal
        (cx + 80, cy - 360),  # Pre-frontal
        (cx + 260, cy - 280), # Frontal pole
        (cx + 340, cy - 160), # Anterior skull base / cribriform
        (cx + 280, cy - 40),  # Sella / Chiasm
        (cx + 320, cy + 80),  # Temporal tip
        (cx + 220, cy + 180), # Middle cranial fossa floor
        (cx + 100, cy + 260), # Clivus
        (cx - 40, cy + 300),  # Anterior brainstem
        (cx - 120, cy + 300)  # Cervical junction
    ]
    
    # Soft glowing fill
    draw.polygon(head_pts, fill=(0, 229, 255, 25))
    
    # Outer crisp line
    for gw, col in [(20, (0, 229, 255, 40)), (12, (0, 229, 255, 180)), (6, (255, 255, 255, 255))]:
        draw.line(head_pts + [head_pts[0]], fill=col, width=gw, joint="curve")
        
    # Central Sylvian Fissure line & Ventricle silhouette
    fissure_pts = [(cx + 260, cy + 60), (cx + 140, cy + 20), (cx - 40, cy - 40), (cx - 180, cy - 120)]
    draw.line(fissure_pts, fill=(0, 229, 255, 220), width=8, joint="curve")
    
    # Lateral Ventricle C-Shape
    ventricle_pts = [
        (cx + 120, cy - 100), # Frontal horn
        (cx - 20, cy - 120),  # Body
        (cx - 140, cy - 60),  # Atrium
        (cx - 200, cy - 30),  # Occipital horn
        (cx - 140, cy + 20),  # Temporal loop
        (cx - 20, cy + 70)    # Temporal tip
    ]
    draw.line(ventricle_pts, fill=(0, 229, 255, 180), width=7, joint="curve")
    
    img_1024 = bg.resize((size, size), Image.Resampling.LANCZOS)
    return img_1024

if __name__ == "__main__":
    opt1 = generate_icon_option_1()
    opt1.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\app_icon_option_1_caliper_cortex.png")
    
    opt2 = generate_icon_option_2()
    opt2.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\app_icon_option_2_trephine_monogram.png")
    
    opt3 = generate_icon_option_3()
    opt3.save(r"C:\Users\mohal\.gemini\antigravity\brain\b0f2e349-dd2c-4594-bf69-cd5e2a1e75ca\app_icon_option_3_sagittal_silhouette.png")
    
    print("All 3 icon variations generated successfully at 1024x1024!")
