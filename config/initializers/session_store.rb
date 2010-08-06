# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SKYS_Database_session',
  :secret      => '2cee72172ea647ab68062752589cb2a88639141a100ef562985fda906c8100c6ee9ec480397568dc22a43275381b8041966f33f55999e9a10c5c3651054b4559'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
