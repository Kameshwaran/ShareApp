class Item < ActiveRecord::Base

  belongs_to :user
  mount_uploader :image, ImageUploader
 	searchable  do
 		text :name,:desc
 	end
 	def self.add(hash)
  	item = Item.new(hash)
  	item.save
  end
  
  def modify!(hash)
  	item = Item.find(self.id)
  	if item.update(hash)
  		true
  	else
  		raise "Invalid Inputs"
  	end
  end

  def delete!
  	item = Item.find(self.id)
  	if item.destroy
  		true
  	else
  		raise "Item cannot be Deleted"
  	end
  end

end
