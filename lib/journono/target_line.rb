module Journono

  class TargetLine

    def self.build_list(source, body)
      results = Array.new

      lines = body.split(/((?<=[a-z0-9)][.?!])|(?<=[a-z0-9][.?!]"))\s+(?="?[A-Z])/)

      lines.each do |line|
        target = self.new source, line
        results.insert target
      end

      results
    end

    def initialize(source, text)
      @source = source
      @text = text
    end

  end

end