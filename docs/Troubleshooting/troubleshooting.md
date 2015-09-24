# Troubleshooting

Even those who follow this documentation precisely are bound to end up stuck at some point. This could be due to something unique to your system, a mistyped command, actions performed out of order, or even a typo in this guide. This section provides some tools to help diagnose the issue as well as some common errors that have been experienced and resolved before.

## Useful linux commands

[add link to references, more general and comprehensive command list here]

`$ ls -alt`

`$ cd`

`$ pwd`

`$ sudo <command>`

`$ tail -f /var/log/syslog`

`$ df -h`

`$ ifconfig`

`$ cat <filename>`

`$ nano <filename>`

`$ stat <filename>`

`$ pip freeze`

`$ sudo reboot`

`$ sudo shutdown -h now`

`$ dmesg`

dmesg shows you all the kernel output since boot. It’s pretty difficult to read - but sometimes you see things in there about the wifi getting disconnected and so forth; generally someone that knows linux and knows what to look out for will have to read it

`uptime`

[add something for decocare raw logging]

## CareLink USB Stick

fix-stick.sh

Range issues: range is crap, orientation matters; see [range testing report](https://gist.github.com/channemann/0ff376e350d94ccc9f00).