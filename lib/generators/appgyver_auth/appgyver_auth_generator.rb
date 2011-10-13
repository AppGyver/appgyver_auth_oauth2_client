module AppgyverAuth
  module Generators
    class AppgyverAuthGenerator < Rails::Generators::Base
      namespace "appgyver_auth"

      source_root File.expand_path('../templates', __FILE__)

      def add_auth_routes
        auth_routes = <<-EOROUTES

  # omniauth
  match '/auth/:provider/callback', :to => 'appgyver_auth/user_sessions#create'
  match '/auth/failure', :to => 'appgyver_auth/user_sessions#failure'

  # Custom logout
  match '/logout', :to => 'appgyver_auth/user_sessions#destroy'

EOROUTES

        route auth_routes
      end

      def add_auth_initializer
        initializer "appgyver_auth.rb", <<-EOINITIALIZER
# Add the AppGyver Service ID and secret here
APP_ID = '123123'
APP_SECRET = '123123'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :appgyver_id, APP_ID, APP_SECRET
end
EOINITIALIZER
      end

      def copy_session_controller
        copy_file "user_sessions_controller.rb", "app/controllers/appgyver_auth/user_sessions_controller.rb"
      end
    end
  end
end
