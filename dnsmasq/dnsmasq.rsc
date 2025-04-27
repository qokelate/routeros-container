

/container envs add key=TZ name=TZ value=Asia/Shanghai
/container mounts add dst=/data1 name=udisk src=/usb1-part1

/interface veth add address=192.168.0.202/24 gateway=192.168.0.1 gateway6="" name=veth2
/interface bridge port add bridge=LAN interface=veth2

/container/add mounts=udisk remote-image=drpsychick/dnsmasq:latest \
dns=223.5.5.5 envlist=TZ hostname=dnsmasq.local \
cmd="-k -C /data1/dnsmasq/dnsmasq.conf" \
interface=veth2 root-dir=usb1-part1/container/dnsmasq logging=yes

