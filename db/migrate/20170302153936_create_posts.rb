class CreatePosts < ActiveRecord::Migration[5.0]
  def change
  	create_table :posts do |p|
  		p.text :author
  		p.text :text

  		p.timestamps
  	end
  end
end
