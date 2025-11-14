require_relative 'base_model'

class Playlist < BaseModel
  set_dataset :playlists

  many_to_many :songs,
               join_table: :playlist_song,
               left_key:  :playlist_id,
               right_key: :song_id
  many_to_many :users,
               join_table: :playlist_user,
               left_key:  :playlist_id,
               right_key: :user_id
  one_to_many :playlist_likes, key: :playlist_id
  one_to_many :playlist_reviews, key: :playlist_id
  
  def validate
    super

    validates_presence :user_id
    validates_presence :name

    validates_max_length 100, :name
    validates_max_length 500, :description if self.description    
  end
end