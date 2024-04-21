import httpx


x = 56
response = httpx.get("https://www.nbp.pl/")
print(response.text)  # Cały HTML nbp.pl


api_response = httpx.get("https://api.nbp.pl/api/exchangerates/rates/a/usd/last/")
print(api_response.text)  # json z API jako tekst
dictionary = api_response.json()
print(dictionary["rates"][0]["mid"])
