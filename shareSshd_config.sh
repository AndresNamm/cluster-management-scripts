for cluster_number in 1 2 3 4
do
scp /etc/ssh/sshd_config root@klaster$cluster_number:/etc/ssh/sshd_config
done
for cluster_number in 1 2 3 4
do
ssh -t root@klaster$cluster_number "systemctl restart sshd.service"
done



