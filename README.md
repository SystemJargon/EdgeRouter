### VPN Provider - get the auth info and ovpn file

* Login into your VPN providers portal or website.
* Go to Setup Device and choose router configuration or alike.
* Copy the username and passwords strings you will find usually under authentication.
* Download the OVPN configuration file to your computer from one of the locations you prefer. Example US-01.

### OVPN editing

* Open the ovpn file and edit the line ```auth-user-pass``` and replace it with ```auth-user-pass /config/auth/user-pass.txt``` and replace ```route-pull``` with ```route-nopull```

### OVPN and file transfer

Now transfer the OVPN file to your EdgeRouter with scp or filezilla or whatever you choose. Even copy and paste works.

Example:


```
scp us-01-vpn.ovpn admin@192.168.5.1:/config/auth/vpn.ovpn
```

### VPN Authentication config

SSH into your EdgeRouter and login as root
```
sudo su -l
```

Create a file and insert the VPN username and password you got on the website for authentication, pasting username and password  - one per line, then save the file
```
vi /config/auth/user-pass.txt
```

### Network Configuration

Exit the root user. Now the actual configuration is required for the interface and NAT rules.


Copy and paste as your configuration to the Edgerouter.


```
configure
set interfaces openvpn vtun0 config-file /config/auth/vpn.ovpn
set interfaces openvpn vtun0 description 'VPN-Provider'
set firewall modify your_vpn_route rule 10 description 'YourVPN'
set firewall modify your_vpn_route rule 10 source address 192.168.5.0/24
set firewall modify your_vpn_route rule 10 modify table 1
set protocols static table 1 interface-route 0.0.0.0/0 next-hop-interface vtun0
set interfaces switch switch0 firewall in modify your_vpn_route  
set service nat rule 5001 description 'YourVPN'
set service nat rule 5001 log disable
set service nat rule 5001 outbound-interface vtun0
set service nat rule 5001 type masquerade
commit; save;
exit
```

Replace the values to your own requirements for any of the following:


```your_vpn_route```

```YourVPN```

```VPN-Provider```

```192.168.5.0/24```


### Logs
```
grep openvpn /var/log/messages
```

You can try nano instead of vi too.
