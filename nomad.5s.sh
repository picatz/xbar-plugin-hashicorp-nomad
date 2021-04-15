#!/bin/bash

# <xbar.title>Nomad</xbar.title>
# <xbar.version>v0.0.1</xbar.version>
# <xbar.author>Kent 'picat' Gruber</xbar.author>
# <xbar.author.github>picatz</xbar.author.github>
# <xbar.desc>Display HashiCorp Nomad Status Information</xbar.desc>
# <xbar.dependencies>Bash</xbar.dependencies>

# <xbar.var>string(NOMAD_ADDR="http://localhost:4646"): Nomad address.</xbar.var>
# <xbar.var>string(NOMAD_TOKEN=""): Nomad API token.</xbar.var>
# <xbar.var>string(NOMAD_CACERT=""): Full path to the Nomad CA cert.</xbar.var>
# <xbar.var>string(NOMAD_CLIENT_CERT=""): Full path to the Nomad client cert.</xbar.var>
# <xbar.var>string(NOMAD_CLIENT_KEY=""): Full path to the Nomad client key.</xbar.var>

nomad_icon="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"
echo "|image=$nomad_icon"
echo "---"
echo "Nomad Address | font=Courier | size=10"
echo "$NOMAD_ADDR | href=$NOMAD_ADDR"
echo "---"
if [ /usr/local/bin/nomad status | grep -q "No running jobs" ]; then
  echo "No running jobs"
else
  NOMAD_STATUS=$(/usr/local/bin/nomad status | tail -n +2)
  JOB_COUNT=$(/usr/local/bin/nomad status | tail -n +2 | wc -l | awk '{print $1}')

  echo "$JOB_COUNT jobs"
  /usr/local/bin/nomad status | tail -n +2 | while read JOB; do
    JOB_ID=$(echo $JOB | /usr/bin/awk '{print $1}')
    JOB_STATUS=$(echo $JOB | /usr/bin/awk '{print $4}')
    if [ "$JOB_STATUS" = "running" ]; then
      echo "--🟢 $JOB_ID | href=$NOMAD_ADDR/ui/jobs/$JOB_ID"
    else
      echo "--🔴 $JOB_ID | href=$NOMAD_ADDR/ui/jobs/$JOB_ID"
    fi
  done
fi
