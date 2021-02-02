class CheersController < ApplicationController
    before_action :require_current_user!
    before_action :require_remaining_cheer_to_give!

    def new
        if @goal = Goal.find_by(id: params[:goal_id])
            @cheer = Cheer.new
            @cheer.user_id = current_user.id
            @cheer.goal_id = @goal.id
            if @cheer.save
                current_user.cheers_to_give_counter -= 1
                current_user.save
                
                redirect_to user_url(@goal.user_id)
            else
                flash[:errors] = @cheer.errors.full_messages
                redirect_to user_url(@goal.user_id)
            end
        else
            redirect_to root_url
        end
    end

end
