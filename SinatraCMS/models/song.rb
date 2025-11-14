require_relative 'base_model'

class Song < BaseModel
  set_dataset :songs

  many_to_many :artists,
               join_table: :song_artist,
               left_key:  :song_id,
               right_key: :artist_id
  many_to_many :genres,
               join_table: :song_genre,
               left_key:  :song_id,
               right_key: :genre_id
  many_to_many :users,
               join_table: :user_song,
               left_key:  :song_id,
               right_key: :user_id
  many_to_many :songs,
               join_table: :album_song,
               left_key:  :album_id,
               right_key: :song_id
  one_to_many  :reviews, key: :song_id

  def validate
    super
    validates_presence :name
    validates_presence :duration
    validates_presence :file_url

    validates_max_length 150, :name
    validates_max_length 255, :file_url
  end  
end
