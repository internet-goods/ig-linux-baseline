#!/bin/bash

mount -o remount,hidepid=2 /proc
bash debian-cron.sh

echo "* hard core 0" > /etc/security/limits.d/ig-baseline.conf
echo "* soft core 0" > /etc/security/limits.d/ig-baseline.conf

sed -i 's/sha512/sha512 rounds=800000/g' /etc/pam.d/common-password


bash sysctl-basdeline.sh
bash sshd-baseline.sh
apt -y install sysstat
apt -y install mdadm
apt -y install htop
apt -y install gimp
apt -y install audacity
apt -y install strace
apt -y install iotop iftop
apt -y install pidgin*
apt -y zenity #steam


systemctl enable sysstat
sed -i 's/false/true/g' /etc/default/sysstat
service acct start

cp issue /etc/issue
cp issue /etc/issue.net

# Open inbound ssh(tcp port 22) connections
#5.2 ssh cfg


apt-get -y install apktool
apt-get -y install checksec
apt-get -y install hcxtools
apt-get -y install ghidra 
apt-get -y install airgeddon
apt-get -y install btscanner
apt-get -y install eaphammer
apt-get -y install python2-dev libpcap-dev
apt-get -y install hostapd hostapd-wpe
apt-get -y install python3-launchpadlib
apt-get -y install libreoffice-writer
apt-get -y install libreoffice-calc
apt-get -y install yubikey-manager-qt
apt-get -y install keepassxc-full
apt-get -y install neowofetch
apt -y install jupyter-notebook jupyter-core python3-ipykernel
apt -y install inxi
apt -y install python3-selenium
apt -y install python3-bs4
apt -y install python3-pandas
apt -y install python3-pyautogui
apt -y install python3-lxml
#no python-future?
apt -y install python3-futurist
apt -y install python3-packaging
apt -y install python3-bs4
apt -y install python3-dotenv
apt -y install python3-pyautogui
apt -y install python3-sklearn
apt -y install maltego
#media apps#AI OVERLORDS GO!
echo AI1 LLM
apt -y install llm
llm install claude
llm install llm-gpt4all
python3 -m venv myllm_env
cd myllm_env 
source bin/activate  
python3 -m pip install --upgrade gpt4all typer
#python hellllm install llm-gpt4all
# 
wget https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py
python3 app.py repl
echo AI2 OLLAMA
curl https://ollama.ai/install.sh | sh
ollama pull llama3
ollama run llama3 "Say 'Hello, world!'"
echo AI3 WEKA
#pdsh -R ssh -w "weka0-[0-7]" "curl https://[GET.WEKA.IO-TOKEN]@get.weka.io/dist/v1/install/4.0.5.14/4.0.5.14 | sh#AI OVERLORDS GO!
echo AI1 LLM
apt -y install llm
llm install claude
llm install llm-gpt4all
python3 -m venv myllm_env
cd myllm_env 
source bin/activate  
python3 -m pip install --upgrade gpt4all typer
python3 -m pip install "gpt4all[cuda]" 
#python hellllm install llm-gpt4all
# 
wget https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py
python3 app.py repl
echo AI2 OLLAMA
curl https://ollama.ai/install.sh | sh
ollama pull llama3
ollama run llama3 "Say 'Hello, world!'"
echo AI3 WEKA
#pdsh -R ssh -w "weka0-[0-7]" "curl https://[GET.WEKA.IO-TOKEN]@get.weka.io/dist/v1/install/4.0.5.14/4.0.5.14 | sh
apt -y install supercollider
apt -y install mpv
apt -y install vlc
apt -y install smplayer
apt -y install npm
apt -y install stopwatch
npm install elasticdump
#apt-add-repository -y ppa:team-xbmc/ppa
#apt -y install kodi
apt -y install auditd
cp audit.rules /etc/audit
sed -i 's/no/yes/g' /etc/audit/plugins.d/syslog.conf
/etc/init.d/auditd restart

apt -y install 
apt -y autoremove 
#purge to pass lynis
dpkg --get-selections | awk '$2=="deinstall" {system("sudo apt-get -y purge "$1)}'
#lynis audit system
apt -y install iptables iptables-persistent
bash debian-iptables.sh

sed -i 's/22/27/g' /etc/login.defs
echo "SHA_CRYPT_MIN_ROUNDS 800000" >> /etc/login.defs
echo "SHA_CRYPT_MAX_ROUNDS 900000" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs

#disable modules
echo "install cramfs /bin/true" > /etc/modprobe.d/debian-baseline.conf
echo "install freevxfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install jffs2 /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install hfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install hfsplus /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install squashfs /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install udf /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install vfat /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "options ipv6 disable=1" >> /etc/modprobe.d/debian-baseline.conf
echo "install dccp /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install rds /bin/true" >> /etc/modprobe.d/debian-baseline.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/debian-baseline.conf
#echo "-w /sbin/modprobe -p x -k modules" >> /etc/audit/rules.d/debian-baseline.conf
#/etc/modprobe.d/debian-baseline.confsystemctl -w kernel.yama.ptrace_scope=3
echo "install firewire-ohci /bin/true" >>  /etc/modprobe.d/debian-baseline.conf
echo "install firewire-sbp2 /bin/true" >>  /etc/modprobe.d/debian-baseline.conf
echo "install usb-storage /bin/true" >> /etc/modprobe.d/debian-baseline.conf
llm install claude
echo umask 022 > /etc/profile.d/debian-baseline.sh

chmod 600 /etc/crontab
chmod 700 /etc/cron.d
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly
chmod 600 /etc/cron.deny

#curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
#    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
#apt install -y nvidia-container-toolkit
apt -y install condor
apt -y install docker.io docker-doc docker-compose containerd
systemctl enable docker
systemctl start docker
docker info
#https://greenbone.github.io/docs/latest/22.4/container/index.html
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt update
#apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
#userapp settings
echo "set mouse=a" >> /etc/vim/vimrc

#AI OVERLORDS GO!
echo AI1 LLM
apt -y install llm
llm install claude
llm install llm-gpt4all
python3 -m venv myllm_env
cd myllm_env 
source bin/activate  
python3 -m pip install --upgrade gpt4all typer typing-extensions
#python hellllm install llm-gpt4all
# 
wget https://raw.githubusercontent.com/nomic-ai/gpt4all/main/gpt4all-bindings/cli/app.py
python3 app.py repl
echo AI2 OLLAMA
curl https://ollama.ai/install.sh | sh
ollama pull llama3
ollama pull dolphin-llama3
ollama pull llama2-uncensored
echo AI3 WEKA
#pdsh -R ssh -w "weka0-[0-7]" "curl https://[GET.WEKA.IO-TOKEN]@get.weka.io/dist/v1/install/4.0.5.14/4.0.5.14 | sh
echo AI4 Openclaw
curl -fsSL https://openclaw.ai/install.sh | bash
