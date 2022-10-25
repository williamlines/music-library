require "album_repository"

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  


  before(:each) do
    reset_albums_table
  end
  
  it "all" do
    repo = AlbumRepository.new

    albums = repo.all
    expect(albums.length).to eq 3

    expect(albums[0].id).to eq('1')
    expect(albums[0].title).to eq('Doolittle')
    expect(albums[0].release_year).to eq('1989')
  end
  it "find" do
    repo = AlbumRepository.new

    album = repo.find(1)

    expect(album.id).to eq('1')
    expect(album.title).to eq('Doolittle')
    expect(album.release_year).to eq('1989')

    album = repo.find(2)

    expect(album.id).to eq('2')
    expect(album.title).to eq('Surfer Rosa')
    expect(album.release_year).to eq('1988')
  end
end