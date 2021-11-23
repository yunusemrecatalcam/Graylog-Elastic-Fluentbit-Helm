export GRAYLOG_ADDR="65.21.184.23:9000"

export INPUT=$(curl -s -u admin:admin -H 'Content-Type: application/json' -X GET 'http://65.21.184.23:9000/api/system/inputs' | jq '.inputs | .[0] |
.id')
export INPUT=${INPUT%?}
export INPUT="${INPUT#?}"

curl -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: cli' -X POST "http://65.21.184.23:9000/api/system/inputs/$INPUT/extractors" -d '{
  "title":"FluentD",
  "extractor_type":"json",
  "converters":{},
  "order":0,
  "cut_or_copy":"copy",
  "source_field":"kubernetes",
  "target_field":"",
  "extractor_config":{"list_separator":",","kv_separator":":","key_prefix":"","key_separator":"_","replace_key_whitespace":false,"key_whitespace_replacement":"_"},"condition_type":"none","condition_value":""}'