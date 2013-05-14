class MigrateOldUrls < ActiveRecord::Migration
  def up
    return unless class_exists?('Monologue::PostsRevision')
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

  private
  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
end
