#!/bin/bash
set -eu

if [ $# -lt 1 ]; then
  echo "usage: $0 <pattern>" >&2
  echo "  <pattern> is a grep BRE matched against the key body (the 58" >&2
  echo "  characters after 'age1'). Anchor with '^' for a true prefix." >&2
  exit 1
fi

# The Bech32 alphabet is 'qpzry9x8gf2tvdw0s3jn54khce6mua7l' -- '1', 'b',
# 'i' and 'o' are not in it, so a pattern containing one can never match
# and would spin forever. age prints the key in lowercase, so reject
# uppercase for the same reason.
case "$1" in
  *[1bio]*)
    echo "error: '1', 'b', 'i' and 'o' are not in the Bech32 alphabet" >&2
    exit 1
    ;;
  *[A-Z]*)
    echo "error: pattern must be lowercase (age prints keys in lowercase)" >&2
    exit 1
    ;;
esac

# Exported so the workers GNU Parallel spawns can see it; positional
# arguments do not survive the trip into 'worker_loop'.
PATTERN=$1
export PATTERN

vanity_search() {
  local key_block body
  key_block=$(age-keygen 2>/dev/null)
  # Strip the '# public key: age1' prefix so the pattern is matched only
  # against the Bech32 body; otherwise 'age', 'ge1' and friends would
  # match the prefix on every single key.
  body=$(echo "$key_block" | sed -n '2s/^.*: age1//p')
  if echo "$body" | grep -q "$PATTERN"; then
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

echo "Generating age keys matching '$PATTERN'"

# This command starts one 'worker_loop' on each core.
# 'parallel' will wait until one of them exits with success,
# then '--halt' will terminate all other workers.
seq $(nproc) | parallel -j0 --halt now,success=1 worker_loop