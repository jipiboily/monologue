class CreateMonologueTags < ActiveRecord::Migration
  def change
    create_table :monologue_tags do |t|
      t.string :name

    end
  end
end
