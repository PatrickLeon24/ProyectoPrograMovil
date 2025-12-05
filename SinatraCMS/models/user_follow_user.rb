require_relative 'base_model'

class UserFollowUser < BaseModel
  set_dataset :user_follow_user

  many_to_one :user,       key: :user_id, class: :User
  many_to_one :followed,   key: :followed_id, class: :User
end