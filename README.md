# docker-yquake2
Dockerfile to build Yamagi q2ded container 

How build:
```
$docker build . --tag yqake2
```

How run:
```
$docker run --name q2 -d --rm -v /home/santic/.q2pro_t:/home/quake2/.yq2 -p 27999:27910/udp yqake2 +set game ctf
```

How to configure Docker in ArchLinux (Rootless mode):
```
#echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/99-docker-rootless.conf

#sudo sysctl --system

$yaourt -S docker-rootless subuid-register

$subuid-register

#echo 'santic:814481408:65536' > /etc/subgid

#echo 'santic:814481408:65536' > /etc/subuid

$export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

$systemctl --user start docker

$systemctl --user enable docker
#loginctl enable-linger santic
```
