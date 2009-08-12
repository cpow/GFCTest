# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gfcTest_session',
  :secret      => 'ce5e72f71cf01a3af06be6cbeb6a77d77ea3de365f00969f42257e65660c165b2ddf43265be21688a8c743001f37547f3e474927624225860777fff4f4631bbe'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
