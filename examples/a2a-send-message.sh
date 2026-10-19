#!/bin/sh
# Send a lease and a CAM reconciliation (HTTPS links) to the Tenantback A2A agent.
# The response is a task; poll it with GetTask until it completes.
curl -s https://tenantback.com/a2a \
  -H 'content-type: application/json' \
  -H 'A2A-Version: 1.0' \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "SendMessage",
    "params": {
      "message": {
        "messageId": "example-1",
        "role": "ROLE_USER",
        "parts": [
          { "url": "https://example.com/lease.pdf", "mediaType": "application/pdf" },
          { "url": "https://example.com/2025-cam-reconciliation.pdf", "mediaType": "application/pdf" },
          { "data": { "contactEmail": "ops@yourcompany.com", "contactName": "Your Company" } }
        ]
      }
    }
  }'
