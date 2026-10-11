import requests
import json

headers = {'User-Agent': 'NeurosurgeryAtlas/1.0 (mohalex@gmail.com)'}

def search(q):
    url = f"https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={q}&srnamespace=6&format=json"
    r = requests.get(url, headers=headers)
    hits = r.json().get('query', {}).get('search', [])
    print(f"=== {q} ===")
    for h in hits[:5]:
        print(" ", h['title'])

search("facet dislocation CT")
search("locked facets CT")
search("spinal cord compression metastasis MRI")
search("thoracic metastasis MRI")
search("peritoneal pseudocyst VP shunt")
search("ventricular catheter occlusion CT")
