#!/bin/bash -e

get_setup_job_status() {
    kubectl get pod -ojson|jq -r '.items[]|select(.metadata.labels["job-name"]=="redis-cluster-setup").status.phase'
}

wait_setup_job_succeed() {
    status="$(get_setup_job_status)"
    while [ "$status" != "Succeeded" ]; do
        echo "$(date) Job status: ${status}"
        sleep 5
        status="$(get_setup_job_status)"
    done
}

echo "$(date) Waiting setup job done..."
wait_setup_job_succeed
echo "$(date) Setup done!"
