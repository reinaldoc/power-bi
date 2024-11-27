#!/bin/bash

ls -d *.Report | while read report; do
  name=${report/.Report/}
  test -f "${name}.pbip" && continue
  cat <<EOF > "${name}.pbip"
{
  "version": "1.0",
  "artifacts": [
    {
      "report": {
        "path": "$name.Report"
      }
    }
  ],
  "settings": {
    "enableAutoRecovery": true
  }
}
EOF

done
