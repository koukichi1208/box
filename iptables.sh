#!/bin/sh
# iptables Delete all rules
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
# INPUT/FORWARD deny
# OUTPUT allow
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
#From host access all allow
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Allow reply access from outside to access done from inside
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# ssh allow
iptables -A INPUT -s 192.168.11.101 -m tcp -p tcp --dport 22 -j ACCEPT

#Save
/usr/libexec/iptables/iptables.init save
