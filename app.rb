# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    display_menu
    input = collect_valid_input
    if input == '1'
      albums = @album_repository.all
      print_list(albums, 'title')
    elsif input == '2'
      albums = @artist_repository.all
      print_list(albums, 'name')
    else
    end
  end
  def display_menu
    @io.puts "Welcome to the music library manager!"
    @io.puts ""
    @io.puts "What would you like to do?"
    @io.puts " 0 - Exit the program"
    @io.puts " 1 - List all albums"
    @io.puts " 2 - List all artists"
  end
  def collect_valid_input
    while true do
      @io.puts "Enter your choice:"
      input = @io.gets.chomp
      
      return input if ['1', '2', '0'].include?(input) 
    end
  end
  def print_list(items, column)
    result_array = []
    items.each_with_index do |item, index|
      result_array << "* #{index + 1} - #{item.send("#{column}")}"
    end
    puts result_array.join("\n")
  end




end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
