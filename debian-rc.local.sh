cat <<'EOF' > /etc/systemd/system/rc-local.service
 [Unit]  
  Description=/etc/rc.local Compatibility  
  ConditionPathExists=/etc/rc.local  
 [Service]  
  Type=forking  
  ExecStart=/etc/rc.local start  
  TimeoutSec=0  
  StandardOutput=tty  
  RemainAfterExit=yes  
  SysVStartPriority=99  
 [Install]  
  WantedBy=multi-user.target  
EOF

printf '%s\n' '#!/bin/bash' 'exit 0' | tee -a /etc/rc.local  
chmod +x /etc/rc.local
systemctl enable rc-local  
systemctl start rc-local.service  
systemctl status rc-local.service
