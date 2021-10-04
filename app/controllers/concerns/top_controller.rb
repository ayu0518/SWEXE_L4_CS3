class TopController < ActionController::Base
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
    
    def login
        if params[:uid] == 'kindai' and params[:pass] == 'sanriko'
          session[:login_uid] = params[:uid]
          redirect_to root_path
        else
          render 'login_failed'
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
end