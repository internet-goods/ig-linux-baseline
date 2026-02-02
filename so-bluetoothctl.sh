#run one time
mkdir -p /nsm/bluetoothctl
echo SCANNING BT 
echo bluetoothctl power on
bluetoothctl power on
echo bluetoothctl show

bluetoothctl show

bluetoothctl show > /nsm/bluetoothctl/bluetoothctlshow-$(date +%Y%m%d%H%M%S).log
echo bluetoothctl --timeout 10 scan on 
#run from cron.hourly? leave 100 second gap between runs
bluetoothctl --timeout 3500 scan on > /nsm/bluetoothctl/bluetoothctlscan-$(date +%Y%m%d%H%M%S).log
