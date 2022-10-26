require_relative "./album"

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      album.artist_id = record["artist_id"]
    
      albums << album
    end
    return albums
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    album = Album.new
    result = result_set[0]

    album.id = result["id"]
    album.title = result["title"]
    album.release_year = result["release_year"]
    album.artist_id = result["artist_id"]

    return album
  end
  def create(album)
    sql = 'INSERT INTO albums (title, release_year) VALUES($1, $2);'
    params = [album.title, album.release_year]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end
  def delete(id)
    sql = 'DELETE FROM albums WHERE id = $1'
    params = [id]
    
    DatabaseConnection.exec_params(sql, params)
    return nil

  end
  def update(album)
    sql = 'UPDATE albums SET title = $1, release_year = $2 WHERE id = $3;'
    params = [album.title, album.release_year, album.id]
    
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end