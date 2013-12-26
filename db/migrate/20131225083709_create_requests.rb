class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :message
      t.references :item, index: true
      t.references :requester, index: true 
      t.references :accepter, index: true
      t.timestamps
    end
  end
end
