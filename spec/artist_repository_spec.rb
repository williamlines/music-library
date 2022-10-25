require "artist_repository"

RSpec.describe ArtistRepository do
  
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_artists_table
  end

  it "returns the list of artists" do
    repo = ArtistRepository.new

    artists = repo.all  
    
    expect(artists.length).to eq(3) 
    # expect(artists.first.id).to eq(1)  
    # expect(artist.first.name).to eq('Nirvana')

  end
end



