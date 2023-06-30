#!/bin/bash
#
# Set/update the Minecraft Bedrock version in specified files
#

# NOTE: Using MC_VERSION instead of 1.20.1.02 so the the find-replace script doesn't overwrite it.
PROJECT_HOME="$(pwd)"
MC_VERSION="${1:-1.20.1.02}"
SED_CMD=sed
GREP_CMD=grep

if [ 'Darwin' = `uname` ]; then
    if [ -e  /usr/local/bin/gsed ]; then
        SED_CMD=gsed
    fi
    if [ -e  /usr/local/bin/ggrep ]; then
        GREP_CMD=ggrep
    fi
fi
export MC_VERSION
export SED_CMD
export GREP_CMD

cat <<EOF > .do_update_version.sh
#!/bin/bash
$GREP_CMD --exclude-dir=.git --exclude-dir=images --exclude-dir=doc -rl 1.20.1.02 "$PROJECT_HOME" | xargs $SED_CMD -i "s/1.20.1.02/$MC_VERSION/g"
rm -f "\$0"
echo "Check the Minecraft Bedrock v$MC_VERSION release notes and "dev/minecraft-bedrock__1.20.1.02/bedrock_server_how_to.html" for details regarding backward compatibility when upgrading."
EOF
chmod +x .do_update_version.sh

./.do_update_version.sh

unset MC_VERSION SED_CMD GREP_CMD