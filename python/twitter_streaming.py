#Import the necessary methods from tweepy library
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream

# For parsing arguments
import sys
import argparse

from operator import xor

#Variables that contains the user credentials to access Twitter API 
access_token = "822519285612363776-uf8byB6HrwdXOa6GTB6WZVkprws8PVf"
access_token_secret = "uXzgZ9Zgt2PJk5XeKgoGGEpuih47rtFctgSl7YKae6seD"
consumer_key = "GIKl6nmdm7Mx0BFz0wOLeUenT"
consumer_secret = "XWi8lkyDbt7W2F9Ug2OwWBOvHQWMdpiiipe89dsuSYTWZVqK4i"

happy_emojis = [
u"\U0001f600", # Grinning face
u"\U0001f601", # Grinning face with smiling eyes
u"\U0001f602", # Grinning face with tears of joy
u"\U0001f603", # Smiling face with open mouth
u"\U0001f604", # Smiling face with open mouth and smiling eyes
u"\U0001f606", # Smiling face with open mouth and closed eyes
u"\U0001f609", # Winking face
u"\U0001f60a", # Smiling face with smiling eyes
u"\U0001f60b", # Face savoring delicious food
u"\U0001f603", # Smiling face with sunglasses
u"\U0001f60d", # Smiling face with heart eyes
u"\U0001f618", # Face blowing a kiss
u"\U0001f619", # Kissing face with smiling eyes
u"\U0000263A", # Smiling face
u"\U0001f642"  # Slightly smiling face
]

sad_emojis = [
u"\U0001f644", # Face with rolling eyes
u"\U0001f623", # Perservering face
u"\U0001f625", # Disappointed but releived face
u"\U0001f612", # Unamused face
u"\U0001f613", # Face with cold sweat
u"\U0001f614", # Pensive face
u"\U0001f615", # Confused face
u"\U00002639", # Frowning face
u"\U0001f641", # Slightly frowning face
u"\U0001f616", # Confounded face
u"\U0001f613", # Disappointed face
u"\U0001f61f", # Worried face
u"\U0001f624", # Face with steam from nose
u"\U0001f622", # Crying face
u"\U0001f62d", # Loudly crying face
u"\U0001f626", # Frowing face with open mouth
u"\U0001f627", # Anguished face
u"\U0001f628", # Fearful face
u"\U0001f629", # Weary face
u"\U0001f630", # Face with open mouth & cold sweat
u"\U0001f631", # Face screaming in fear
u"\U0001f621", # Pouting face
u"\U0001f620" # Angry face
]

#This is a basic listener that just prints received tweets to stdout.
class StdOutListener(StreamListener):

    def on_data(self, data):
        print data 
        return True

    def on_error(self, status):
        print status 


if __name__ == '__main__':
	
    parser = argparse.ArgumentParser()
    parser.add_argument('--sad', dest='sad', action='store_true')
    parser.add_argument('--happy', dest='happy', action='store_true')
    args = vars(parser.parse_args())
    if not xor(args['happy'], args['sad']):
	print("Error: select exactly one flag: --sad or --happy")
	sys.exit()   
 
    #This handles Twitter authetification and the connection to Twitter Streaming API
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    stream = Stream(auth, l)

    #This line filter Twitter Streams to capture data by the keywords: 'python', 'javascript', 'ruby'
	
    stream.filter(languages=["en"], track=happy_emojis if args['happy'] else sad_emojis)



