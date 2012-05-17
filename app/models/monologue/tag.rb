class Monologue::Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true,:presence => true;
  has_and_belongs_to_many :posts_revisions

end
