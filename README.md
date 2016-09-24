# Test Dev App

Test application for recrutation purposes.

### Requirements
 * Ruby 2.1.10
 * Rails 4.2
 * Postgresql
 
### Setup
In order to properly setup the application:
```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Requests
Private requests are only accessible when passing a token. To reach them first request a token by runnig the following request:
```
curl http://localhost:3000/api/request_token
```

This will get you the token required for access to the private api.

##### Request 1
```
curl -H 'Authorization: Token token=":request_token"' http://localhost:3000/api/private/locations/:country_code
```
##### Request 2
```
curl -H 'Authorization: Token token=":request_token"' http://localhost:3000/api/private/target_groups/:country_code
```
##### Request 3
```
curl --data 'country_code=:country_code&target_group_id=1&locations%5B%5D%5Bid%5D=id%5D=1&locations%5B%5D%5Bpanel_size%5D=200' -H 'Authorization: Token token=":request_token"' http://localhost:3000/api/private/evaluate_target
```
##### Request 4
```
curl http://localhost:3000/api/locations/:country_code
```
##### Request 5
```
curl http://localhost:3000/api/target_groups/:country_code
```





