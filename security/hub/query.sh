#!/bin/sh

## 0. Install helper tools
apk add --no-cache curl jq > /dev/null


# this is the repo that we're interested in:
repo="library/alpine"





tags_list=https://registry-1.docker.io/v2/${repo}/tags/list
echo "1. Trying tags API: ${tags_list}"
echo
# -s = silent so we can pass response body (json) to jq 
curl -s $tags_list | jq '.'
echo
echo "but we're not authorized :("
echo
echo "response headers:"
echo
curl -s -I $tags_list
echo
echo "look at Www-Authenticate!"
# look for Www-Authenticate header: (this is for library/mongo)
  # Www-Authenticate: Bearer realm="https://auth.docker.io/token",service="registry.docker.io",scope="repository:library/mongo:pull"
echo
echo





echo "2. Getting token with anonymous auth: "
echo
service="registry.docker.io"
scope="repository:${repo}:pull"
# note: if realm/auth server changes in future you need to update this:
get_token="https://auth.docker.io/token?service=$service&scope=$scope"
# auth response is json, extract token with jq
token=$(curl -s $get_token | jq -r '.access_token')
# troubleshoot issues:
# curl -i $get_token
echo $token
echo
# never do this with tokens that access sensitive data:
echo "extra credit - plug token into https://jwt.io/"
echo
# more about generating tokens here https://docs.docker.com/registry/spec/auth/jwt/#getting-a-bearer-token





echo "3. Trying tags API again, this time with the token!"
# more about how this works here: https://docs.docker.com/registry/spec/auth/jwt/#using-the-signed-token
echo
curl -s \
  -H "Authorization: Bearer $token" \
  $tags_list \
  | jq '.'
echo

