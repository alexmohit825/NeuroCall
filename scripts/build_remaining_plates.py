import os
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

ASSETS_DIR = "Assets.xcassets"

def save_to_assets(plate_name, pil_img):
    target_folder = os.path.join(ASSETS_DIR, f"{plate_name}.imageset")
    os.makedirs(target_folder, exist_ok=True)
    target_path = os.path.join(target_folder, f"{plate_name}.jpg")
    if pil_img.mode != "RGB":
        pil_img = pil_img.convert("RGB")
    pil_img.save(target_path, "JPEG", quality=95)
    print(f"[OK] Finalized {plate_name}: {pil_img.size}")

# 1. plate_spine_tumor_compression: Real sagittal T2 MRI of spinal cord tumor compression
if os.path.exists("scripts/clean_plates/spinal_tumor_ependymoma.jpg"):
    raw = Image.open("scripts/clean_plates/spinal_tumor_ependymoma.jpg")
    target_h = 860
    target_w = int(raw.width * target_h / raw.height)
    resized = raw.resize((target_w, target_h), Image.Resampling.LANCZOS)
    
    canvas = Image.new("RGB", (1024, 1024), color=(10, 12, 18))
    x_off = (1024 - target_w) // 2
    canvas.paste(resized, (x_off, 70))
    
    draw = ImageDraw.Draw(canvas)
    # Header
    draw.rectangle([(20, 15), (550, 50)], outline=(0, 215, 255), width=2)
    draw.text((30, 23), "SPINAL CORD COMPRESSION: SPINAL CORD TUMOR (T2 MRI)", fill=(0, 215, 255))
    
    # Orientations
    draw.rectangle([(x_off + target_w - 90, 15), (x_off + target_w - 20, 50)], outline=(255, 215, 0), width=2)
    draw.text((x_off + target_w - 75, 23), "SUP", fill=(255, 215, 0))
    
    draw.rectangle([(x_off + target_w - 90, 950), (x_off + target_w - 20, 985)], outline=(255, 165, 0), width=2)
    draw.text((x_off + target_w - 75, 958), "INF", fill=(255, 165, 0))
    
    # Footer legend
    draw.text((30, 950), "Left: Intramedullary mass expanding cord with T2 CSF sleeve obliteration", fill=(200, 220, 240))
    draw.text((30, 975), "Right: Red margin = tumor extent; Yellow arrows = compressed spinal cord", fill=(255, 215, 0))
    save_to_assets("plate_spine_tumor_compression", canvas)

# 2. plate_spine_jumped_facets: Unilateral/Bilateral Facet Dislocation
if os.path.exists("scripts/downloads_spine/plate_spine_jumped_facets.jpg"):
    raw = Image.open("scripts/downloads_spine/plate_spine_jumped_facets.jpg")
    target_h = 840
    target_w = int(raw.width * target_h / raw.height)
    resized = raw.resize((target_w, target_h), Image.Resampling.LANCZOS)
    
    canvas = Image.new("RGB", (1024, 1024), color=(10, 12, 18))
    x_off = (1024 - target_w) // 2
    canvas.paste(resized, (x_off, 80))
    
    draw = ImageDraw.Draw(canvas)
    draw.rectangle([(20, 15), (600, 50)], outline=(255, 80, 80), width=2)
    draw.text((30, 23), "CERVICAL FACET DISLOCATION / JUMPED FACETS (C5-C6)", fill=(255, 80, 80))
    
    draw.text((30, 945), "Disrupted anterior & posterior vertebral lines | Anterior listhesis >50% | Locked superior articular facet", fill=(255, 215, 0))
    draw.text((30, 975), "Emergent Gardner-Wells tong traction reduction (initial 10-15 lbs, +5 lbs/level) vs emergent ACDF", fill=(200, 220, 240))
    save_to_assets("plate_spine_jumped_facets", canvas)

# 3. plate_cranial_shunt_prox_distal: Professional comparative panel
canvas = Image.new("RGB", (1024, 1024), color=(10, 12, 18))
draw = ImageDraw.Draw(canvas)

# Header
draw.rectangle([(20, 15), (700, 50)], outline=(0, 215, 255), width=2)
draw.text((30, 23), "VP SHUNT COMPLICATION ENGINE: PROXIMAL VS DISTAL FAILURE", fill=(0, 215, 255))

