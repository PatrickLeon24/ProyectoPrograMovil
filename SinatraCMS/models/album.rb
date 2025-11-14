require_relative 'base_model'

class Album < BaseModel
  set_dataset :albums

  many_to_one :artist, key: :artist_id

  many_to_many :songs,
               join_table: :album_song,
               left_key:  :album_id,
               right_key: :song_id

  def validate
    super
    validates_presence :name
    validates_presence :artist_id

    validates_max_length 150, :name 
  end
end