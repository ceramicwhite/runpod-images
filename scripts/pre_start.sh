#!/usr/bin/env bash
export PYTHONUNBUFFERED=1

echo "Container is running"

# Sync venv to workspace to support Network volumes
echo "Syncing venv to workspace, please wait..."
rsync -au /venv/ /workspace/venv/

# Sync AnyDoor Plus to workspace to support Network volumes
echo "Syncing AnyDoor to workspace, please wait..."
rsync -au /AnyDoor/ /workspace/AnyDoor/

# Fix the venv to make it work from /workspace
echo "Fixing venv..."
/fix_venv.sh /venv /workspace/venv

if [[ ${DISABLE_AUTOLAUNCH} ]]
then
    echo "Auto launching is disabled so the application will not be started automatically"
    echo "You can launch it manually:"
    echo ""
    echo "   cd /workspace/AnyDoor"
    echo "   deactivate && source /workspace/venv/bin/activate"
    echo "   ./python run_gradio_demo.py"
else
    mkdir -p /workspace/logs
    echo "Starting AnyDoor"
    export HF_HOME="/workspace"
    export GRADIO_SERVER_NAME="0.0.0.0"
    export GRADIO_SERVER_PORT="3001"
    source /workspace/venv/bin/activate
    cd /workspace/AnyDoor && nohup python run_gradio_demo.py  > /workspace/logs/AnyDoor.log 2>&1 &
    echo "AnyDoor started"
    echo "Log file: /workspace/logs/AnyDoor.log"
    deactivate
fi

echo "All services have been started"

