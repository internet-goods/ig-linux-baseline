
curl -L https://meltdown.ovh -o spectre-meltdown-checker.sh
chmod +x spectre-meltdown-checker.sh
./spectre-meltdown-checker.sh

git clone https://github.com/arthepsy/ssh-audit
python3 ssh-audit/ssh-audit.py

git clone https://github.com/docker/docker-bench-security
cd docker-bench-security
sh ./docker-bench-security.sh -l docker-bench-security-$(date -I).log

lynis audit system
