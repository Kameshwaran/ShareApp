class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :desc
      t.string :image
      t.references :user, index: true

      t.timestamps
    end
  end
end
