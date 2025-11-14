require_relative 'base_model'

class UserFollowArtist < BaseModel
  set_dataset :user_follow_artist
  many_to_one :users, key: :user_id
  many_to_one :artists, key: :artist_id
end
