class TopController < ActionController::Base
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
    
    def new
        @user = User.new
    end
    
    def create
        uid = params[:user][:uid]
        pass = BCrypt::Password.create(params[:user][:pass])
        @user = User.new(uid: uid, pass: pass)
        @user.save
        redirect_to '/'
    end
    
    def login
        if User.find_by(uid: params[:uid])
            user_code = User.find_by(uid: params[:uid])
            login_pass = user_code.pass
            if BCrypt::Password.new(login_pass) == params[:pass]
                session[:login_uid] = params[:uid]
                redirect_to root_path
            else
                render 'login_failed'
            end
        else
          render 'login_failed'
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
end