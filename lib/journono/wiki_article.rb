require 'open-uri'

module Journono
  class Wiki
    class Article

      @url_base = 'http://en.wikipedia.org/wiki/'

      def initialize(title)
        @title = title
      end

      def eql?(other)
        self.title == other.title
      end


      def to_s
        self.title
      end

      def title
        @title
      end

    end
  end
end