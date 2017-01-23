# HappyBot
A simple exercise in Tweepy, Twitter's Streaming API, and MATLAB. Sentiment Analysis in MATLAB.

## Summary
Sentiment Analysis using Emoji Classification on Twitter

Using data from Twitter’s Streaming API, we’ll collect training data consisting of Tweets in real-time. We’ll sort these tweets into three categories - “Happy,” “Sad,” and “Neutral,” based on the presence of particular emojis in the tweet. Generally, happy faces will correspond to the Happy group, sad faces to the sad group, and “emotionless” or unclassifiable emojis will go into the neutral category. For this first implementation, we discard the Neutral group and consider only Happy and Sad tweets. 

We then consider the task of sentiment analysis of single words, or phrases (perhaps, but not necessarily, a tweet). To create a testing metric, we’ll take the training data and apply two analyses on it. 

First, the Unigram approach. A word from the training data will correspond to a more positive sentiment value if it appears more frequently in Happy tweets, and more negative if it appears more in Sad tweets. Normalizing these counts for data size, we can then determine a simple metric for the sentiment of a new phrase - it is simply the sum of the sentiment values of each word in the phrase. 

Second, the Nearest Neighbors approach. We consider the n most common words from the training data, tweets, irrespective of sentiment classification. Let town (think, “neighborhood”) be t n-dimensional vectors, where t is the number of tweets. Each town\_i corresponds to a single tweet, the individual values of which are the frequencies of the k most common words as they appear in tweets\_i.

To determine the sentiment of a new word or phrase, we define a new n-dimensional vector for the phrase, as we did for the training data. We then find the k nearest neighbors in town to our testing vector, and use a simple voting system to determine the sentiment of the test phrase. Note the restriction that k must be odd to prevent ties.

We compare the success of both of these approaches using a simple REPL that displays both the binary sentiment determination (‘positive’ vs ‘negative’) as well as a confidence value, that varies in meaning by approach used. In the Unigram approach, this is the absolute value of the sum of sentiment scores for each word in the test phrase. In the Nearest Neighbors approach, this is simply p/k, where p is the number of nearest neighbors that voted to classify the test string as positive.
