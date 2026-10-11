import requests
import json
import os

images = {
    "plate_ct_edh": "File:Epidural hematoma.png",
    "plate_ct_sdh": "File:Ct-scan of the brain with an subdural hematoma.jpg",
    "plate_cranial_sah_aneurysm": "File:Subarachnoid hemorrhage CT (uncropped).jpg",
    "plate_cranial_ich_lobar": "File:Intracerebral hemorrhage 2.jpg",
    "plate_cranial_vp_shunt": "File:Radiograph of a ventriculoperitoneal shunt.jpg",
    "plate_mri_axial_brain": "File:MRI Brain T2 Axial (18).jpg",
    "plate_trauma": "File:Decompressive Craniectomy.png",
    "plate_aneurysm": "File:Clipped aneurysm.jpg",
    "plate_kocher": "File:EVD-ICH.jpg",
    "plate_acdf": "File:CoalitionCervicalCageL.png",
    "plate_tlif": "File:X-ray of Transforaminal Lumbar Interbody Fusion, L.jpg"
}

os.makedirs("scripts/downloads", exist_ok=True)
headers = {'User-Agent': 'NeurosurgeryAtlasApp/1.0 (mohalex@gmail.com)'}

for plate_key, file_title in images.items():
    api_url = f"https://commons.wikimedia.org/w/api.php?action=query&titles={file_title}&prop=imageinfo&iiprop=url|size|mime&format=json"
    r = requests.get(api_url, headers=headers)
    pages = r.json().get('query', {}).get('pages', {})
    for _, page in pages.items():
        info = page.get('imageinfo', [{}])[0]
        img_url = info.get('url')
        if img_url:
            ext = img_url.split('.')[-1].split('?')[0]
            out_path = f"scripts/downloads/{plate_key}.{ext}"
            print(f"Downloading {plate_key} from {img_url} -> {out_path} ({info.get('width')}x{info.get('height')})")
            img_data = requests.get(img_url, headers=headers).content
            with open(out_path, "wb") as f:
                f.write(img_data)