# Left Box: Proximal Failure
draw.rectangle([(20, 70), (500, 990)], outline=(255, 80, 80), width=2)
draw.text((35, 85), "1. PROXIMAL FAILURE (VENTRICULAR CATHETER)", fill=(255, 80, 80))

# Sub-box for Proximal CT findings
draw.rectangle([(35, 120), (485, 480)], outline=(50, 60, 80), fill=(18, 22, 32))
draw.text((50, 140), "[HEAD CT CHARACTERISTICS]", fill=(255, 215, 0))
draw.text((50, 175), "* Acute ventriculomegaly / rounding of frontal horns", fill=(220, 230, 240))
draw.text((50, 205), "* Periventricular transependymal edema (high ICP)", fill=(220, 230, 240))
draw.text((50, 235), "* Catheter abutment against septum or choroid plexus", fill=(220, 230, 240))
draw.text((50, 265), "* Slit ventricle collapse onto side-holes", fill=(220, 230, 240))
draw.text((50, 310), "[SHUNT TAP DYNAMICS]", fill=(255, 215, 0))
draw.text((50, 345), "* Needle tap: Sluggish or ZERO spontaneous CSF", fill=(255, 100, 100))
draw.text((50, 375), "* Pumping reservoir: Extremely hard / fails to refill", fill=(255, 100, 100))
draw.text((50, 420), "[EMERGENT INTERVENTION]", fill=(255, 215, 0))
draw.text((50, 450), "* Revise ventricular catheter via Kocher burr hole", fill=(220, 230, 240))

draw.text((35, 510), "PATHOPHYSIOLOGY:", fill=(255, 215, 0))
draw.text((35, 540), "Choroid plexus ingrowth into catheter side-holes,", fill=(200, 210, 225))
draw.text((35, 565), "intraventricular blood/protein plugging, ependymal", fill=(200, 210, 225))
draw.text((35, 590), "adhesions, or suboptimal frontal horn placement.", fill=(200, 210, 225))

# Right Box: Distal Failure
draw.rectangle([(524, 70), (1004, 990)], outline=(255, 165, 0), width=2)
draw.text((539, 85), "2. DISTAL FAILURE (VALVE / PERITONEAL TUBING)", fill=(255, 165, 0))

# Sub-box for Distal findings
draw.rectangle([(539, 120), (989, 480)], outline=(50, 60, 80), fill=(18, 22, 32))
draw.text((554, 140), "[SHUNT SERIES / WORKUP]", fill=(255, 215, 0))
draw.text((554, 175), "* Full Shunt Series (AP/Lat skull, neck, chest, abd)", fill=(220, 230, 240))
draw.text((554, 205), "* Tubing disconnection (clavicular/neck flexure)", fill=(220, 230, 240))
draw.text((554, 235), "* Peritoneal pseudocyst on abdominal ultrasound/CT", fill=(220, 230, 240))
draw.text((554, 265), "* Valve mechanism failure / setting drift", fill=(220, 230, 240))
draw.text((554, 310), "[SHUNT TAP DYNAMICS]", fill=(255, 215, 0))
draw.text((554, 345), "* Needle tap: FREE-FLOWING CSF under high pressure", fill=(0, 215, 255))
draw.text((554, 375), "* Pumping reservoir: Depresses easily, springs back", fill=(0, 215, 255))
draw.text((554, 420), "[EMERGENT INTERVENTION]", fill=(255, 215, 0))
draw.text((554, 450), "* Distal revision / laparoscopic repositioning", fill=(220, 230, 240))

draw.text((539, 510), "PATHOPHYSIOLOGY:", fill=(255, 215, 0))
draw.text((539, 540), "Peritoneal pseudocyst encysting distal catheter tip,", fill=(200, 210, 225))
draw.text((539, 565), "calcification, catheter fracture at neck crease,", fill=(200, 210, 225))
draw.text((539, 590), "or intra-abdominal adhesions preventing resorption.", fill=(200, 210, 225))

save_to_assets("plate_cranial_shunt_prox_distal", canvas)

print("\nAll remaining plates built successfully!")
