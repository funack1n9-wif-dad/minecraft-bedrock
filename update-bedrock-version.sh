#!/bin/bash
#
# Set/update the Minecraft Bedrock version in specified files
#

# NOTE: Using MC_VERSION instead of MC_BR_VERSION so the the find-replace script doesn't overwrite it.
PROJECT_HOME="$(pwd)"
export MC_VERSION="${1:-1.20.1.02}"

cat <<EOF > .do_update_version.sh
grep --exclude-dir=.git --exclude-dir=images --exclude-dir=doc -rl MC_BR_VERSION "$PROJECT_HOME" | xargs sed -i "s/MC_BR_VERSION/$MC_VERSION/g"
rm -f "$0"
EOF
chmod +x .do_update_version.sh

./do_update_version.sh

unset MC_VERSION