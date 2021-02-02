class GoalsController < ApplicationController
    
    def create
        user = User.find_by(id: params[:user_id])
        @goal = Goal.new(goal_params)
        @goal.user_id = user.id

        if @goal.save
            redirect_to user_url(user)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.find_by(id: params[:user_id])
        @goal = Goal.new
        render :new
    end

    def show
        @goal = Goal.find_by(id: params[:id])
        @comments = Comment.where(commentable_id: @goal.id, commentable_type: "Goal")
        
        @user = User.find_by(id: @goal.user_id)
        render :show
    end

    def edit
        @goal = Goal.find_by(id: params[:id])
        render :edit
    end

    def update
        @goal = Goal.find_by(id: params[:id])
        user = User.find_by(id: @goal.user_id)

        if @goal.update(goal_params)
            redirect_to user_url(user)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :edit
        end
    end

    def destroy
        @goal = Goal.find_by(id: params[:id])
        user = User.find_by(id: @goal.user_id)

        if @goal.destroy
            redirect_to user_url(user)
        else
            flash[:errors] = @goal.errors.full_messages
        end
    end

    def flip_progress
        @goal = Goal.find_by(id: params[:id])
        @goal.flip_progress!
        @user = User.find_by(id: @goal.user_id)
        redirect_to(user_url(@user))
    end

    protected

    def goal_params
        self.params.require(:goal).permit(:title, :text, :private, :finished)
    end
end
