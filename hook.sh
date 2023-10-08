#!/usr/bin/env bash

# based on https://github.com/lukas2511/dehydrated/wiki/example-dns-01-nsupdate-script

set -e
set -u
set -o pipefail

case "$1" in
        "deploy_challenge")
                # echo ""
                echo "Adding the following to the zone definition of ${2}:"
                echo "_acme-challenge.${2}. IN TXT \"${4}\""
                # echo ""
                # echo -n "Press enter to continue..."
                # read tmp
                echo "Sending curl to PowerDNS...."
                curl -v -X PATCH --data '{"rrsets": [{"changetype": "REPLACE", "type": "TXT", "name": "_acme-challenge.domain.com.", "ttl": "60", "records": [{"content": "\"'${4}'\"" , "disabled": false}]}]}' --header "Content-Type: application/json" -H 'X-API-Key: XXXXXXXXXYYYYYYYYZZZZZZZZ' http://<DNS IP or NS DNS>::8081/api/v1/servers/localhost/zones/domain.com. -s | jq .
                sleep 3 # Give some time before
;;
        "clean_challenge")
                # echo ""
                echo "Removing the zone definition of ${2}:"
                echo "_acme-challenge.${2}. IN TXT \"${4}\""
                # echo ""
                # echo -n "Press enter to continue..."
                # read tmp
                # echo ""
               echo "Sending curl to PowerDNS...."
                curl -v -X PATCH --data '{"rrsets": [{"changetype": "DELETE", "type": "TXT", "name": "_acme-challenge.domain.com."}]}'   --header "Content-Type: application/json" -H 'X-API-Key: XXXXXXXXXYYYYYYYYZZZZZZZZ'  http://<DNS IP or NS DNS>:8081/api/v1/servers/localhost/zones/inoutglobal.xyz. -s | jq .
        ;;

        "sync_cert")
                # do nothing for now
        ;;
        "deploy_cert")
                # do nothing for now
        ;;
        "unchanged_cert")
                # do nothing for now
        ;;
        "exit_hook")
                echo "${2:-}"
        ;;
        *)
                echo "Unknown hook \"${1}\""
        ;;
esac

exit 0
