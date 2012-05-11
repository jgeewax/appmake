### Quick start

    curl -OL --silent http://github.com/jgeewax/appmake/raw/master/Makefile

and then

    make project name=yourappid

#### For example...

    jj@im-jj:~/yourappid$ curl -OL --silent http://github.com/jgeewax/appmake/raw/master/Makefile
    jj@im-jj:~/yourappid$ make project name=yourappid
    jj@im-jj:~/yourappid$ 

### Running tests
Note: Crack open `app.yaml` and add some url/script mappings. If you don't you
will see lots of errors about an invalid `app.yaml` file.

    jj@im-jj:~/yourappid$ make test
    INFO     2010-06-12 14:52:00,946 py_zipimport.py:108] zipimporter('/usr/local/lib/python2.6/dist-packages/WebTest-1.2-py2.6.egg', 'webtest/')

    ----------------------------------------------------------------------
    Ran 0 tests in 0.013s

    OK
    jj@im-jj:~/yourappid$ 

### Running the local development server
Note: Inside the Makefile there are some settings such as which port to serve on
and which IP to bind to. The default is `0.0.0.0:9091`, change it as you want.

    jj@im-jj:~/yourappid$ make serve
    INFO     2010-06-12 14:52:58,494 appengine_rpc.py:159] Server: appengine.google.com
    INFO     2010-06-12 14:52:58,498 appcfg.py:349] Checking for updates to the SDK.
    WARNING  2010-06-12 14:52:58,669 datastore_file_stub.py:623] Could not read datastore data from /home/jj/yourappid/datastore
    INFO     2010-06-12 14:52:58,725 dev_appserver_main.py:399] Running application yourappid on port 9091: http://0.0.0.0:9091
    ^CINFO     2010-06-12 14:53:03,967 dev_appserver_main.py:404] Server interrupted by user, terminating

    jj@im-jj:~/yourappid$ 

### Updating code
Note: Make sure to jump into the Makefile and update the e-mail address you want
to deploy with.

    jj@im-jj:~/yourappid$ make update
    Application: yourappid; version: 1.
    Server: appengine.google.com.
    Scanning files on local disk.
    Initiating update.
    Cloning 20 application files.
    Uploading 9 files and blobs.
    Uploaded 9 files and blobs
    Deploying new version.
    Checking if new version is ready to serve.
    Will check again in 1 seconds.
    Checking if new version is ready to serve.
    Will check again in 2 seconds.
    Checking if new version is ready to serve.
    Closing update: new version is ready to start serving.
    Uploading index definitions.
    jj@im-jj:~yourappid$

### Putting it all together
If the tests fail, don't update the code:

    jj@im-jj:~/yourappid$ make test update

### Running a console using the Rempote API
Note: This requires that you have remote_api: on in your app.yaml

    jj@im-jj:~/yourappid# make console
    App Engine remote_api shell
    Python 2.7.2+ (default, Oct  4 2011, 20:06:09) 
    [GCC 4.6.1]
    The db, users, urlfetch, and memcache modules are imported.
    s~yourappid>
