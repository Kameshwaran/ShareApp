class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender,index:true
      t.references :receiver, index: true

      t.timestamps
    end
  end
end
