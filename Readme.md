
# Make iso
Prepare two usb  keys
```
# Run once to pre-populate vars/secrets.yaml
# And again after review/adaptation of vars/secrets.yaml
make iso
```




# 

# References
 - https://www.jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/
 - https://askubuntu.com/questions/1513521/autoinstall-in-cloud-init-stops-with-question-continue-with-autoinstall-yesn
 - https://www.dbi-services.com/blog/cloud-init-native-ansible-support/
 - https://gist.github.com/Informatic/0b6b24374b54d09c77b9d25595cdbd47
 - https://canonical-subiquity.readthedocs-hosted.com/en/latest/reference/autoinstall-reference.html

# List devices
```
ls /sys/class/net
iwlist wlp3s0 scan | grep  ESSID
```








