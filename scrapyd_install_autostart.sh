#/bin/bash

pip install scrapyd
cd $HOME
rmdir ~/scrapyd
mkdir ~/scrapyd
sudo rm /usr/lib/systemd/system/scrapyd.service
sudo touch /usr/lib/systemd/system/scrapyd.service
sudo chown $USER:$USER /usr/lib/systemd/system/scrapyd.service
sudo echo "
[Unit]
Description=Scrapyd service
After=network.target

[Service]
User=user
Group=group
WorkingDirectory=anydirectory
ExecStart=scrapyd

[Install]
WantedBy=multi-user.target " >> /usr/lib/systemd/system/scrapyd.service

sudo sed -i "s/User\=user/User\=chen/" /usr/lib/systemd/system/scrapyd.service
sudo sed -i "s/Group\=group/Group\=chen/" /usr/lib/systemd/system/scrapyd.service
sudo sed -i "s|=anydirectory|="$HOME"/scrapyd|" /usr/lib/systemd/system/scrapyd.service
scrapyd_bin=`echo $(whereis scrapyd) | cut -c 10-99`
echo "$scrapyd_bin"
sudo sed -i "s|=scrapyd|="$scrapyd_bin"|" /usr/lib/systemd/system/scrapyd.service

# nohup $(whereis scrapyd) >& /dev/null &
sudo systemctl enable scrapyd.service
sudo service scrapyd start
sudo service scrapyd status
echo "please change bind ip address in scrapyd.conf and reload scrapyd conf"
