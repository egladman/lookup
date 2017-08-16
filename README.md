# lookup

Set reminders for every 20 minutes to take a 20-second break and focus your eyes on something at least 20 feet away. Staring at short distance objects for prolonged periods (i.e. your monitor) can strain your eyes.

### How to install
```
wget https://raw.githubusercontent.com/egladman/lookup/master/lookup.sh -o /usr/local/bin/lookup
```

### How to use (manually)

##### Set a reminder to lookup in 20 minutes
```
lookup 20
```

### How to use (automated)

Setup a cron job or systemd service file.

##### systemd

Create `/etc/systemd/system/lookup.service`

```
[Unit]
Description=Look up reminders to reduce eye strain

[Service]
ExecStart=/usr/local/bin/lookup 20

Restart=always

[Install]
WantedBy=multi-user.target
```

Start service

```
sudo systemctl start lookup
```

Enable service

```
sudo systemctl enable lookup
```

