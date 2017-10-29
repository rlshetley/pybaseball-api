#!/bin/sh

# Smoke test for the Elasticsearch synchronization

echo 'Testing search last name'
curl -XGET 'localhost:9200/player-index/player/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "match": {
            "lastName": "Aaron"
        }
    }
}
'

echo 'Testing multi-field search'
curl -XGET 'localhost:9200/player-index/player/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
  "multi_match": {
        "query":                "Aaron",
        "fields":               [ "firstName", "lastName" ]
    }
  }
}
'
