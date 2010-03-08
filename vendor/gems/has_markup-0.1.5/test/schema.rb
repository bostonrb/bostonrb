ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.text :content
    t.text :cached_content_html
  end
end