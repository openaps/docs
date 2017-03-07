# Adding shortcuts to command lines

Linux command lines can be long-to-type and difficult-to-remember.  Sometimes it is really helpful to create aliases for frequently used commands or combination of commands that you'll use in your OpenAPS rig.  Here's a short set of instructions for setting up aliases.  You can customize the initial list of aliases however you'd like.

* Create a blank profile
<br>
`nano ~/.bash_profile`
<br>
* Copy and paste (or make your own aliases) the following aliases into the blank profile
<br>
```
alias autosens-loop="tail -n 100 -F /var/log/openaps/autosens-loop.log"
alias autotune="tail -n 100 -F /var/log/openaps/autotune.log"
alias ns-loop="tail -n 100 -F /var/log/openaps/ns-loop.log"
alias pump-loop="tail -n 100 -F /var/log/openaps/pump-loop.log"
alias cat-pref="cd ~/myopenaps && cat preferences.json"
alias edit-wifi="vi /etc/wpa_supplicant/wpa_supplicant.conf"
alias cat-wifi="cat /etc/wpa_supplicant/wpa_supplicant.conf"
alias edit-pref="cd ~/myopenaps && vi preferences.json"
alias log-wifi="tail -n 100 -F /var/log/openaps/network.log"
alias git-branch="cd ~/src/oref0 && git branch"
alias cat-autotune="cd ~/myopenaps/autotune && cat autotune_recommendations.lo$
alias edit-runagain="cd ~/myopenaps && nano oref0-runagain.sh"
alias cat-runagain="cd ~/myopenaps && cat oref0-runagain.sh"
```
<br>
Exit the nano editor by pressing `control-x`, then typing `y` to save file, and then `return` to save with same file name.
<br>
* Tell your rig to use this profile (note: this command will need to be done after each update to the profile too, or the new aliases won't be activated until you reboot)
<br>
`source ~/.bash_profile`
