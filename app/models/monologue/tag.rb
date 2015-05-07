class Monologue::Tag < ActiveRecord::Base
  validates :name, uniqueness: true,presence: true
  has_many :taggings
  has_many :posts,through: :taggings

  def posts_with_tag
    self.posts.published
  end

  def self.with_frequency
    self
      .select("name, COUNT(*) as frequency")
      .joins("INNER JOIN monologue_taggings ON monologue_taggings.tag_id = monologue_tags.id")
      .joins("INNER JOIN monologue_posts    ON monologue_posts.id        = monologue_taggings.post_id")
      .where("monologue_posts.published = 't'")
      .group("name")
      .having("COUNT(*) > 0")
  end

  def frequency
    self.attributes["frequency"].nil? ? posts_with_tag.size : self.attributes["frequency"].to_i
  end
  
end
