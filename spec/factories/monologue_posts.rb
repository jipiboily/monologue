# encoding: UTF-8
FactoryGirl.define do
  factory :post, class: Monologue::Post do
    published true
    association :user
    sequence(:title) { |i| "post title #{i}" }
    content "this is some text with french accents éàöûù and so on...even html tags like <br />"
    sequence(:url) { |i| "post/ulr#{i}" }
    sequence(:published_at) {|i| DateTime.new(2011,1,1,12,0,17) + i.days }
  end

  factory :unpublished_post, class: Monologue::Post, parent: :post do |post|
    published false
    title "unpublished"
    url "unpublished"
  end

  factory :post_with_tags, class: Monologue::Post, parent: :post do |post|
    post.after_create { |p| p.tag!(['Rails', 'a great tag', 'Тест'])}
  end

end
