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
commit
save
exit
