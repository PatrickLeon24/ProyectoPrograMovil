require_relative 'base_model'

class UserAlbum < BaseModel
  set_dataset :user_album

  many_to_one :user,  key: :user_id,  class: :User
  many_to_one :album, key: :album_id, class: :Album
end