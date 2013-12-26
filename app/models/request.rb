class Request < ActiveRecord::Base

  belongs_to :item
  belongs_to :requester, class_name: "User"
  belongs_to :accepter, class_name: "User"

  def self.add(hash)
  	request = Request.new(hash)
  	request.save
  end

  def delete!
  	request = Request.find(self.id)
  	if request.destroy
  		true
  	else
  		raise "Item cannot be deleted."
  	end
  end

  def modify!(message)
  	request = Request.find(self.id)
  	request.message = message
  	if request.save
  		true
  	else
  		raise "Invalid inputs"
  	end
  end

  def accept!
  	request = Request.find(self.id)
  	request.status = false
  	request.save
  end
end
