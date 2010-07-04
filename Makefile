PYTHON          = python
APPENGINE       = /usr/local/google_appengine
APP_ID          = (YOUR-APP-ID)
EMAIL           = (YOUR-EMAIL)
SERVE_PORT      = 9091
SERVE_ADDRESS   = 0.0.0.0
DATASTORE_PATH  = ./datastore

help:
	@echo "AppEngine make file. Options are:"
	@echo " test       Runs the test suite"
	@echo " coverage   Runs the test suite and prints a coverage report"
	@echo " deploy     Deploys the current project to AppEngine"
	@echo " rollback   Rolls back a unclosed update to the application"
	@echo " serve      Runs the development web server"
	@echo " console    Opens a development console to your remote application"
	@echo "            (Only works if you've enabled the /remote_api URL"

test:
	@nosetests --with-gae --with-isolation $(dir)

coverage:
	@nosetests --with-gae --with-isolation --with-coverage $(dir)

deploy:
	@$(PYTHON) $(APPENGINE)/appcfg.py -e $(EMAIL) update .

rollback:
	@$(PYTHON) $(APPENGINE)/appcfg.py -e $(EMAIL) rollback .

serve:
	@$(PYTHON) $(APPENGINE)/dev_appserver.py \
	-a $(SERVE_ADDRESS) \
	-p $(SERVE_PORT) \
	--datastore_path=$(DATASTORE_PATH) \
	--disable_static_caching \
	.

console:
	@$(PYTHON) -c "import code, getpass; \
from google.appengine.ext.remote_api import remote_api_stub; \
auth = lambda: ('$(EMAIL)', getpass.getpass('Password: ')); \
remote_api_stub.ConfigureRemoteDatastore('$(APP_ID)', '/remote_api', auth, '$(APP_ID).appspot.com'); \
code.interact('App Engine console for $(APP_ID)', None, locals());"

project:
ifndef name
	@echo "You must define a project name!"
else
	@mkdir scripts
	@mkdir $(name)
	@mkdir $(name)/handlers
	@mkdir $(name)/handlers/tests
	@mkdir $(name)/library
	@mkdir $(name)/library/tests
	@mkdir $(name)/models
	@mkdir $(name)/models/tests
	@mkdir $(name)/static
	@mkdir $(name)/static/media
	@mkdir $(name)/static/templates
	@touch $(name)/__init__.py
	@touch $(name)/handlers/__init__.py
	@touch $(name)/handlers/tests/__init__.py
	@touch $(name)/library/__init__.py
	@touch $(name)/library/tests/__init__.py
	@touch $(name)/models/__init__.py
	@touch $(name)/models/tests/__init__.py
	@echo "application: $(name)" >> app.yaml
	@echo "version: 1" >> app.yaml
	@echo "runtime: python" >> app.yaml
	@echo "api_version: 1" >> app.yaml
	@echo "" >> app.yaml
	@echo "handlers:" >> app.yaml
endif

helipad-project: project
	@wget -q http://github.com/jgeewax/helipad/raw/master/helipad.py
	@wget -q http://github.com/jgeewax/helipad/raw/master/jinja2
