class MessagesController < ApplicationController
	def index
		@users = User.where.not(id: current_user.id)
	end
	def create
		@message = Message.new(message_params)
		@message.sender_id = current_user.id
		@message.save
		render json: @message
	end
	def display
		sender_id = current_user.id
		receiver_id = get_params[:id]
		@messages = Messages.where("(sender_id = #{sender_id} AND receiver_id = #{receiver_id}) OR (sender_id = #{receiver_id} AND receiver_id = #{sender_id})").order("created_at ASC")
		render json: @messages
	end
	private
	def message_params
		params.permit(:receiver_id,:content)
	end
	def get_params
		params.permit(:id)
	end
end
