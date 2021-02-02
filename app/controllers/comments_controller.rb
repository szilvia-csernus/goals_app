class CommentsController < ApplicationController
    before_action :require_current_user!
    
    def create
        if params.has_key?(:user_id)
            user = User.find_by(id: params[:user_id])
            @comment = Comment.new(comment_params)
            @comment.user_id = current_user.id
            @comment.commentable_id = user.id
            @comment.commentable_type = "User"

            if @comment.save
                redirect_to user_url(user)
            else
                flash.now[:errors] = @comment.errors.full_messages
                redirect_to user_url(user)
            end

        elsif params.has_key?(:goal_id)

            goal = Goal.find_by(id: params[:goal_id])
            @comment = Comment.new(comment_params)
            @comment.user_id = current_user.id
            @comment.commentable_id = goal.id
            @comment.commentable_type = "Goal"

            if @comment.save
                redirect_to goal_url(goal)
            else
                flash[:errors] = @comment.errors.full_messages
                redirect_to goal_url(goal)
            end
        else
            redirect_back(fallback_location: root_url)
        end
    end


    protected

    def comment_params
        self.params.require(:comment).permit(:text)
    end
    
end
