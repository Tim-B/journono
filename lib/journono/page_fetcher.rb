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
      text
    end

  end
end