DIR ?= monitored_dir
MALICIOUS_DIR ?= quarantine_dir
INTERVAL ?= 5


all: run

pre-build:
	mkdir -p $(MALICIOUS_DIR)
	mkdir -p $(DIR)
	
run: pre-build
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)

restore: pre-build
	./restore.sh $(DIR) $(MALICIOUS_DIR)
	
clean:
	rm -f directory-info.last directory-info.new

