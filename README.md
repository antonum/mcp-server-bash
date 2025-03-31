# mcp-server-bash

Minimalistic MCP server written in bash script.

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

Test with mcphost

```bash
~/go/bin/mcphost -m ollama:llama3.1:latest --config /Users/anton/Timescale/mcp-server-bash/mcp.json

...

using math tool add 10 and 88
```

## References
- Model Context Protocol https://www.anthropic.com/news/model-context-protocol
- mcphost https://github.com/mark3labs/mcphos