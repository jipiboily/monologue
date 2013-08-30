class MigrateOldUrls < ActiveRecord::Migration
  class Monologue::PostsRevision < ActiveRecord::Base
  end

  def up
    mount_point = Monologue::Engine.routes.url_helpers.root_path
    Monologue::PostsRevision.all.each do |r|
      next if r.url.nil?
      r.url = r.url.sub(mount_point, "")
      r.save!
    end
  end

  def down
    mount_point = Monologue::Engine.routes.url_helpers.root_path
    Monologue::PostsRevision.all.each do |r|
      next if r.url.nil?
      r.url = mount_point + r.url
      r.save!
    end
  end
end
