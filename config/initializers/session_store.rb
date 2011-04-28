# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sitecheck_session',
  :secret      => '57d990f98d6b45e32d74e9668b20e886c073b9c933aeb2398c7ab07fbdda426ab375f058c10b5916e03b292119ee1214cbc3ca6a6f52c01fa26dedc647504c62'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
