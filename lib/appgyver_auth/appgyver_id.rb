require 'omniauth'
require 'multi_json'

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class AppgyverId < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.

      def initialize(app, *args, &block)
        #It's a bit silly thing, but allows us to not require APPGYVER_AUTH_URL
        #to be set for things that don't actually need it say you wanted to run
        #some rake tasks etc. you should not need to specify APPGYVER_AUTH_URL
        #just to be able to run `rake -T`.
        if self.class.default_options[:client_options].empty?
          site = ENV['APPGYVER_AUTH_URL']
          raise 'APPGYVER_AUTH_URL not set!' unless site
          self.class.option :client_options, {
            :site =>  site,
            :authorize_url => "#{site}/auth/appgyver_id/authorize",
            :token_url => "#{site}/auth/appgyver_id/access_token",
            :max_redirects => 2
          }
        end
        super
      end

      option :name, "appgyver_id"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :token_options, {
        :param_name => "access_token",
        :mode => :query
      }

      option :authorize_params, {
        :scope => "read"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['uid'] }

      info { raw_info['user_info'] }

      extra { raw_info['extra'] }

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = "access_token"
        @raw_info ||= access_token.get('/auth/appgyver_id/user.json').parsed
      end
    end
  end
end
