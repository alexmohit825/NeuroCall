import requests

terms = {
    "plate_ct_edh": "Epidural hematoma CT",
    "plate_ct_sdh": "Subdural hematoma CT",
    "plate_ct_uncal": "Uncal herniation CT",
    "plate_ct_post_fossa": "Cerebellar hemorrhage CT",
    "plate_cranial_sah_aneurysm": "Subarachnoid hemorrhage CT",
    "plate_cranial_ich_lobar": "Intracerebral hemorrhage CT",
    "plate_cranial_vp_shunt": "Ventriculoperitoneal shunt X-ray OR CT",
    "plate_cranial_shunt_prox_distal": "Ventriculoperitoneal shunt malfunction OR complication",
    "plate_spine_jumped_facets": "Facet dislocation cervical spine OR jumped facet",
    "plate_spine_tumor_compression": "Spinal cord compression MRI",
    "plate_spine_burst_fracture": "Burst fracture lumbar OR thoracic CT",
    "plate_spine_cauda_equina": "Cauda equina MRI OR lumbar disc herniation MRI",
    "plate_spine_csf_leak": "Pseudomeningocele MRI spine",
    "plate_mri_axial_brain": "Brain MRI axial T2",
    "plate_kocher": "External ventricular drain OR ventriculostomy",
    "plate_trauma": "Decompressive craniectomy",
    "plate_chiari": "Chiari malformation decompression OR craniectomy",
    "plate_aneurysm": "Aneurysm clipping brain OR cerebral aneurysm clip",
    "plate_pterional": "Pterional craniotomy",
    "plate_orbitozygomatic": "Orbitozygomatic craniotomy",
    "plate_retrosigmoid": "Retrosigmoid approach OR cerebellopontine angle",
    "plate_far_lateral": "Far-lateral approach OR transcondylar approach",
    "plate_endonasal_sellar": "Endoscopic endonasal transsphenoidal pituitary",
    "plate_c1_c2_harms": "Atlantoaxial fixation OR C1 C2 screw",
    "plate_acdf": "Anterior cervical discectomy and fusion",
    "plate_tlif": "Transforaminal lumbar interbody fusion"
}

headers = {'User-Agent': 'NeurosurgeryAtlas/1.0 (mohalex@gmail.com)'}

for plate_id, term in terms.items():
    url = f"https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={term}&srnamespace=6&format=json"
    try:
        r = requests.get(url, headers=headers, timeout=10)
        hits = r.json().get('query', {}).get('search', [])
        print(f"=== {plate_id} ({term}) ===")
        for h in hits[:3]:
            print("  ", h['title'])
    except Exception as e:
        print(f"Error {plate_id}: {e}")
