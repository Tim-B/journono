module Journono
  class PageFetcher

    def initialize(page)
      @agent = Mechanize.new { |agent|
        agent.user_agent_alias = 'Windows IE 9'
      }
      @page = @agent.get page
    end

    def get_content_body(body_class)
      text = ''
      @page.search('.story-body p').each do |para|
        text = text + para.inner_text
      end

      rank = Highscore::Content.new text
      rank.configure do
        set :multiplier, 3
        set :long_words, 5
        set :long_words_threshold, 8
        set :short_words_threshold, 3
        set :ignore_case, true
        set :word_pattern, /[\w]+[^\s0-9]/ # => default: /\w+/
      end

      rank.keywords.top(10).each do |keyword|
        puts keyword.text + ' : ' + keyword.weight.to_s
      end

    end

  end
end