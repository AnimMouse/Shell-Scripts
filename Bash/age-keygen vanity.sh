#!/bin/bash
set -eu

vanity_search() {
  local key_block=$(age-keygen)
  if echo "$key_block" | sed -n '2p' | grep -q "$1"; then
    echo "$key_block" >> age.key
    return 0
  fi
  return 1
}

worker_loop() {
  while true; do
    vanity_search && break
  done
}

# Export both functions so GNU Parallel can use them.
export -f vanity_search worker_loop

echo "Generating age keys"

# This command starts one 'worker_loop' on each core.
# 'parallel' will wait until one of them exits with success,
# then '--halt' will terminate all other workers.
seq $(nproc) | parallel -j0 --halt now,success=1 worker_loop