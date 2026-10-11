import requests
import time

headers = {'User-Agent': 'NeurosurgeryAtlas/1.0 (https://github.com/alexmohit825/Radix; mohalex@gmail.com)'}

def search_commons(query):
    url = f"https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={query}&srnamespace=6&format=json"
    try:
        r = requests.get(url, headers=headers)
        return r.json().get('query', {}).get('search', [])
    except Exception as e:
        print(f"Error searching {query}: {e}")
        return []

queries = [
    "Epidural hematoma CT",
    "Subdural hematoma CT",
    "Uncal herniation CT",
    "Cerebellar hemorrhage CT",
    "Cerebellar hematoma CT",
    "Bilateral facet dislocation CT",
    "Locked facets cervical CT",
    "Spinal cord compression MRI",
    "Endoscopic pituitary surgery",
    "Retrosigmoid craniotomy",
    "Pterional craniotomy",
    "Atlantoaxial fixation"
]

for q in queries:
    results = search_commons(q)
    print(f"\nQuery: {q}")
    for res in results[:3]:
        print("  ->", res['title'])
    time.sleep(1)
