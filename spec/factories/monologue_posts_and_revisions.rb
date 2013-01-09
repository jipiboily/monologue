# encoding: UTF-8
FactoryGirl.define do
  factory :post, class: Monologue::Post do
    published true
    association :user
  end

  factory :posts_revision, class: Monologue::PostsRevision do
    sequence(:title) { |i| "post #{i} | revision 1" }
    content "this is some text with french accents éàöûù and so on...even html tags like <br />"
    sequence(:url) { |i| "post/#{i}" }
    association :post
    sequence(:published_at) {|i| DateTime.new(2011,1,1,12,0,17) + i.days }
  end

  factory :unpublished_post, class: Monologue::Post, parent: :post do |post|
    published false
    post.after_create { |p| Factory(:posts_revision, post: p, title: "unpublished", url: "unpublished") }
  end

  factory :post_with_multiple_revisions, class:  Monologue::Post, parent: :post do |post|
    post.after_create { |p| Factory(:posts_revision, post: p, title: "post X | revision 1", url: "post/x") }
    post.after_create { |p| Factory(:posts_revision, post: p, title: "post X | revision 2", url: "post/x") }
  end

  factory :post_with_tags, class: Monologue::Post, parent: :post_with_multiple_revisions do |post|
    post.after_create { |p| p.tag!(['rails', 'a great tag'])}
  end

end