class AddNumberToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :number, :integer
  end
end
