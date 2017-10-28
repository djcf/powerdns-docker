import os
basedir = os.path.abspath(os.path.dirname(__file__))

# BASIC APP CONFIG
WTF_CSRF_ENABLED = True
SECRET_KEY = os.environ['SECRET_KEY']
BIND_ADDRESS = '0.0.0.0'
PORT = 8080
LOGIN_TITLE = "PDNS"

# TIMEOUT - for large zones
TIMEOUT = 10

# LOG CONFIG
LOG_LEVEL = 'DEBUG'
# LOG_FILE = 'logfile.log'
# For Docker, leave empty string
LOG_FILE = ''

# Upload
#UPLOAD_DIR = os.path.join(basedir, 'upload')
UPLOAD_DIR = "/data/uploads"

# DATABASE CONFIG
#You'll need MySQL-python
# SQLA_DB_USER = 'powerdnsadmin'
# SQLA_DB_PASSWORD = 'powerdnsadminpassword'
# SQLA_DB_HOST = 'mysqlhostorip'
# SQLA_DB_NAME = 'powerdnsadmin'

#MySQL
# SQLALCHEMY_DATABASE_URI = 'mysql://'+SQLA_DB_USER+':'\
    # +SQLA_DB_PASSWORD+'@'+SQLA_DB_HOST+'/'+SQLA_DB_NAME
#SQLite
SQLALCHEMY_DATABASE_URI = 'sqlite:////data/padmin.sqlite'
SQLALCHEMY_MIGRATE_REPO = os.path.join(basedir, 'db_repository')
SQLALCHEMY_TRACK_MODIFICATIONS = True

if "LDAP_TYPE" in os.environ:
	# LDAP CONFIG
	LDAP_TYPE = os.environ['LDAP_TYPE']
	LDAP_URI = 'ldap://ldap/'
	LDAP_USERNAME = os.environ['LDAP_USERNAME']
	LDAP_PASSWORD = os.environ['LDAP_PASSWORD']
	LDAP_SEARCH_BASE = os.environ['LDAP_SEARCH_BASE']
	# # Additional options only if LDAP_TYPE=ldap
	LDAP_USERNAMEFIELD = os.environ.get('LDAP_USERNAMEFIELD', 'uid')
	LDAP_FILTER = os.environ.get('LDAP_USERNAMEFIELD', '(objectClass=inetorgperson)')

	## You may prefer 'userPrincipalName' instead
	#LDAP_USERNAMEFIELD = 'sAMAccountName'
	## AD Group that you would like to have accesss to web app

# Github Oauth
GITHUB_OAUTH_ENABLE = os.environ.get('GITHUB_OAUTH_ENABLE', False)
if GITHUB_OAUTH_ENABLE:
	GITHUB_OAUTH_KEY = os.environ['GITHUB_OAUTH_KEY']
	GITHUB_OAUTH_SECRET = os.environ['GITHUB_OAUTH_SECRET']
	GITHUB_OAUTH_SCOPE = os.environ['GITHUB_OAUTH_SCOPE']
	GITHUB_OAUTH_URL = os.environ['GITHUB_OAUTH_URL']
	GITHUB_OAUTH_TOKEN = os.environ['GITHUB_OAUTH_TOKEN']
	GITHUB_OAUTH_AUTHORIZE = os.environ['GITHUB_OAUTH_AUTHORIZE']

#Default Auth
BASIC_ENABLED = False
SIGNUP_ENABLED = False

# POWERDNS CONFIG
PDNS_STATS_URL = 'http://master/api/v1/'
PDNS_API_KEY = os.environ['API_KEY']
PDNS_VERSION = '4.0.3'

# RECORDS ALLOWED TO EDIT
RECORDS_ALLOW_EDIT = ['A', 'SOA', 'AAAA', 'CNAME', 'SPF', 'PTR', 'MX', 'TXT']

# EXPERIMENTAL FEATURES
PRETTY_IPV6_PTR = False
