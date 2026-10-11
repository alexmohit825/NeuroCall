import os
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

ASSETS_DIR = "Assets.xcassets"
CLEAN_DIR = "scripts/clean_plates"
SPINE_DIR = "scripts/downloads_spine"
GIT_DIR = "scripts/git_0d7fa0b"

os.makedirs("scripts/final_26", exist_ok=True)

def save_to_assets(plate_name, pil_img):
    target_folder = os.path.join(ASSETS_DIR, f"{plate_name}.imageset")
    os.makedirs(target_folder, exist_ok=True)
    target_path = os.path.join(target_folder, f"{plate_name}.jpg")
    
    # Ensure RGB
    if pil_img.mode != "RGB":
        pil_img = pil_img.convert("RGB")
    
    # Save high-quality JPEG
    pil_img.save(target_path, "JPEG", quality=95)
    # Also save to scripts/final_26 for verification
    pil_img.save(f"scripts/final_26/{plate_name}.jpg", "JPEG", quality=95)
    print(f"[OK] Saved {plate_name}: {pil_img.size}")

# 1. plate_aneurysm: Real intraoperative microsurgical clipped ACom aneurysm
if os.path.exists(f"{CLEAN_DIR}/plate_aneurysm.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_aneurysm.jpg")
    save_to_assets("plate_aneurysm", im)

# 2. plate_mri_axial_brain: Real 3T axial T2 brain MRI with motor strip and central sulcus
if os.path.exists(f"{CLEAN_DIR}/plate_mri_axial_brain.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_mri_axial_brain.jpg")
    save_to_assets("plate_mri_axial_brain", im)

# 3. plate_acdf: Real lateral cervical radiograph with standalone interbody fusion cages (ZERO Caspar pins)
if os.path.exists(f"{CLEAN_DIR}/plate_acdf.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_acdf.jpg")
    save_to_assets("plate_acdf", im)

# 4. plate_tlif: Real lateral lumbar radiograph with TLIF cage and pedicle screws
if os.path.exists(f"{CLEAN_DIR}/plate_tlif.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_tlif.jpg")
    save_to_assets("plate_tlif", im)

# 5. plate_cranial_sah_aneurysm: Real Fisher 3 SAH head CT with orientation markers
if os.path.exists(f"{CLEAN_DIR}/plate_cranial_sah_aneurysm.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_cranial_sah_aneurysm.jpg")
    save_to_assets("plate_cranial_sah_aneurysm", im)

# 6. plate_cranial_ich_lobar: Real non-contrast CT of acute lobar intracerebral hemorrhage
if os.path.exists(f"{CLEAN_DIR}/plate_cranial_ich_lobar.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_cranial_ich_lobar.jpg")
    save_to_assets("plate_cranial_ich_lobar", im)

# 7. plate_cranial_vp_shunt: Real radiograph of VP shunt course from skull to abdomen
if os.path.exists(f"{CLEAN_DIR}/plate_cranial_vp_shunt.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_cranial_vp_shunt.jpg")
    save_to_assets("plate_cranial_vp_shunt", im)

# 8. plate_kocher: Real CT showing Kocher's point EVD catheter entering right frontal horn
if os.path.exists(f"{CLEAN_DIR}/plate_kocher.jpg"):
    im = Image.open(f"{CLEAN_DIR}/plate_kocher.jpg")
    # Clean crop / resize if needed
    save_to_assets("plate_kocher", im)

# 9. plate_chiari: Real 1200x1344 Sagittal T2 MRI showing tonsillar herniation through foramen magnum
if os.path.exists(f"{SPINE_DIR}/plate_chiari_mri.jpg"):
    im = Image.open(f"{SPINE_DIR}/plate_chiari_mri.jpg")
    save_to_assets("plate_chiari", im)

# 10. plate_spine_burst_fracture: Composite authentic axial + sagittal CT bone window
if os.path.exists(f"{SPINE_DIR}/plate_spine_burst_axial.jpg") and os.path.exists(f"{SPINE_DIR}/plate_spine_burst_sagittal.jpg"):
    im_ax = Image.open(f"{SPINE_DIR}/plate_spine_burst_axial.jpg")
    im_sag = Image.open(f"{SPINE_DIR}/plate_spine_burst_sagittal.jpg")
    target_h = 700
    w_ax = int(im_ax.width * target_h / im_ax.height)
    w_sag = int(im_sag.width * target_h / im_sag.height)
    im_ax_r = im_ax.resize((w_ax, target_h), Image.Resampling.LANCZOS)
    im_sag_r = im_sag.resize((w_sag, target_h), Image.Resampling.LANCZOS)
    
    comp = Image.new("RGB", (w_ax + w_sag + 20, target_h + 80), color=(15, 17, 23))
    comp.paste(im_ax_r, (0, 70))
    comp.paste(im_sag_r, (w_ax + 20, 70))
    
    draw = ImageDraw.Draw(comp)
    draw.text((20, 20), "THORACOLUMBAR BURST FRACTURE: AXIAL (CANAL RETROPULSION)", fill=(255, 215, 0))
    draw.text((w_ax + 30, 20), "SAGITTAL BONE WINDOW (VERTEBRAL COLLAPSE)", fill=(255, 215, 0))
    save_to_assets("plate_spine_burst_fracture", comp)

# 11. plate_spine_cauda_equina: Real sagittal T2 lumbar MRI of massive disc extrusion
if os.path.exists(f"{SPINE_DIR}/plate_spine_cauda_equina.jpg"):
    im = Image.open(f"{SPINE_DIR}/plate_spine_cauda_equina.jpg")
    # Create clean framed plate
    frame = Image.new("RGB", (im.width + 40, im.height + 70), color=(15, 17, 23))
    frame.paste(im, (20, 50))
    draw = ImageDraw.Draw(frame)
    draw.text((20, 15), "CAUDA EQUINA SYNDROME: MASSIVE LUMBAR DISC EXTRUSION (T2 MRI)", fill=(255, 215, 0))
    save_to_assets("plate_spine_cauda_equina", frame)

# 12. plate_spine_csf_leak: Real T2 MRI showing post-op pseudomeningocele
if os.path.exists(f"{SPINE_DIR}/plate_spine_csf_leak.jpg"):
    im = Image.open(f"{SPINE_DIR}/plate_spine_csf_leak.jpg")
    frame = Image.new("RGB", (im.width + 40, im.height + 70), color=(15, 17, 23))
    frame.paste(im, (20, 50))
    draw = ImageDraw.Draw(frame)
    draw.text((20, 15), "POSTOPERATIVE CSF LEAK / PSEUDOMENINGOCELE (T2 MRI)", fill=(255, 215, 0))
    save_to_assets("plate_spine_csf_leak", frame)

# 13. Surgical Corridors from git 0d7fa0b: restore pristine illustrations WITHOUT crude patches
surgical_plates = [
    "plate_pterional",
    "plate_orbitozygomatic",
    "plate_far_lateral",
    "plate_endonasal_sellar",
    "plate_retrosigmoid",
    "plate_trauma",
    "plate_c1_c2_harms"
]

for p in surgical_plates:
    p_path = f"{GIT_DIR}/{p}.jpg"
    if os.path.exists(p_path):
        im = Image.open(p_path)
        save_to_assets(p, im)

print("\nBatch 1 sync complete!")
