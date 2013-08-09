class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :monologue_taggings do |t|
      t.integer :post_id, :tag_id
    end

    add_index :monologue_taggings, :post_id
    add_index :monologue_taggings, :tag_id

  end
end
