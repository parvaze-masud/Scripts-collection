# Install Promethues + Grafana + Node Exporter

## Change Directory to /opt
```
cd /opt/
```
## Now copy and paste below mention command
```
wget https://github.com/prometheus/prometheus/releases/download/v2.45.0-rc.0/prometheus-2.45.0-rc.0.linux-amd64.tar.gz
tar -xzvf prometheus-2.45.0-rc.0.linux-amd64.tar.gz
mv prometheus-2.45.0-rc.0.linux-amd64 prometheus
cp -r prometheus /etc/
cd /etc/prometheus/
useradd --no-create-home --shell /bin/false prometheus
mkdir /var/lib/prometheus -p
chown prometheus:prometheus /var/lib/prometheus/
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
vim /etc/prometheus/prometheus.yml
```
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
  - job_name: node_exporter
    static_configs:
      - targets: ['192.168.44.136:9100']

vim /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus
netstat -tulpn
firewall-cmd --add-port=9090/tcp
firewall-cmd --reload


Install: Node_Exporter
----------------------

cd /opt/ && sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar -xzvf node_exporter-1.6.1.linux-amd64.tar.gz
mv node_exporter-1.6.1.linux-amd64 node_exporter
cd node_exporter
cp node_exporter /usr/local/bin/
adduser -rs /bin/false nodeuser

Crate service:
--------------

vim /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
After=network.target
[Service]
User=nodeuser
Group=nodeuser
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl start node_exporter
systemctl status node_exporter
netstat -tulpn
systemctl enable node_exporter
firewall-cmd --list-all
firewall-cmd --permanent --add-port=9100/tcp
firewall-cmd --reload

Install Grafana:
----------------
vim /etc/yum.repos.d/grafana.repo

[grafana]
name=grafana
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt

yum repolist

yum install grafana
systemctl start grafana-server
systemctl status grafana-server
systemctl enable grafana-server
systemctl status grafana-server

firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --reload

Preometheus URL: http://192.168.44.135:9090
Grafana: http://192.168.44.135:3000
