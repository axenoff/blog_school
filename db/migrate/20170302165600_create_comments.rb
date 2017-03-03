class CreateComments < ActiveRecord::Migration[5.0]
  def change
  	create_table :comments do |p|
  		p.belongs_to :post, index: true
  		p.text :author
  		p.text :text

  		p.timestamps
  	end
  end
end
