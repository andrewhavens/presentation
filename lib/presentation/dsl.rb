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

    def code(language, text, line_numbers: true)
      options = {}
      options[:line_numbers] = :inline if line_numbers
      html = CodeRay.scan(text, language).span(options)

      # remove unsupported properties
      html.gsub! '<span class="CodeRay">', ''
      html.gsub! /<\/span>\z/, '' # closing .CodeRay tag
      html.gsub! /font-weight:bold/, ''

      # convert inline styles to Gosu compatible color tags
      html.gsub! /<span style="background-color:hsla.*?">/, '<c=FFFFFF>'
      html.gsub! /<span class="line-numbers">(?<space> )?(<strong>)?<a href="#n\d+?" name="n\d+?">(?<number>\d+?)<\/a>(<\/strong>)?(<\/span>)?/, '\k<space>\k<number> '
      html.gsub! /<span style="color:#([0-9a-fA-F]{3});?">/ do |m|
        color = $1.chars.map{|s|s*2}.join
        "<c=#{color}>"
      end
      html.gsub! '</span>', '</c>'
      html.gsub! '&quot;', '"'

      slide.code = html
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