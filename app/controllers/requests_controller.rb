class RequestsController < ApplicationController
	def create
  	Request.add(request_params) 
  	redirect_to user_requests_path(current_user)
	end

	def new
		@search_item = Item.find(item_params[:item_id].to_i)
		@accepter = @search_item.user
	end

	def index
		@requests = Request.where(accepter_id: current_user.id,status: true)
		@accepted_requests= Request.where(requester_id: current_user.id, status: false)
	end

	def accept
		request = Request.find(params[:request_id])
		request.accept!
		redirect_to user_requests_path(current_user)
	end

	def destroy
  	request = Request.find(params[:id])
  	request.delete!
  	redirect_to user_requests_path(current_user)
	end
	private
	def request_params
		params.require(:request).permit(:message,:item_id,:requester_id,:accepter_id,:status)
	end
	def item_params
		params.require(:item).permit(:item_id)
	end
end
