# Using the Twitter Streaming API with Tweepy
Disclaimer - This was hastily written and is only in this repo to demonstrate how I got the data. I do not endorse its use until a potential future release where I handle errors from the API more gracefully, and generally write it more idiomatically. For now, it should work, but I make no guarantees.

### To create raw tweet data
`$ python twitter_streaming.py --[sad | happy] > [some_file_name.txt]`
`$ python prepro.py [some_file_name.txt] [some_other_name.csv]`
