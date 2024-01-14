![image](https://github.com/jomertix/marzban-tools/assets/150632538/cb0cc573-4c3b-4534-a901-cd82a6d0cd6c)
![image](https://github.com/jomertix/marzban-tools/assets/150632538/292f42b2-8980-46f4-b9d3-8d9b4e29a586)


# Introduction

Minimalistic subscription page

# Installation

Connect to the server and upload the file:
```
sudo wget -N -P /var/lib/marzban/templates/subscription/ https://raw.githubusercontent.com/jomertix/marzban-tools/master/subscription/index.html
```
Enter these commands to automatically specify the file path to the subscription page:
```
echo 'CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"' | sudo tee -a /opt/marzban/.env
echo 'SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"' | sudo tee -a /opt/marzban/.env
```
Or specify them manually by editing the Marzban .env file 
```
CUSTOM_TEMPLATES_DIRECTORY="/var/lib/marzban/templates/"
SUBSCRIPTION_PAGE_TEMPLATE="subscription/index.html"
```
Restart marzban
```
marzban restart
```
