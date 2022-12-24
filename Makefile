PYTHON := python3.9
VENV_DIR=$(CURDIR)/venv
export VIRTUAL_ENV=$(VENV_DIR)
export PATH=$(VENV_DIR)/bin:$(shell echo $$PATH)

all: venv
	python patcher.py

venv: requirements.txt
	test -d "$(VENV_DIR)" || $(PYTHON) -m venv "$(VENV_DIR)"
	python -m pip install --upgrade pip --progress-bar off --quiet
	python -m pip install -r requirements.txt --progress-bar off --quiet

requirements.txt: | requirements.in
	test -d __venv && rm -Rf __venv || true
	$(PYTHON) -m venv __venv
	./__venv/bin/python -m pip install pip-tools
	./__venv/bin/python -m piptools compile --no-header --annotation-style line --output-file requirements.txt $<
	rm -Rf __venv

clean:
	rm -Rf "$(VENV_DIR)" chromedriver
	find . -type d -name "__pycache__" -exec rm -Rf {} \; || true
	find . -type f -name "*.pyc" -exec rm -Rf {} \; || true

.PHONY: all clean
