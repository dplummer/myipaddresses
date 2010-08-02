# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_myipaddresses_session',
  :secret      => '1140aee4565a48aeeee25bfa2cd4a06e6c5da5e9407a7aa3d57993ebf54b24200c14364c5f39d39e63747b06cf613ee771a33103fa4b46f7061d832a13be43b6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
