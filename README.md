# Tenantback CAM Audit: MCP server and A2A agent

[Tenantback](https://tenantback.com) audits a commercial landlord's CAM / operating expense reconciliation against the tenant's lease and returns every overcharge with the lease clause, the statement line and the arithmetic.

This repository documents the hosted endpoints. There is nothing to install: the server runs at `https://tenantback.com/mcp`, needs no API key, and is listed in the [official MCP Registry](https://registry.modelcontextprotocol.io) as `com.tenantback/cam-audit`.

| | |
|---|---|
| MCP endpoint | `https://tenantback.com/mcp` (Streamable HTTP, no auth) |
| A2A agent card | `https://tenantback.com/.well-known/agent-card.json` |
| A2A endpoint | `https://tenantback.com/a2a` (JSON-RPC) |
| Email | forward the lease and reconciliation to `audit@tenantback.com` |
| Docs for LLMs | [tenantback.com/llms.txt](https://tenantback.com/llms.txt) |

## What it checks

- Pro-rata share against the lease's rentable area or fixed percentage
- CAM caps (cumulative and non-cumulative, controllable vs. uncontrollable)
- Admin and management fees above the lease rate, or charged on excluded costs
- Excluded costs: capital repairs, landlord overhead, leasing costs, insurance deductibles and more
- Gross-up, totals that don't add up, and late delivery of the reconciliation

The model only reads the documents. A deterministic rules engine does all the math, and every finding cites the clause and page. See a [sample report](https://tenantback.com/sample-report).

## MCP tools

| Tool | What it does |
|---|---|
| `audit_cam_reconciliation` | Takes the lease and reconciliation (as text or HTTPS links to the PDFs) plus the tenant's work email. Returns a request id. |
| `get_audit_result` | Takes the request id. Returns totals, findings, lease citations and calculations, usually after about 3 minutes. |

## Connect

**Claude Desktop / Claude Code**

```bash
claude mcp add --transport http tenantback https://tenantback.com/mcp
```

**Cursor, Windsurf and other JSON configs** ([examples/mcp.json](examples/mcp.json))

```json
{
  "mcpServers": {
    "tenantback": { "url": "https://tenantback.com/mcp" }
  }
}
```

**A2A**: point any A2A client at the agent card. Skills: `audit_cam_reconciliation`, `abstract_lease`, `portfolio_status` (API key). A raw request is in [examples/a2a-send-message.sh](examples/a2a-send-message.sh).

## Who it's for

Multi-location tenants: franchisees, restaurant and retail groups, dental and healthcare practices. Audits are free. If you choose to dispute and money comes back, Tenantback takes a share of what is recovered. See [pricing](https://tenantback.com/#pricing).

## Privacy

Documents are processed by models with provider data retention turned off. See [tenantback.com/security](https://tenantback.com/security).

## Contact

hello@tenantback.com
