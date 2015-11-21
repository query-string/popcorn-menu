Rails.application.config.middleware.use OmniAuth::Builder do

  # @TODO: Remove from repo and history
  provider :facebook, ENV["FB_ID"], ENV["FB_KEY"],  {:scope => 'email,read_friendlists,read_mailbox', :client_options => { :ssl => { :ca_path => "/etc/ssl/certs" }}}

end
