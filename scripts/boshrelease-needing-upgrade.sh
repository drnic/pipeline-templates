#!/bin/bash

fly_target=${fly_target:-sw}

for name in $(fly -t ${fly_target} pipelines | grep boshrelease | awk '{print $1}'); do
  pipeline=$(fly -t ${fly_target} get-pipeline -p $name)
  if [[ -z $(echo "$pipeline" | spruce json | jq -r ".jobs[] | select(.name == \"testflight-pr\")") ]]; then
    echo "${name} has not been upgraded"
  fi
done
