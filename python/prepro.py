import json
import sys
import pandas as pd
import matplotlib.pyplot as plt
import re

def cleanString(string):
	# Removes urls, @usernames, and any unicode characters (particularly emojis!)
	return re.sub('(@[A-Za-z0-9\s+]+)|([^0-9A-Za-z#\s+])|(\w+:\/\/\S+)', '', string, flags=re.MULTILINE)

if __name__ == "__main__" :

	if len(sys.argv) != 3 :
		print("Error: need exactly 2 arguments: src and dest filenames")
		sys.exit()

	tweets_data = []
	tweets_file = open(sys.argv[1], "r")
	for line in tweets_file:
    		try:
        		tweet = json.loads(line)
			testme = tweet['text']
        		tweets_data.append(tweet)
    		except:
        		continue
	
	tweets = pd.DataFrame()	
	tweets['text'] = [cleanString(tweet['text']) for tweet in tweets_data]
	tweets.to_csv(sys.argv[2], encoding='utf-8')
