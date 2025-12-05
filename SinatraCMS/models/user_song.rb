require_relative 'base_model'

class UserSong < BaseModel
  set_dataset :user_song
  many_to_one :users, key: :user_id
  many_to_one :songs,     key: :song_id
end
