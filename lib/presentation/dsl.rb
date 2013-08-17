require_relative 'slide'

class Presentation
  class SlidesDSL

    attr_reader :slides

    def slides
      @slides ||= []
    end

    def slide(type = nil, &block)
      if type and type.is_a? Class
        s = type.new
        s.instance_eval(&block)
        slides << s
      else
        s = SlideDSL.new
        s.instance_eval(&block)
        slides << s.slide
      end
      # FIXME: why doesnt this work?
      # s = Slide.new
      # s.instance_eval &block
      # slides << s
    end

  end

  class SlideDSL
    def slide
      @slide ||= Slide.new
    end

    def method_missing(method, *args, &block)
      if method =~ /(.*)_code$/
        code($1, *args, &block)
      else
        slide.send("#{method}=", *args, &block)
      end
    end

    def code(language, text)
      # TODO: find/create some sort of Gosu compatible syntax highlighter
      slide.code = text
    end

    def bullet(bullet)
      slide.list ||= []
      slide.list << bullet
    end
    alias_method :b, :bullet
  end

  # TODO: Implement something like this maybe?
  # class Theme < SomeStylesheetLibrary
  #   allow_styles_for :slide do
  #     type :container
  #     include Padding
  #     include Background
  #   end

  #   allow_styles_for :title, :subtitle do
  #     type :text
  #     include Positioning
  #     include Text
  #   end

  #   allow_styles_for :bullet do
  #     type :text
  #     include Positioning
  #     include Text
  #   end
  # end

end