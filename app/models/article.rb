require 'journono/page_fetcher'
require 'journono/wiki'
require 'journono/target_line'

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
    fetch = Journono::PageFetcher.new self.url
    body = fetch.get_content_body site.content_container
    keywords = extract_keywords body
    related_wiki_articles = Journono::Wiki.search keywords
  end

  protected
  def extract_keywords(body)
    rank = Highscore::Content.new body
    rank.configure do
      set :multiplier, 3
      set :long_words, 5
      set :long_words_threshold, 8
      set :short_words_threshold, 3
      set :ignore_case, true
    end

    search_terms = Array.new

    rank.keywords.top(10).each do |keyword|
      search_terms = search_terms.append keyword.text
    end

    search_terms
  end


end
