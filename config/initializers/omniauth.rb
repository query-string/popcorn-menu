Rails.application.config.middleware.use OmniAuth::Builder do

  # @TODO: Remove from repo and history
  provider :facebook, 1421805441432437, 'e64b7d76542f1adcb693228cb9e8a9c1',  {:scope => 'email,read_friendlists,read_mailbox', :client_options => { :ssl => { :ca_path => "/etc/ssl/certs" }}}

end
