class InvitationsController < ApplicationController
	before_action :set_invitation, only: [:destroy]


	def show
	    @friendships = current_user.friendships.all
	    @friends = Array.new
	    @friendships.each do |friendship|
	      @friend = Hash.new
	      @friend[:avatar] = User.find(friendship.friend_id).avatar.url(:thumb)
	      @friend[:friend] = User.find(friendship.friend_id).name
	      @friend[:id] = friendship.id
	      @friends.push(@friend)
	    end
	    @friends
	    @order
    	@groups=current_user.groups.all  
  	end

	def destroy
	  if @invitation.order.user_id == current_user.id
	    @invitation.destroy
	      render json: { error: false, res: "invitation was successfully cancelled."}
	  else
	    if user_signed_in?
	     render json: { error: true, res: "Only Owner Who Can Delete The Order"}
	    else
	      redirect_to new_user_session_path
	    end
	  end
	end


	private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_invitation
	      @invitation = Invitation.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def order_params
	      params.require(:order).permit(:menu, :mtype, :restaurant, :user_id)
	    end
end
