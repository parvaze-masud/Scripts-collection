## Nginx installation command:- 
```
apt update
apt install nginx
```
## Nginx configuration file for 80:-
```
server {
    listen 80;
    listen [::]:80;

    # The domain on which this server block will listen
    server_name explorer.devolvedai.com www.explorer.devolvedai.com;

    # Log files for debugging and monitoring
    access_log /var/log/nginx/explorer.devolvedai.com_access.log;
    error_log /var/log/nginx/explorer.devolvedai.com_error.log;

    # Main location block
    location / {
        # Proxy pass to the app running on localhost port 9944
        proxy_pass http://localhost:9944;
        proxy_http_version 1.1;

        # Header settings
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        # Disable proxy buffering
        proxy_buffering off;
    }

    # Redirect server error pages to the static page /50x.html
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
```

```
sudo ln -s /etc/nginx/sites-available/expotest.devolvedai.com.conf /etc/nginx/sites-enabled/expotest.devolvedai.com.conf
```
## certbot install command :- 
```
sudo apt update
sudo apt install certbot python3-certbot-nginx
```
## Generate a free SSL for your website:-
```
sudo certbot --nginx -d rpc.devolvedai.com
```
# Auto renew 
#Edit the Crontab File
```
sudo crontab -e
```
# Create a New Cron Job 
#(This command creates a new cron job that runs the certbot renew command every 12 hours. The --quiet option instructs Certbot to remain silent unless there’s an error or a successful renewal. 
#The --post-hook option specifies a command to be run after each successful renewal — in this use case, reloading the NGINX reserve to implement the new certificates.)
```
0 */12 * * * /usr/bin/certbot renew --quiet --post-hook "systemctl reload nginx"
```
# Save Changes and Exit.
## In nano, you can save the changes by pressing Ctrl+0, then press Enter to confirm the filename, and finally Ctrl+X to exit the editor.

# Verify the Cron Job
```
sudo crontab -l
```
