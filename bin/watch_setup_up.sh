#!/bin/bash

kubectl logs -f $(kubectl get pod|awk '$1~/redis-cluster-setup-/&&$3=="Running"{print $1}')
