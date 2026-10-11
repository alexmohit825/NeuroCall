import requests
import json
import os
from PIL import Image

images = {
    "plate_spine_burst_axial": "File:BurstTranL4LCT.png",
    "plate_spine_burst_sagittal": "File:BurstSaL4LCT.png",
    "plate_spine_jumped_facets": "File:UNILATERAL FACET.JPG",
    "plate_spine_csf_leak": "File:Pseudomeningocele.jpg",
    "plate_spine_cauda_equina": "File:L4-l5-disc-herniation.png",
    "plate_spine_tumor_compression": "File:Spinal cord compression.jpg",
    "plate_chiari_mri": "File:Sagittal MRI scan of brain of patient with Chiari malformation.jpg"
}

os.makedirs("scripts/downloads_spine", exist_ok=True)
headers = {'User-Agent': 'NeurosurgeryAtlasApp/1.0 (mohalex@gmail.com)'}

for key, title in images.items():
    api_url = f"https://commons.wikimedia.org/w/api.php?action=query&titles={title}&prop=imageinfo&iiprop=url|size|mime&format=json"
    r = requests.get(api_url, headers=headers)
    pages = r.json().get('query', {}).get('pages', {})
    for _, page in pages.items():
        info = page.get('imageinfo', [{}])[0]
        img_url = info.get('url')
        if img_url:
            print(f"Downloading {key} from {img_url} ({info.get('width')}x{info.get('height')})")
            img_data = requests.get(img_url, headers=headers).content
            out_path = f"scripts/downloads_spine/{key}.jpg"
            with open("temp_raw", "wb") as f:
                f.write(img_data)
            try:
                im = Image.open("temp_raw").convert("RGB")
                im.save(out_path, "JPEG", quality=95)
                print(f"Saved {out_path}: {im.size}")
            except Exception as e:
                print(f"Error converting {key}: {e}")
if os.path.exists("temp_raw"):
    os.remove("temp_raw")
