#!/usr/bin/env bash
export PYTHONUNBUFFERED=1
export ENFUGUE_SERVER_PORT=3001
export ENFUGUE_SERVER_DOMAIN=localhost
export ENFUGUE_SERVER_SECURE=false
export ENFUGUE_SERVER_NOAUTH=true
export ENFUGUE_ROOT=/Enfugue

# Sync venv to workspace to support Network volumes
echo "Syncing venv to workspace, please wait..."
rsync -au /venv/ /workspace/venv/

# Sync Enfugue to workspace to support Network volumes
echo "Syncing Enfugue to workspace, please wait..."
rsync -au /root/.cache/Enfugue /workspace/Enfugue/

# Fix the venv to make it work from /workspace
echo "Fixing venv..."
/fix_venv.sh /venv /workspace/venv

# Create logs directory
mkdir -p /workspace/logs

if [[ ${DISABLE_AUTOLAUNCH} ]]
then
    echo "Auto launching is disabled so the application will not be started automatically"
    echo "You can launch it manually:"
    echo ""
    echo "   cd /workspace/Enfugue"
    echo "   deactivate && source /workspace/venv/bin/activate"
    echo "   python -m enfugue run"
else
    echo "Starting Enfugue"
    export HF_HOME="/workspace"
    ulimit -n unlimited 2>/dev/null >/dev/null || true
    source /workspace/venv/bin/activate
    cd /workspace/Enfugue
    echo "Starting Enfugue"
    nohup python -m enfugue run > /workspace/logs/Enfugue.log 2>&1 &

    echo "Enfugue started"
    echo "Log file: /workspace/logs/Enfugue.log"
    deactivate
fi

echo "All services have been started"