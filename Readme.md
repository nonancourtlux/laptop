
# Make iso
Prepare two usb  keys
```
# Frist run pre-populate vars/secrets.yaml
# And again after review/adaptation of vars/secrets.yaml ( wifi settings )
make iso
```



# References
 - https://askubuntu.com/questions/1513521/autoinstall-in-cloud-init-stops-with-question-continue-with-autoinstall-yesn
 - https://www.dbi-services.com/blog/cloud-init-native-ansible-support/
 - https://gist.github.com/Informatic/0b6b24374b54d09c77b9d25595cdbd47
 - https://canonical-subiquity.readthedocs-hosted.com/en/latest/reference/autoinstall-reference.html

Single iso method ie merge cloud-init and maint iso:
 - https://terminallabs.com/blog/autoinstall-ubuntu22/
 - https://www.jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/



# List devices
```
ls /sys/class/net
iwlist wlp3s0 scan | grep  ESSID
```



# Todo
```
- single iso
- profile firefox
- ssh accept
- logo to review
- lock screen
- firefox link
- scratch first
- restore hashpasswd if password deleete

# Misc
gsettings get org.gnome.shell favorite-apps
gsettings list-recursively | grep screen
find ~scratch -maxdepth 1 -mindepth 1 -exec rm -fr {} \;
https://askubuntu.com/questions/1037553/how-to-configure-a-dconf-key-globally-across-all-user-accounts


# Firefox & snap are a mess
- https://virtuallyjason.blogspot.com/2013/10/cutomizing-mozilla-firefox-for.html
- https://kb.mozillazine.org/Locking_preferences


