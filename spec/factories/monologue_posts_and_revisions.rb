# encoding: UTF-8
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Monologue::Post do
    id 1
    url "/my/post/url"
    published true
    posts_revision_id 1
  end
  
  factory :posts_revision, class: Monologue::PostsRevision do
    sequence(:id) {|i| i }
    title "my title"
    content "this is some text with french accents éàöûù and so on...even html tags like <br />"
    url "/my/url"
    user_id 1
    post_id 1
    published_at "2012-01-20 14:38:58"
  end
end