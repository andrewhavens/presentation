require_relative 'dsl'

class Presentation
  class SlideDeck

    def initialize
      @current_slide = 0
      @slides = []
    end

    def current_slide
      @slides[@current_slide]
    end

    def previous_slide
      @current_slide -=1 unless @current_slide == 0
    end

    def next_slide
      @current_slide += 1 unless @current_slide == @slides.count - 1
    end

    def load_slides_from_file(filename)
      source = File.read(filename)
      dsl = SlidesDSL.new
      dsl.instance_eval(source, filename, 0)
      @slides = dsl.slides
    end

  end
end