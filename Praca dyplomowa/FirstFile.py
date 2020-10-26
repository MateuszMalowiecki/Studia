import tweepy
import json
from neo4j import GraphDatabase
from tweepy import OAuthHandler
 
# Your Twittter App Credentials
consumer_key = "WKOif2aUvTMXhYMszWt4Q7mv6"
consumer_secret = "D49eFTg8WD471jAC5V1uBsXlCxIEpPjHus1C8NuNjvqv9atR4R"
access_token = "1317032317383311360-D3Fyuw7YNKwgnsApRZPlApabpGspKY"
access_token_secret = "aw8vLKHcBHN9S3oyM1pFVYtModkeXenFdN8pWQD5iAYBy"
 
# Calling API
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

def get_data():
    names=["MaciejJanowski1", "TWoffinden", "max_fricke", "DanBewley"]
    results = api.home_timeline(count=0)
    for n in names:
        results += api.user_timeline(id=n, count=2)
    return results

# http://www.lyonwj.com/2017/11/15/entity-extraction-russian-troll-tweets-neo4j/
#TODO: Check below part(what is done and what should be done)
driver = GraphDatabase.driver("bolt://localhost:7687")

with driver.session() as session:
    session.run('CREATE CONSTRAINT ON (p:Person) ASSERT p.name IS UNIQUE;')
    session.run('CREATE CONSTRAINT ON (l:Location) ASSERT l.name IS UNIQUE;')
    session.run('CREATE CONSTRAINT ON (o:Organization) ASSERT o.name IS UNIQUE;')

parsed_tweets = get_data()

# if-then-else  https://community.neo4j.com/t/how-to-check-if-else-in-query/1533

entity_import_query = '''
WITH $parsedTweets AS parsedTweets
UNWIND parsedTweets AS parsedTweet
MATCH (t:Tweet) WHERE t.tweet_id = parsedTweet.id


FOREACH(entity IN parsedTweet.entities |
    // Person
    FOREACH(_ IN CASE WHEN entity.tag = 'I-PER' THEN [1] ELSE [] END |
        MERGE (p:Person {name: reduce(s = "", x IN entity.entity | s + x + " ")}) //FIXME: trailing space
        MERGE (p)<-[:CONTAINS_ENTITY]-(t)
    )

    // Organization
    FOREACH(_ IN CASE WHEN entity.tag = 'I-ORG' THEN [1] ELSE [] END |
        MERGE (o:Organization {name: reduce(s = "", x IN entity.entity | s + x + " ")}) //FIXME: trailing space
        MERGE (o)<-[:CONTAINS_ENTITY]-(t)
    )

    // Location
    FOREACH(_ IN CASE WHEN entity.tag = 'I-LOC' THEN [1] ELSE [] END |
        MERGE (l:Location {name: reduce(s = "", x IN entity.entity | s + x + " ")}) // FIXME: trailing space
        MERGE (l)<-[:CONTAINS_ENTITY]-(t)
    )
)

'''


with driver.session() as session:
    session.run(entity_import_query, parsedTweets=parsed_tweets)
