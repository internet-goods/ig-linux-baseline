mkdir $(date -I)
cd $(date -I)
systemctl list-units --all > systemctl-list-units.txt
systemctl list-units --all
echo systemctl list-units --type=service --all  for just services
