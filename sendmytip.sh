#!/bin/bash
shopt -s expand_aliases
RESTAPI_PORT=3101
MY_POOL_ID="57918976f38311fe2476763e73e01165e02f8458b1da11afc72201f33c49d317"
MY_USER_ID="91b9f51a-aa05-4083-bfb7-044bc973926f" # on pooltool website get this from your account profile page
THIS_GENESIS="8e4d2a343f3dcf93"   # We only actually look at the first 7 characters

if [ ! $JORMUNGANDR_RESTAPI_URL ]; then export JORMUNGANDR_RESTAPI_URL=http://192.168.1.114:${RESTAPI_PORT}/api; fi
alias cli="$(which jcli) rest v0"

lastBlockHeight=$(cli node stats get --output-format json | jq -r .lastBlockHeight)
echo ${lastBlockHeight}
if [ "$lastBlockHeight" != "" ]; then
curl -G "https://tamoq3vkbl.execute-api.us-west-2.amazonaws.com/prod/sharemytip?poolid=${MY_POOL_ID}&userid=${MY_USER_ID}&genesispref=${THIS_GENESIS}&mytip=${lastBlockHeight}"
fi
