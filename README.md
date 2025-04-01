# mcp-server-bash

Minimalistic MCP server written in shell script.

This repo is comlimentary to the article: [Minimalistic MCP Server in bash script](https://dev.to/antonum/minimalistic-mcp-server-in-bash-script-10k5)

The lifecycle of MCP server can be described in two phases. Initialization and Operation.

![Phases of MCP](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/j4pe47n79e2ld3eadeui.png)

The mcp_add.sh implements all of the messages within this lifecicle, from the handshake to execution of the simple "add two numbers" tool.

To do the basic test methods right in CLI use:

```bash
# test tools/list method
echo '{"method":"tools/list","params":{},"jsonrpc":"2.0","id":2}' | bash mcp_add.sh | jq 

# test math_addition tool
echo '{"jsonrpc":"2.0","id":20, "method":"tools/call","params":{"name":"addition","arguments":{"num1":"1","num2":"2"}}}' | bash mcp_add.sh | jq 
```

## LLM host configuration

JSON Configuration file for mcphost and Claude Desktop:

```json
{
    "mcpServers": {
      "math": {
        "command": "/Users/anton/code/mcp-server-bash/mcp_add.sh",
        "args": []
      }
    }
  }
```



## Test with mcphost

Add execute to bash script:
```
chmod +x mcp_add.sh
```
Run mcphost with llama3.1 and tool configuration file

```bash
mcphost -m ollama:llama3.1:latest --config /Users/anton/code/mcp-server-bash/mcp.json

...

using math tool add 10 and 88
```

## References
- Model Context Protocol https://www.anthropic.com/news/model-context-protocol
- mcphost https://github.com/mark3labs/mcphost
- jsonrpc specification: https://www.jsonrpc.org/specification
- mcp inspector https://github.com/wong2/mcp-cli