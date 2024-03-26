# Video Link: https://www.youtube.com/watch?v=-R9y09eOzoQ

1] In this video we will launch a new ec2 instance and on that we will install a nginx as a web server for hosting the website.
2] Then first we will run our website on 80 ports without SSL certificate

3] Then we will install certbot lets-encrypt (free SSL certificate) for our website.

4] Nginx installation command:- 
apt update
apt install nginx

5] Nginx configration file for 80 :-
server {
listen 80;
server_name shivm04.xyz; # Edit this to your domain name
client_max_body_size 100M;
 
  index index.html index.php;
  root /var/www/html/shivm04.xyz/;  # change your code directory

   access_log  /var/log/nginx/shivm04.xyz/access.log;           #Add ssl access log file on the server
   error_log   /var/log/nginx/shivm04.xyz/error.log;             #Add ssl error log file on the server

 }

6] certbot install command :- 
sudo apt update
sudo apt install certbot python3-certbot-nginx

7] Generate a free ssl for your website :-
sudo certbot --nginx -d shivm04.xyz

# Auto renew 
#Edit the Crontab File

sudo crontab -e

# Create a New Cron Job 
#(This command creates a new cron job that runs the certbot renew command every 12 hours. The --quiet option instructs Certbot to remain silent unless there’s an error or a successful renewal. 
#The --post-hook option specifies a command to be run after each successful renewal — in this use case, reloading the NGINX reservice to implement the new certificates.)

0 */12 * * * /usr/bin/certbot renew --quiet --post-hook "systemctl reload nginx"

#Save Changes and Exit
In nano, you can save the changes by pressing Ctrl+0, then press Enter to confirm the filename, and finally Ctrl+X to exit the editor.

# Verify the Cron Job

sudo crontab -l
