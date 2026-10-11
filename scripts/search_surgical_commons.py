import requests

queries = {
    "plate_pterional": ["pterional", "pterion craniotomy", "pterion skull", "frontotemporal craniotomy"],
    "plate_orbitozygomatic": ["orbitozygomatic", "orbitotomy", "skull base craniotomy"],
    "plate_retrosigmoid": ["retrosigmoid", "cerebellopontine angle", "acoustic neuroma surgery", "internal acoustic meatus"],
    "plate_far_lateral": ["transcondylar", "foramen magnum approach", "vertebral artery atlas", "sulcus arteriosus"],
    "plate_endonasal_sellar": ["transsphenoidal", "sphenoid sinus pituitary", "pituitary adenoma surgery", "sella turcica endoscopic"],
    "plate_chiari": ["chiari malformation", "suboccipital decompression", "tonsillar herniation MRI", "foramen magnum decompression"],
    "plate_c1_c2_harms": ["atlantoaxial", "odontoid fracture fixation", "C1 C2 vertebra", "atlas axis spine"],
    "plate_spine_jumped_facets": ["facet dislocation", "cervical spine fracture dislocation", "cervical subluxation", "bilateral locked facets"],
    "plate_spine_burst_fracture": ["burst fracture spine", "lumbar burst fracture", "retropulsion spine CT", "vertebral burst fracture"],
    "plate_spine_tumor_compression": ["spinal cord compression", "epidural metastasis spine MRI", "spinal cord tumor MRI", "myelopathy MRI"],
    "plate_spine_cauda_equina": ["cauda equina", "lumbar disc extrusion MRI", "massive disc herniation", "lumbar spinal canal stenosis"],
    "plate_spine_csf_leak": ["pseudomeningocele", "spinal dural tear", "cerebrospinal fluid leak spine", "postoperative seroma spine"],
    "plate_cranial_shunt_prox_distal": ["hydrocephalus shunt", "ventriculoperitoneal shunt complication", "slit ventricle syndrome", "shunt catheter"]
}

headers = {'User-Agent': 'NeurosurgeryAtlas/1.0 (mohalex@gmail.com)'}

for key, terms in queries.items():
    print(f"\n==================== {key} ====================")
    found = set()
    for t in terms:
        url = f"https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={t}&srnamespace=6&format=json"
        try:
            r = requests.get(url, headers=headers, timeout=10)
            hits = r.json().get('query', {}).get('search', [])
            for h in hits[:4]:
                title = h['title']
                if not any(title.endswith(bad) for bad in ['.pdf', '.djvu', '.svg']):
                    if title not in found:
                        found.add(title)
                        print(f"  [{t}] -> {title}")
        except Exception as e:
            pass
