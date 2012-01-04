class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts do |t|
      t.integer :category_id
      t.integer :post_id
    end
    add_index :categories_posts, :category_id
    add_index :categories_posts, :post_id
  end
end
