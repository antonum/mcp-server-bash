#!/bin/bash

echo "Starting mcp_add.sh">> /Users/anton/code/mcp-server-bash/requests.log

while read -r line; do
    echo $line >> /Users/anton/code/mcp-server-bash/requests.log
    # Parse JSON input using jq
    method=$(echo "$line" | jq -r '.method' 2>/dev/null)
    id=$(echo "$line" | jq -r '.id' 2>/dev/null)
    if [[ "$method" == "initialize" ]]; then
        #echo '{"jsonrpc":"2.0", "id": "'"$id"'"}'
        echo '{"jsonrpc":"2.0","id":'"$id"',"result":{"protocolVersion":"2024-11-05","capabilities":{"experimental":{},"prompts":{"listChanged":false},"resources":{"subscribe":false,"listChanged":false},"tools":{"listChanged":false}},"serverInfo":{"name":"math","version":"0.0.1"}}}'
    
    elif [[ "$method" == "notifications/initialized" ]]; then
        : #do nothing
    
    elif [[ "$method" == "tools/list" ]]; then
        echo '{"jsonrpc":"2.0","id":'"$id"',"result":{"tools":[{"name":"addition","description":"addition of two numbers.\n\nArgs:\n    num1, num2\n","inputSchema":{"properties":{"num1":{"title":"Number1","type":"string"},"num2":{"title":"Number2","type":"string"}},"required":["num1", "num2"]}}]}}'
    
    elif [[ "$method" == "resources/list" ]]; then
        echo '{"jsonrpc":"2.0","id":'"$id"',"result":{"resources":[]}}'

    elif [[ "$method" == "prompts/list" ]]; then
        echo '{"jsonrpc":"2.0","id":'"$id"',"result":{"prompts":[]}}'

    elif [[ "$method" == "tools/call" ]]; then
        #{"method":"tools/call","params":{"name":"addition","arguments":{"num1":"1","num2":"2"}},"jsonrpc":"2.0","id":20}
        tool_method=$(echo "$line" | jq -r '.params.name' 2>/dev/null)
        tool_arguments=$(echo "$line" | jq -r '.params.arguments' 2>/dev/null)
        num1=$(echo "$line" | jq -r '.params.arguments.num1' 2>/dev/null)
        num2=$(echo "$line" | jq -r '.params.arguments.num2' 2>/dev/null)
        sum=$((num1 + num2))
        echo '{"jsonrpc":"2.0","id":'"$id"',"result":{"content":[{"type":"text","text":"\n sum of two numbers is '"$sum"'"}],"isError":false}}'
    
    else
        echo '{"jsonrpc":"2.0","id":'"$id"',"error":{"code":-32601,"message":"Method not found"}}'
    fi
done || break
