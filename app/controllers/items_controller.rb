class ItemsController < ApplicationController
	
	def create
  	Item.add(item_params) 
  	redirect_to user_items_path(current_user)
	end

	def index
		@items = Item.where(user_id: current_user.id)
	end

	def search
		@search = Item.search do 
			fulltext params[:search]
		end
		@items = @search.results
	end

	def view
		@item = Item.find(params[:item_id])
	end
	
	def edit
		@item = Item.find(params[:id])
	end
	def update
		item = Item.find(params[:id])
		item.modify!(item_params)
		redirect_to user_items_path(current_user)
	end

	def destroy
  	item = Item.find(params[:id])
  	item.delete
  	redirect_to user_items_path(current_user)
	end
	private
	def item_params
		params.require(:item).permit(:name,:desc,:image,:user_id)
	end
end
