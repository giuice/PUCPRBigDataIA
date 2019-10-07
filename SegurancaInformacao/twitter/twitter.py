from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
from unidecode import unidecode
import string
import re
import pandas as pd
import json
import sys

class AssinanteTwitter(StreamListener):

    def __init__(self):
        self.df = pd.DataFrame(columns=['date','text'])
        self.counter = 0

    def on_data(self, data):
        conteudoJSON = json.loads(data)
        if "text" in conteudoJSON:
            print(conteudoJSON["text"])
            text = self.remove_basic(unidecode(conteudoJSON["text"]))
            print(text)
            date = conteudoJSON['created_at']
            if len(text) > 10:
                if self.counter > 10000:
                    sys.exit()
                self.df.loc[self.counter] = [date, text]
                if not self.counter % 10:
                    self.df.to_csv('log1.csv', index=False)
                self.counter = self.counter +1
        return True

    def remove_basic(self, text):
        return text.replace('\r', ' ').replace('\n', ' ').replace(',', ' ').replace("'", '')

    def remove_punct(self, text):
        text = "".join([char for char in text if char not in string.punctuation])
        text = re.sub('[0-9]+', '', text)
        return text

    def on_error(self, status):
        print(status)



print("Inicio do programa")


consumer_key="mykey"
consumer_secret="mysecret"

access_token="mytoken"
access_token_secret="mytokensecret"
assinante = AssinanteTwitter()
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
stream = Stream(auth, assinante)
stream.filter(track=['presidente', "orgulho", "onu","brasil","discurso"], languages=["pt"])
