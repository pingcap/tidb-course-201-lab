#!/bin/bash
curl \
  -X POST \
  -H "'Content-type':'application/json'" http://127.0.0.1:8300/api/v1/changefeeds \
  -d '{"changefeed_id":"cdc-example","sink_uri":"kafka://127.0.0.1:9092/cdc-example-topic?protocol=open-protocol"}'

curl \
  -X GET \
  http://127.0.0.1:8300/api/v1/changefeeds
