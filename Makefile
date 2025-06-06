LIST:=usb-creator-gtk cloud-image-utils gnome-disk-utility whois ansible-core git

OPTS:= --diff

alt%:  OPTS+= -e alt=$@.yaml
view check:  OPTS+= --check

iso alt%: packages pull
	ansible-playbook $(OPTS) iso.yaml
	@echo
	@echo "Insert a key for the cloud-init , then answer y"
	@echo
	-@echo "/tmp/nocloud-usb.sh" | xargs -r -n1 -p bash
	@echo
	@echo "Insert a key for the iso, then answer y"
	@echo
	-@echo "/tmp/media-usb.sh" | xargs -r -n1 -p bash

view check:
	-ansible-playbook $(OPTS) config.yaml

pull:
	@git pull


$(LIST):
	@dpkg -s $@ 2>/dev/null |  grep "Status: install" || sudo apt install -y $@

packages: $(LIST)
	@echo $@ 
