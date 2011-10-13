module AppgyverAuth
  module ControllerAdditions
    def login_required
      if !current_user_id
        respond_to do |format|
          format.html  {
            redirect_to '/auth/appgyver_id'
          }
          format.json {
            render :json => { 'error' => 'Access Denied' }.to_json
          }
        end

        return false
      end
    end

    def current_user_id
      session[:user_id]
    end

    def current_user_details
      session[:user_details]
    end

    def current_user
      @user ||= User.find(current_user_id)
    end
  end
end

if defined? ActionController
  ActionController::Base.class_eval do
    include AppgyverAuth::ControllerAdditions
  end
end
