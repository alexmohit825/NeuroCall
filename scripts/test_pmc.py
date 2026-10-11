import requests
import json

def search_pmc(term):
    url = f"https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pmc&term={term}&retmode=json&retmax=5"
    r = requests.get(url)
    return r.json().get('esearchresult', {}).get('idlist', [])

print("Searching PMC...")
ids = search_pmc("far-lateral+approach+vertebral+artery+cadaver")
print("IDs:", ids)
