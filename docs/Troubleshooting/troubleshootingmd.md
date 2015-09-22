# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before.

## Useful linux commands

`$ ls -alt`

`$ cd`

`$ tail -f /var/log/syslog`

`$ df -h`

`$ ifconfig`

`$ cat <filename>`

`$ stat <filename>`

`dmesg`

dmesg shows you all the kernel output since boot. It’s pretty difficult to read - but sometimes you see things in there about the wifi getting disconnected and so forth; generally someone that knows linux and knows what to look out for will have to read it

`uptime`