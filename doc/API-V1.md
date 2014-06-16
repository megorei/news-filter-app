API V1
======

## Tags

### List

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/tags

Response

```json
{ "tags": [
  {"id":"0d6f8f03-86d4-48c7-92f0-6ab22ba209a8", "title":"Tag-0"},
  {"id":"3b70b703-ce9b-4417-8b5a-0152732b7164", "title":"Tag-1"}
]}
```

### Show

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/tags/3b70b703-ce9b-4417-8b5a-0152732b7164

Response

```json
{ "tag":{"id":"3b70b703-ce9b-4417-8b5a-0152732b7164", "title":"Tag-1"} }
```
    
### Create

    curl -X POST -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" -d "tag[title]=MyTag" http://localhost:3000/v1/tags

Response

```json
{ "tag":{"id":"32056b64-22d0-4840-b9e4-de31d27c9a71", "title":"MyTag"} }
```

### Update

    curl -X PATCH -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" -d "tag[title]=YourTag" http://localhost:3000/v1/tags/32056b64-22d0-4840-b9e4-de31d27c9a71

Response

```json
{"tag":{"id":"32056b64-22d0-4840-b9e4-de31d27c9a71","title":"YourTag"}}
```
  
### Destroy

    curl -X DELETE -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/tags/32056b64-22d0-4840-b9e4-de31d27c9a71


## Feeds

### List

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/feeds

Response

```json
{
  "feeds":
    [
      {"id":"110cfab7-faf2-417d-abba-73089a44c479","title":"Feed-1","url":"http://url-2","user_id":null},
      {"id":"1b6535ad-2e1e-463b-8470-9c0e8c0e6baa","title":"Feed-2","url":"http://url-3","user_id":null},
      {"id":"8f5aa374-99d3-4d6d-a7ee-531f1bf3d7c9","title":"Feed-3","url":"http://url-4","user_id":null}
    ]
}
```

### Show

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/feeds/3b70b703-ce9b-4417-8b5a-0152732b7164

Response

```json
{"feed":{"id":"110cfab7-faf2-417d-abba-73089a44c479","title":"Feed-2","url":"http://url-2","user_id":null}}
```

### Create

    curl -X POST -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" -d "feed[title]=MyFeed" -d "feed[url]=my_url" http://localhost:3000/v1/feeds

Response

```json
{"feed":{"id":"38e842ef-57aa-4b37-91ee-6a0f84a7048e","title":"MyFeed","url":"my_url","user_id":"2868f09a-5f16-4968-bc50-f6a61cfbdc01"}}
```

### Update

    curl -X PATCH -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" -d "tag[title]=YourTag" http://localhost:3000/v1/tags/32056b64-22d0-4840-b9e4-de31d27c9a71

Response

```json
{"feed":{"id":"38e842ef-57aa-4b37-91ee-6a0f84a7048e","title":"YourFeed","url":"my_url","user_id":"2868f09a-5f16-4968-bc50-f6a61cfbdc01"}}
```

### Destroy

    curl -X DELETE -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/tags/32056b64-22d0-4840-b9e4-de31d27c9a71

Response

```json
38e842ef-57aa-4b37-91ee-6a0f84a7048e
```

## Articles

### List

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/articles

Response

```json
{
  "articles":
    [
      {"id":"ff7698bf-6e20-4df6-81a9-c7f3624ed4fa","title":"Article-0","url":"http://url-0","description":"Bla bla","feed_id":null},
      {"id":"067a71c7-b60e-48af-bb84-030fdaf40c34","title":"Article-1","url":"http://url-1","description":"Bla bla","feed_id":null},
      {"id":"4b60a9bc-2ed3-4961-ad46-d95c2135a14f","title":"Article-2","url":"http://url-2","description":"Bla bla","feed_id":null}
    ]
}
```

### Show

    curl -H "X-API-TOKEN: 44fc3a60d2692a0774ccd816dd7dfdc380c4cfd3" http://localhost:3000/v1/articles/ff7698bf-6e20-4df6-81a9-c7f3624ed4fa

Response

```json
{"article":{"id":"ff7698bf-6e20-4df6-81a9-c7f3624ed4fa","title":"Article-0","url":"http://url-0","description":"Bla bla","feed_id":null}}
```