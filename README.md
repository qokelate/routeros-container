```

/container mounts add dst=/data1 name=data1 src=/
/container config set registry-url=https://registry.hub.docker.com tmpdir=usb1-part1/container
/container envs add key=TZ name=TZ value=Asia/Shanghai
/container envs add key=ENABLE_CJK_FONT name=TZ value=1

/interface/bridge/add protocol-mode=none name=docker
/ip/address/add interface=docker address=172.16.0.14/28

/interface/veth/add name=veth1 address=172.16.0.1/28 gateway=172.16.0.14
/interface/veth/add name=veth2 address=172.16.0.2/28 gateway=172.16.0.14
/interface/veth/add name=veth3 address=172.16.0.3/28 gateway=172.16.0.14
/interface/veth/add name=veth4 address=172.16.0.4/28 gateway=172.16.0.14

/interface/bridge/port add bridge=docker interface=veth1
/interface/bridge/port add bridge=docker interface=veth2
/interface/bridge/port add bridge=docker interface=veth3
/interface/bridge/port add bridge=docker interface=veth4

/container add file=sshd.tar \
envlist=TZ hostname=sshd.local interface=veth1 logging=yes mounts=data1 \
root-dir=usb1-part1/container/sshd start-on-boot=no

/container add file=alpine.tar \
cmd="-c 'cp -fv /data1/xray/xray /;chmod 777 /xray;/xray run -c /data1/xray/config.json'" \
entrypoint=ash envlist=TZ hostname=xray.local interface=veth2 logging=yes mounts=data1 \
root-dir=usb1-part1/container/xray start-on-boot=no

/container add file=dnsmasq.tar \
cmd="-k -C /data1/dnsmasq/dnsmasq.conf" \
envlist=TZ hostname=dnsmasq.local interface=veth3 logging=yes mounts=data1 \
root-dir=usb1-part1/container/dnsmasq start-on-boot=no

/container add file=alpine.tar \
cmd="-c 'cp -fv /data1/ros-api/ros-api /;chmod 777 /ros-api;/ros-api'" \
entrypoint=ash envlist=TZ hostname=ros-api.local interface=veth4 logging=yes mounts=data1 \
root-dir=usb1-part1/container/ros-api start-on-boot=no

```
