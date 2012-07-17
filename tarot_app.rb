# tarot_app.rb 
#
# A Simple Sinatra Tarot card generation application
# To Run:
#   ruby tarot_app.rb
#

require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra' 
require 'haml'

# require 'divination_item'
require_relative 'divination_item'

# Do this only once at startup of app
configure do
    # TODO: Find a better, more "ruby" way to do the below loop.
    # It 1) reads a file, 2) splits on commas 3) create a Divination object
    # 4) puts object into an array
    # NOTE: This must work with BOTH the Win and *Nix CR/LF differences

    tarot_cards = Array.new
    card_ndx = 0
    File.open('tarot.txt', 'r') do |file|
      file.each_line do |line|
        columns = line.split(',')
        tarot_card = DivinationItem.new(card_ndx, columns[0], columns[1].chomp, columns[2].chomp)
	    tarot_cards << tarot_card
	    card_ndx += 1
      end
    end

  # set a global value. We can retrive this using settings.tarot_deck
  set :tarot_deck, tarot_cards
end

# Helper method to be called in index.haml
helpers do

  # helper methods
  def generate_random_card_id() 
    tarot_cards = settings.tarot_deck  
    random_card_ndx = rand(tarot_cards.length) 
  end 
  
  def select_tarot_card(random_card_ndx) 
    tarot_cards = settings.tarot_deck

    # generate a display string and set it so the "get" can see it
    tarot_text = "Your tarot card for the day is " +
      tarot_cards[random_card_ndx].name + ".  Keywords are: " + 
      tarot_cards[random_card_ndx].meaning + "."
  end 

  def select_tarot_card_image(random_card_ndx) 
    tarot_cards = settings.tarot_deck
    image_name = tarot_cards[random_card_ndx].image
  end 
  
end

# HTTP 'Get'
get '/' do 
  haml :index
end

get '/about' do
  haml :about
end
