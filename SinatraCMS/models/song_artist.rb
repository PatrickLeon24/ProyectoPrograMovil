require_relative 'base_model'

class SongArtist < BaseModel
  set_dataset :song_Artist
  many_to_one :songs, key: :song_id
  many_to_one :artists,     key: :artist_id
end
