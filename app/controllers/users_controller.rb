class UsersController < ApplicationController
    before_action :require_current_user!, except: [:create, :new, :index, :show]
    

    def create
        @user = User.new(user_params)
        
        if @user.save
            log_in!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def index
        @users = User.all
        render :index
    end
    
    def show
        @user = User.find_by(id: params[:id])
        @comments = Comment.where(commentable_id: @user.id, commentable_type: "User")
        @goals = Goal.where(user_id: @user.id).includes(:cheers)
        
        render :show
    end

    protected

    def user_params
        self.params.require(:user).permit(:username, :password)
    end
end
