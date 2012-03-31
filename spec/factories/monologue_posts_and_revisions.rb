# encoding: UTF-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Monologue::Post do
#    id 1
    published true
#    posts_revision_id 1
#    association :posts_revisions, factory: :posts_revision
  end
  
  factory :posts_revision, class: Monologue::PostsRevision do
#    sequence(:id) {|i| i }
    title "my title"
    content "this is some text with french accents éàöûù and so on...even html tags like <br />"
    url "/monologue/my/url"
    user_id 1
#    association :posts, factory: :post
#    post_id 1
    sequence(:published_at) {|i| "2012-01-20 14:38:#{i}" }
  end
end