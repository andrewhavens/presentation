require 'pry'
require 'gosu'

require_relative 'presentation/slide_deck'
require_relative 'presentation/window'

class Presentation

  def slide_deck
    @slide_deck ||= SlideDeck.new
  end

  def load_slides_from_file(filename)
    slide_deck.load_slides_from_file(filename)
  end

  # TODO: Implement something like this
  # def load_theme(filename)
  #   source = File.read(filename)
  #   @theme = Theme.new.parse(source, filename, 0)
  # end

  def start
    @window = Window.new(slide_deck)
    @window.show
  end

end