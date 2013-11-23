require 'uri/http'
require 'open-uri'
require 'journono/wiki_article'

module Journono
  class Wiki

    @@search_api_domain = 'en.wikipedia.org'
    @@search_path = '/w/api.php'

    def self.search(terms)

      articles = Array.new
      terms.each do |term|
        articles = articles | get_results(term)
      end

      puts articles.to_s

    end

    protected
    def self.build_search_url(term)
      uri = URI::HTTP.build(
          {
              :host => @@search_api_domain,
              :path => @@search_path,
              :query => {
                  :action => 'query',
                  :list => 'search',
                  :srsearch => term,
                  :srwhat => 'text',
                  :format => 'xml',
                  :srlimit => 5,
              }.to_query
          }
      )
      uri.to_s
    end

    protected
    def self.get_results(term)
      uri = self.build_search_url term
      results = Nokogiri::XML(open(uri))

      return_array = Array.new
      results.xpath('//query/search/p').each do |article|
        title = article.attribute('title').to_s
        wiki_article = Journono::Wiki::Article.new title
        return_array.append(wiki_article)
      end

      return_array
    end

  end
end