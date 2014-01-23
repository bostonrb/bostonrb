class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_uid, null: false
      t.string :name, null: false
      t.string :display_name

      t.timestamps
    end
    add_index "users", ["github_uid"], name: "index_users_on_github_uid", unique: true, using: :btree
  end
end
