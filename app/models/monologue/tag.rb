class Monologue::Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true,:presence => true;
  has_and_belongs_to_many :posts,:join_table => :monologue_posts_tags

  def posts_with_tag
    self.posts.published
  end

  def frequency
    posts.size
  end

end
