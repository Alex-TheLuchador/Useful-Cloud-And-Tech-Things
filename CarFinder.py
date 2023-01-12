# WORK IN PROGRESS

from requests import get
from bs4 import BeautifulSoup

header = ({'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76'})
url = 'https://www.carfax.com/Used-Honda-Civic_w303'
response = get(url, headers=header)

soup = BeautifulSoup(response.text, 'html.parser')

# Remove HTML characters from results
def Cleanup_Names(names):
    clean_text = names.strip("[]\'")
    return clean_text


def Cleanup_Prices(prices):
    clean_text = prices.translate(
        {ord(i): None for i in 'spancl=\"Price-tx:<>/,\'[]'})
    clean_text = clean_text.strip(' ')
    return clean_text


car_names = soup.find_all('h4', 'srp-list-item-basic-info-model')
listing_names = []
for car in car_names:
    name = Cleanup_Names(str(car.contents))
    listing_names.append(name)
    # if name.find('Type R') != -1:

car_prices = soup.find_all('span', 'srp-list-item-price')
listing_prices = []
for price in car_prices:
    price_to_add = Cleanup_Prices(str(price.contents))
    listing_prices.append(price_to_add)

if (len(listing_names) == len(listing_prices)):
    for count, item in enumerate(listing_names):
        price = listing_prices[count]
        print("Car: " + str(item))
        print("Price: " + str(price))
        print()
else:
    print("Not equal!")
