Class 4: 
Video link to class 4: https://www.youtube.com/watch?v=w2iLcehT-k4 
In the last class we left at the state where the web server responded with “Error: SQLSTATE[HY000] 
[2002] Permission denied” 
This error of HY000 is due to SELINUX. So we are going to change it accordingly,  
On DBnode, 
>>getenforce 
>> vim /etc/selinux/config 
and change the config file to “disabled” where SELINUX=enforcing.  
On AppNode-1, 
>>setenforce 0 
>> vim /etc/selinux/config 
and change the config file to “disabled” where SELINUX=enforcing. 
Now the server will respond.   
Setting a virtual hosting is therefore done.  
Now, we need to perform it for a distributed system where we will have atleast 2 VMs for hosting the 
application, one VM for DB hosting and a VM for load balancing. We will use HAproxy for load balancing 
for this project. 
Let’s begin. 
Clone 2 more Vm of the application Vm (Appnode1) which will be named App node 2 and HAproxyVM. 
We will set the ip as,  
App node 2= 192.168.107.131 
HAProxyVM= 192.168.107.132 
On DB node, 
>>Vim /etc/firewalld/zones/public.xml  
copy the firewall rule section and edit to add the new ip address in the firewall for rich rule. 
Now restart the firewall 
>> systemctl restart firewalld 
And check for the firewall’s allowed rules 
>> firewall-cmd –list-all 
You will be able see the newly added ip address on the firewall rich rule where we added the ip address 
of app node 2. 
Create a new user on to give permission to all the incoming traffics. 
For that, we need to drop the previous user. Go to the Mysql cmd 
>> mysql -u root -r 
>> drop user ‘bhw’@’192.168.107.128’;                                  
>> create user ‘bhw’@’%’ identified by ‘Ltest@12345’;    
>> grant all privileges on bhw.* to ‘bhw’@’%’;                    
>> flush privileges; 
// delete the previous user access on 128 ip  
// % is to allow all the incoming traffic 
// to grant all privileges 
Here we have used the ‘bhw’@’%’ to allow all incoming traffic. It generally raises questions of security. 
We know, for any connection we need to allow it through the firewall first. As we have only allowed our 
known IP addresses of the apache web server VMs previously, So, any other device won’t be able to 
connect to our database.  
To test the connection between App node 2 and DB node we need to edit the windows host file. Open 
Notepad with Administrator privileges and add the App node 2 ip in the dev-ops.csl.com line.  
Save it and check the link on web browser. It will respond with presenting the web application correctly.  
On HAProxy server, 
Add the two ip addresses in the hosts file so that the proxy server can direct traffic based on the name. 
>> vim /etc/hosts 
add 192.168.107.128 appnode1 
192.168.107.131 appnode2 
save and exit; 
Install the Haproxy package, 
>> yum install epel-release 
It will download all the dependencies.  
>> yum install haproxy 
It will download and install the HAProxy. 
Now lets view the HAproxy configuration file to better understand it,  
>> cat /etc/haproxy/haproxy.cfg  
Then configure the haproxy.cfg file according to your IP address and setup 
global 
log 127.0.0.1 local2 info 
chroot /var/lib/haproxy 
pidfile /var/run/haproxy.pid 
maxconn 1000 
user haproxy 
group haproxy 
daemon 
stats socket /var/lib/haproxy/stats 
defaults 
mode http 
log global 
option httplog 
option dontlognull 
option http-server-close 
option forwardfor except 127.0.0.0/8 
option redispatch 
retries 3 
t
 imeout http-request 600s 
t
 imeout queue 1m 
t
 imeout connect 10s 
t
 imeout client 1m 
t
 imeout server 600s 
t
 imeout http-keep-alive 6000 
t
 imeout check 10s 
maxconn 1000 
##Frontend 
frontend forumapp 
mode http 
bind *:80 
stats realm Haproxy\ Statistics 
stats show-legends 
stats refresh 60s 
stats enable 
stats auth admin:iqbal@321 
stats hide-version 
stats show-node 
stats uri /stats 
maxconn 1000 
use_backend forumback 
default_backend forumback 
#backend 
backend forumback 
mode http 
option httplog 
#option httpchk 
balance roundrobin 
#Backed servers 
server appnode1 192.168.107.128:80 
server appnode2 192.168.107.131:80 
Save and exit; 
Now to check if the configuration file is valid, 
>>haproxy -c -f /etc/haproxy/haproxy.cfg 
It will show valid if there is no problem  
Restart the HAProxy  
>> systemctl restart haproxy 
For recording the log we need to edit the log editor  
>>vim /etc/rsyslog.conf 
now edit as following, 
$ModLoad imudp  
$UDPServerRun 514  
#uncomment this line 
#uncomment this line 
# Save boot messages also to boot.log 
local7.* /var/log/boot.log 
local2.* /var/log/haproxy.log   
#Add this line 
$UDPServerAddress 127.0.0.1  #add this line 
The restart the rsyslog 
>>systemctl restart rsyslog 
Furthermore, We need to change the hosts file to map the ip address of the Haproxy, 
Add 192.168.107.132 (haproxy ip) for devops.csl.com  
And ping devops using windows cmd it will return 192.168.107.132 which is haproxy’s ip. So, setting up 
the hosts file was successful.  
To check the log file, 
>> tail -f /var/log/haproxy.log 
The log file will display something like this. You can define where the traffic was forwarded to from the 
log file. We sent two requests on the application by reloading the app. We can see that; the first request 
was forwarded to appnode1 and the request after that was forwarded to appnode2. If we had any other 
application server then it would have forwarded the next request to the available applications servers.  
In order to fully understand the routing or forwarding process we can shut down any of the applications 
server or app node.  
on AppNode1, 
>> systemctl stop httpd    
//stop apache on Appnode1  
Now, if we try sending serve request by refreshing the page, then open the log file on the HAProxy node 
it will give a result like following image,  
We can see that all the request was forwarded to appnode2 as we it could not find appnode1 for apache 
httpd being shut down by us just a moment ago.  
If we shut down or stop the apache server on Appnode2 then it will return the 503 Service Unavailable 
Error as it does not have any active server to forward the request to.  
Now to check the stats of the requests we can access the stats from the application, 
Go to devops.csl.com/stats and use the user name and password that we provided in the haproxy file, 
which is user: admin pass: iqbal@321 in this case 
It will show a stat dashboard you can see how many requests are in queue, how many sessions it has 
served, denied, erros etc.  
