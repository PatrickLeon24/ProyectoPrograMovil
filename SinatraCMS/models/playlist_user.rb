require_relative 'base_model'

class PlaylistUser < BaseModel
  set_dataset :playlist_user
  many_to_one :playlists, key: :playlist_id
  many_to_one :users,     key: :user_id
end
