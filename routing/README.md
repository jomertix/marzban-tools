# Routing
An example of a config that routes the specific traffic from a foreign server to a domestic one. Hides traffic from the censor. The user no longer needs to disable the vpn to access the internal site.


Generate pair of public and private keys:
```
docker exec marzban-marzban-1 xray x25519
```

Generate uuid:
```
uuidgen
```

Generate short id:
```
openssl rand -hex 8
```
