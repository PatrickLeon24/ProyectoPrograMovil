require_relative 'base_model'

class Genre < BaseModel
  set_dataset :genres 
  one_to_many :song_genre, key: :genre_id  

  def validate
    super
    validates_presence :name
    validates_max_length 100, :name
    validates_max_length 500, :description
  end
end
