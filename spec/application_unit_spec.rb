require_relative '../app'

RSpec.describe Application do
  it "can display the menu" do
    io = double(:io)
    music_library = "music_library_test"
    album_repository = double(:album_repository)
    artist_repository = double(:artist_repository)

    app = Application.new(music_library, io, album_repository, artist_repository)
    expect(io).to receive(:puts).and_return("Welcome to the music library manager!")
    expect(io).to receive(:puts).and_return("")
    expect(io).to receive(:puts).and_return("What would you like to do?")
    expect(io).to receive(:puts).and_return(" 0 - Exit the program")
    expect(io).to receive(:puts).and_return(" 1 - List all albums")
    expect(io).to receive(:puts).and_return(" 2 - List all artists")

    app.display_menu
  end
  it "can collect user input" do
    io = double(:io)
    music_library = "music_library_test"
    album_repository = double(:album_repository)
    artist_repository = double(:artist_repository)
    app = Application.new(music_library, io, album_repository, artist_repository)

    allow(io).to receive(:puts).and_return("Enter your choice:")
    allow(io).to receive(:gets).and_return("1")
    expect(app.collect_valid_input).to eq "1"

    allow(io).to receive(:puts).and_return("Enter your choice:")
    allow(io).to receive(:gets).and_return("0")
    expect(app.collect_valid_input).to eq "0"

    allow(io).to receive(:puts).and_return("Enter your choice:")
    allow(io).to receive(:gets).and_return("2")
    expect(app.collect_valid_input).to eq "2"

  end
  it "asks again for input when given invalid number" do
    io = double(:io)
    music_library = "music_library_test"
    album_repository = double(:album_repository)
    artist_repository = double(:artist_repository)
    app = Application.new(music_library, io, album_repository, artist_repository)

    allow(io).to receive(:puts).and_return("Enter your choice:")
    allow(io).to receive(:gets).and_return("3")
    allow(io).to receive(:puts).and_return("Enter your choice:")
    allow(io).to receive(:gets).and_return("1")
    expect(app.collect_valid_input).to eq "1"
  end

  it "prints list of items" do
    io = double(:io)
    music_library = "music_library_test"
    album_repository = double(:album_repository)
    artist_repository = double(:artist_repository)
    app = Application.new(music_library, io, album_repository, artist_repository)

    array = [
      {id: '1', name: "item1"},
      {id: '2', name: "item2"},
      {id: '3', name: "item3"}
    ]

    expect(io).to receive(:puts).and_return("* 1 - item1")
    expect(io).to receive(:puts).and_return('* 2 - item2')
    expect(io).to receive(:puts).and_return("* 3 - item3")
    app.print_list(array, 'name')
  end
end