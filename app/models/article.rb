require 'journono/page_fetcher'

class Article
  include Dynamoid::Document

  field :title
  field :published, :datetime
  field :url
  field :rating, :integer
  field :analysed, :boolean

  belongs_to :site

  def analyse
    self.url = 'http://www.couriermail.com.au/news/queensland/queensland-premier-campbell-newman-threatened-in-viral-video-apparently-posted-by-hacker-group-anonymous/story-fnihsrf2-1226752216235'
    fetch = Journono::PageFetcher.new(self.url)
    fetch.get_content_body(self.site.content_container)

  end


end
