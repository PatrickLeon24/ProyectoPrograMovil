require_relative 'base_model'

class PlaylistUser < BaseModel
  set_dataset :playlist_user
  many_to_one :playlist, key: :playlist_id
  many_to_one :user,     key: :user_id
end
