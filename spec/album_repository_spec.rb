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
  it " create function" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = "OK Computer"
    album.release_year = '1997'

    repo.create(album)
    albums = repo.all
    last_album = albums.last

    expect(last_album.title).to eq "OK Computer"
    expect(last_album.release_year).to eq '1997'

  
  end
  it "deletes" do
    repo = AlbumRepository.new
    repo.delete(1)
    albums = repo.all
    album_first = albums.first
    expect(album_first.id).to eq ('2')
  end
  it "updates" do
    repo = AlbumRepository.new
    
    album = repo.find(1)

    album.title = 'changed'
    album.release_year = '2000'

    repo.update(album)

    updated_album = repo.find(1)

    expect(updated_album.title).to eq 'changed'
    expect(updated_album.release_year).to eq '2000'
  end
end