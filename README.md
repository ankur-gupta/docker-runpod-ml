# docker-runpod-ml

## Deprecation
* [docker-ml-runpod](https://github.com/ankur-gupta/docker-runpod-ml/pkgs/container/docker-ml-runpod) is deprecated and will be removed. Please switch to [docker-runpod-ml](https://github.com/ankur-gupta/docker-runpod-ml/pkgs/container/docker-runpod-ml).

## Usage
This image depends on the public docker image
[ankurio/docker-base-ml](https://hub.docker.com/repository/docker/ankurio/docker-base-ml/general)
which is based on the code [docker-base-ml](https://github.com/ankur-gupta/docker-base-ml).

To use this image, you need to create a new template on [RunPod](https://www.runpod.io):
  1. Allow port 22 in TCP ports
  2. Add environment variable `ML_USER=neo`. This needs to match [docker-base-ml](https://github.com/ankur-gupta/docker-base-ml).
  3. Use at least 32GB of "Container Disk" but 64GB is recommended.

## Successful Container Logs
```
2023-08-08T01:41:58.029423024Z
2023-08-08T01:41:58.029429334Z CUDA Version 11.8.0
2023-08-08T01:41:58.030572119Z
2023-08-08T01:41:58.030574119Z Container image Copyright (c) 2016-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
2023-08-08T01:41:58.031705393Z
2023-08-08T01:41:58.031709003Z This container image and its contents are governed by the NVIDIA Deep Learning Container License.
2023-08-08T01:41:58.031711483Z By pulling and using the container, you accept the terms and conditions of this license:
2023-08-08T01:41:58.031713313Z https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license
2023-08-08T01:41:58.031715133Z
2023-08-08T01:41:58.031716193Z A copy of this license is made available in this container at /NGC-DL-CONTAINER-LICENSE for your convenience.
2023-08-08T01:41:58.043720022Z
2023-08-08T01:41:58.046616223Z Exporting environment variables ...
2023-08-08T01:41:58.046693124Z Found ML_USER. Adding environment variables for ML_USER=neo.
2023-08-08T01:41:58.051772235Z export RUNPOD_CPU_COUNT="6"
2023-08-08T01:41:58.051780505Z export RUNPOD_POD_ID="<runpod-id>"
2023-08-08T01:41:58.051782145Z export RUNPOD_MEM_GB="23"
2023-08-08T01:41:58.051783285Z export RUNPOD_PUBLIC_IP="149.36.0.167"
2023-08-08T01:41:58.051785045Z export RUNPOD_GPU_COUNT="1"
2023-08-08T01:41:58.051786205Z export RUNPOD_POD_HOSTNAME="<runpod-id>-64410ad7"
2023-08-08T01:41:58.051787675Z export RUNPOD_TCP_PORT_22="11556"
2023-08-08T01:41:58.051788715Z export RUNPOD_API_KEY="<some-alphanumeric-string>"
2023-08-08T01:41:58.051790135Z export PATH="/home/neo/toolbox/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/neo/.local/bin"
2023-08-08T01:41:58.051792045Z export _="/usr/bin/printenv"
2023-08-08T01:41:58.055571811Z set -x -g RUNPOD_CPU_COUNT "6"
2023-08-08T01:41:58.055594141Z set -x -g RUNPOD_POD_ID "<runpod-id>"
2023-08-08T01:41:58.055598391Z set -x -g RUNPOD_MEM_GB "23"
2023-08-08T01:41:58.055600871Z set -x -g RUNPOD_PUBLIC_IP "149.36.0.167"
2023-08-08T01:41:58.055603111Z set -x -g RUNPOD_GPU_COUNT "1"
2023-08-08T01:41:58.055605451Z set -x -g RUNPOD_POD_HOSTNAME "<runpod-id>-64410ad7"
2023-08-08T01:41:58.055608071Z set -x -g RUNPOD_TCP_PORT_22 "11556"
2023-08-08T01:41:58.055610211Z set -x -g RUNPOD_API_KEY "<some-alphanumeric-string>"
2023-08-08T01:41:58.055613011Z set -x -g PATH "/home/neo/toolbox/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/neo/.local/bin"
2023-08-08T01:41:58.055615871Z set -x -g _ "/usr/bin/printenv"
2023-08-08T01:41:58.055618161Z Adding public key ...
2023-08-08T01:41:58.055644581Z Found PUBLIC_KEY; adding to /home/neo/.ssh/authorized_keys.
2023-08-08T01:41:58.067894530Z  * Starting nginx nginx
2023-08-08T01:41:58.081163884Z    ...done.
2023-08-08T01:41:58.092827530Z  * Starting OpenBSD Secure Shell server sshd
2023-08-08T01:41:58.101526185Z    ...done.
```

## Add the following to your local machine `.ssh/config`
Edit to add real values.
```
Host runpod
  HostName 149.36.0.167
  Port 11556
  User neo
  IdentityFile ~/.ssh/id_runpod_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 119
  ServerAliveCountMax 10
  ForwardAgent yes

 Host runpod-root
  HostName ssh.runpod.io
  User <runpod-id>-64410ad7
  IdentityFile ~/.ssh/id_runpod_ed25519
  IdentitiesOnly yes
  ServerAliveInterval 119
  ServerAliveCountMax 10
  ForwardAgent yes
```

## SSH into the machine
```shell
ssh runpod  # rsync and scp should also work nicely
# neo@a5522923ab0d ~> ls -l
# total 8
# -rw-r--r-- 1 neo neo 277 Aug  8 01:04 pytorch.requirements.txt
# drwxr-xr-x 1 neo neo  17 Aug  8 01:07 toolbox
# -rwxr-xr-x 1 neo neo 181 Aug  8 01:04 vf-install-env.fish
```

## Try out the ML
```shell
vf activate pytorch
ipython
```

```python
import torch
if torch.cuda.is_available():
    DEVICE = 'cuda'
elif torch.backends.mps.is_available():
    DEVICE = 'mps'
else:
    DEVICE = 'cpu'

DEVICE  # 'cuda'

torch.zeros(3)  # tensor([0., 0., 0.])
torch.zeros(3).device  # device(type='cpu')
torch.zeros(3, device=DEVICE)  # tensor([0., 0., 0.], device='cuda:0')
```

## Setup Tunnel to use Jupyter
After you've setup the ssh config for `runpod` above.

  1. Run jupyter on `runpod` machine
  ```shell
  jupyter notebook --no-browser --port=8888
  ```

  2. Setup a tunnel on local machine
  ```shell
  # Requires you to setup runpod entry in ~/.ssh/config
  ssh -N -f -L localhost:12345:localhost:8888 neo@runpod
  ```
  Here, `12345` is the port on local machine, `8888` is the port on runpod. `-N` means do not execute a remote command; this is useful for port forwarding only. `-f` requests SSH to go to the background just before command execution. This is useful when the command runs for a long time.

  Optionally, check if your local machine port `12345` is busy and who is using it.
  ```shell
  lsof -i :8888
  # COMMAND   PID  USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
# pycharm 13898 ankur  246u  IPv6 0x7ab3bc2d687986ad      0t0  TCP [::127.0.0.1]:56059->[::127.0.0.1]:ddi-tcp-1 (CLOSED)
# pycharm 13898 ankur  300u  IPv6 0x7ab3bc2d68949ead      0t0  TCP localhost:56058->localhost:ddi-tcp-1 (ESTABLISHED)
# pycharm 13898 ankur  302u  IPv6 0x7ab3bc2d68948ead      0t0  TCP localhost:56067->localhost:ddi-tcp-1 (ESTABLISHED)
  ```

  3. Open local machine browser to http://127.0.0.1:8888/tree?token=some-token. You can click on the link pasted by `jupyter` on the `runpod` machine.
  4. Once you're done, save notebook via the browser.
  5. Kill the running jupyter notebook.
  6. Find and kill the ssh tunnel
  ```shell
  ps aux | grep "ssh"
  # ankur            18424   0.0  0.0 408796560   2256   ??  Ss    1:02PM   0:00.01 ssh -N -f -L localhost:8888:localhost:8888 neo@runpod

  kill 18424
  ```

## Fix SSH Agent
1. Ensure that SSH key is loaded on local machine
   ```shell
   # On local machine
   ssh-add -l
   # 256 SHA256:hKIro4CO+GuK2DIeqikicRZMR8ZO2CEL6BcyY5VT+uk /Users/user/.ssh/id_github_ed25519 (ED25519)  <- We want this
   # ... other keys ...
   ```
   If a key is not loaded, run `ssh-add /path/to/private/key`. Ensure that you can do this on local machine.
   ```shell
   # On local machine
   ssh -T git@github.com
   # Hi ankur-gupta! You've successfully authenticated, but GitHub does not provide shell access.
   ```
3. Ensure that `echo "$SSH_AUTH_SOCK"` returns non-empty on remote RunPod machine
   ```shell
   # On remote RunPod machine
   echo "$SSH_AUTH_SOCK"
   # /tmp/ssh-XXXXYUE6Rs/agent.1065
   ```
4. Try out this command on remote RunPod machine again
   ```shell
   # On remote RunPod machine
   ssh -T git@github.com
   # Hi ankur-gupta! You've successfully authenticated, but GitHub does not provide shell access.
   ```
5. If the previous step fails, restart `ssh-agent` on remote RunPod machine
    ```shell
    # On remote RunPod machine
    # Fish shell not bash
    pkill -f ssh-agent; and rm -rf ~/.ssh/environment; and ssh-agent
    # SSH_AUTH_SOCK=/tmp/ssh-XXXXXXLO2SqG/agent.1869; export SSH_AUTH_SOCK;
    # SSH_AGENT_PID=1870; export SSH_AGENT_PID;
    # echo Agent pid 1870;
    ```
6. SSH from local machine into remote RunPod machine again
7. Try out this command on remote RunPod machine again
   ```shell
   # On remote RunPod machine
   ssh -T git@github.com
   # Hi ankur-gupta! You've successfully authenticated, but GitHub does not provide shell access.
   ```
   
