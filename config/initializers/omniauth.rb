Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, 1421805441432437, 'e64b7d76542f1adcb693228cb9e8a9c1',  {:scope => 'email,read_friendlists,manage_friendlists,publish_stream,offline_access,read_mailbox', :client_options => { :ssl => { :ca_path => "/etc/ssl/certs" }}}

end
