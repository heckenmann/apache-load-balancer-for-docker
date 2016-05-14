# apache-load-balancer-for-docker
Dockerfile für Apache Load-Balancer

##Image bauen:
```
docker build -t apache-load-balancer-for-docker .
```

##Container starten:
```
docker run -d --name alb -p 80:80 -p 443:443 apache-load-balancer-for-docker
```

##Quellen:

http://httpd.apache.org/docs/2.2/mod/mod_proxy.html

http://httpd.apache.org/docs/current/mod/mod_proxy_balancer.html
