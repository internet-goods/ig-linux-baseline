curl -L https://meltdown.ovh -o spectre-meltdown-checker.sh
chmod +x spectre-meltdown-checker.shspectre-meltdown-checker.sh
./spectre-meltdown-checker.sh > spectre-meltdown-checker-$(date -I).log

git clone https://github.com/arthepsy/ssh-audit
python3 ssh-audit/ssh-audit.py localhost > ssh-audit-%(date -I).log

git clone https://github.com/docker/docker-bench-security
sh ./docker-bench-security/docker-bench-security.sh -l docker-bench-security-$(date -I).log
echo check lynis.log after audit
lynis audit system
