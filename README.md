# Docker image for Fooocus: Focus on prompting and generating

## Installs

* Ubuntu 22.04 LTS
* CUDA 11.7.1
* Python 3.10.12
* [Fooocus](
  https://github.com/lllyasviel/Fooocus) 2.1.855
* Torch 2.1.0
* xformers
* [runpodctl](https://github.com/runpod/runpodctl)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).
You can use my custom [RunPod template](
https://runpod.io/gsc?template=ileyo7dtpj&ref=2xxro4sy)
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
  ashleykza/fooocus:latest
```

You can obviously substitute the image name and tag with your own.

### Ports

| Connect Port | Internal Port | Description |
|--------------|---------------|-------------|
| 3000         | 3001          | Fooocus     |
| 8888         | 8888          | Jupyter Lab |

### Environment Variables

| Variable           | Description                                  | Default   |
|--------------------|----------------------------------------------|-----------|
| JUPYTER_PASSWORD   | Password for Jupyter Lab                     | Jup1t3R!  |
| DISABLE_AUTOLAUNCH | Disable Web UIs from launching automatically | (not set) |
| PRESET             | Fooocus Preset (anime/realistic)             | (not set) |

## Logs

Fooocus creates a log file, and you can tail the log instead of
killing the service to view the logs.

| Application | Log file                      |
|-------------|-------------------------------|
| Fooocus     | /workspace/logs/fooocus.log   |

For example:

```bash
tail -f /workspace/logs/fooocus.log
```

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ashleykleynhans/fooocus-docker)
are welcome. Bug fixes and new features are encouraged.

You can contact me and get help with deploying your container
to RunPod on the RunPod Discord Server below,
my username is **ashleyk**.

<a target="_blank" href="https://discord.gg/pJ3P2DbUUq">![Discord Banner 2](https://discordapp.com/api/guilds/912829806415085598/widget.png?style=banner2)</a>

## Appreciate my work?

<a href="https://www.buymeacoffee.com/ashleyk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
