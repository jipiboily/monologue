class AddIndexToTagName < ActiveRecord::Migration
  def change
    add_index :monologue_tags, :name
  end
end
