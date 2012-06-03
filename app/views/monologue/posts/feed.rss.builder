xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Monologue.site_name
    xml.description Monologue.meta_description
    xml.link root_url

    for post in @posts
      revision = post.posts_revisions.last
      xml.item do
        xml.title revision.title
        xml.description raw(revision.content)
        xml.pubDate revision.published_at.to_s(:rfc822)
        xml.link Monologue.site_url + revision.full_url
        xml.guid Monologue.site_url + revision.full_url
      end
    end
  end
end