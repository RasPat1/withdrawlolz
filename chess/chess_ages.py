import urllib.parse
import urllib.request
import re
import json
import numpy as np
import matplotlib.pyplot as plt
from collections import Counter

page = "List_of_chess_grandmasters"

def wiki_to_json_dict(title):
	safe_title = urllib.parse.quote(title)
	response = urllib.request.urlopen('http://en.wikipedia.org/w/api.php?action=query&titles='+safe_title+'&prop=revisions&rvprop=content&format=json')
	markup = response.read()
	output_file = open('data.json', 'wb')
	output_file.write(markup)
	output_file.close()
	json_data = open('data.json', 'r')
	data = json.load(json_data)
	json_data.close()
	return data

def extract_text_from_article(structure):
	pageid = list(structure['query']['pages'].keys())[0]
	return (structure['query']['pages'][pageid]['revisions'])[0]['*']

grandmasters = extract_text_from_article(wiki_to_json_dict(page))
regex = ".*?(\d{4})-\d{2}-\d{2}.*?\|\|(\d{4})\|\|\{\{(.*?)\}\}"
dates = re.findall(regex, grandmasters)
born_after = 1945
ages = [int(date[1]) - int(date[0]) for date in dates if int(date[1]) - int(date[0]) > 5 and int(date[0]) > born_after]
age_counts = Counter(ages)
age_average = np.mean(ages)
countries = Counter([date[2] for date in dates])
print(age_average)
print(countries)
labels, values = zip(*age_counts.items())

indexes = np.arange(len(labels))
width = 1
plt.bar(indexes, values, width)
plt.xlabel("Reached GM at age")
plt.ylabel("Number of players")
plt.xticks(indexes, labels, rotation='vertical', size=8)
plt.yticks(np.arange(0, 121, 10))
plt.savefig("ages.png")
