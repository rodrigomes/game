class AddNumberToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :number, :fixnum
  end
end
