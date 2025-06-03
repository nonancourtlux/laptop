LIST:=usb-creator-gtk cloud-image-utils gnome-disk-utility whois ansible-core git

OPTS:= --diff

master: packages pull
	ansible-playbook $(OPTS) master.yaml

alt%: packages pull
	ansible-playbook $(OPTS) -e alt=$@.yaml master.yaml


pull:
	@git pull


$(LIST):
	@dpkg -s $@ 2>/dev/null |  grep "Status: install" || sudo apt install -y $@

packages: $(LIST)
	@echo $@ 
