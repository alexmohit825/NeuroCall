import requests
import json

url = 'https://commons.wikimedia.org/w/api.php'
params = {
    'action': 'query',
    'generator': 'search',
    'gsrsearch': 'epidural hematoma CT filetype:bitmap',
    'gsrlimit': 5,
    'prop': 'imageinfo',
    'iiprop': 'url|size|mime',
    'format': 'json'
}
headers = {'User-Agent': 'NeurosurgeryApp/1.0 (mohalex@gmail.com)'}
r = requests.get(url, params=params, headers=headers)
data = r.json()
for k, v in data.get('query', {}).get('pages', {}).items():
    info = v.get('imageinfo', [{}])[0]
    print(v.get('title'), info.get('url'), info.get('width'), info.get('height'))
