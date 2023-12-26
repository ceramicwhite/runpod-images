# Docker image for Enfugue: Webapp for creating studio-grade AI-generated images and video on desktop or server.

## Installs

* Ubuntu 22.04 LTS
* CUDA 11.7.1
* Python 3.10.12
* [Enfugue](
  https://github.com/painebenjamin/app.enfugue.ai) 2.1.855
* Torch 2.1.0
* xformers
* [runpodctl](https://github.com/runpod/runpodctl)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=ao7h5yuk).
You can use my custom [RunPod template](
https://runpod.io/gsc?template=ab0uo4bj8a&ref=ao7h5yuk)
to launch it on RunPod.

## Running Locally

### Install Nvidia CUDA Driver

- [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)

### Start the Docker container

```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p 3000:3001 \
  -p 8888:8888 \
  -e JUPYTER_PASSWORD=Jup1t3R! \
  ceramicwhite/enfugue-docker:latest
```

You can obviously substitute the image name and tag with your own.

### Ports

| Connect Port | Internal Port | Description |
|--------------|---------------|-------------|
| 3000         | 3001          | Enfugue     |
| 8888         | 8888          | Jupyter Lab |

### Environment Variables

| Variable           | Description                                  | Default   |
|--------------------|----------------------------------------------|-----------|
| JUPYTER_PASSWORD   | Password for Jupyter Lab                     | Jup1t3R!  |
| DISABLE_AUTOLAUNCH | Disable Web UIs from launching automatically | (not set) |
| PRESET             | Enfugue Preset (anime/realistic)             | (not set) |

## Logs

Enfugue creates a log file, and you can tail the log instead of
killing the service to view the logs.

| Application | Log file                      |
|-------------|-------------------------------|
| Enfugue     | /workspace/logs/Enfugue.log   |

For example:

```bash
tail -f /workspace/logs/Enfugue.log
```

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ceramicwhite/enfugue-docker)
are welcome. Bug fixes and new features are encouraged.

You can contact me and get help with deploying your container
to RunPod on the RunPod Discord Server below,
my username is **ashleyk**.
