require_relative 'base_model'

class Artist < BaseModel
  one_to_many :albums, key: :artist_id
  many_to_many :songs, join_table: :song_artist, left_key: :artist_id, right_key: :song_id

  def validate
    super
    validates_presence :stage_name
    validates_max_length 100, :stage_name
    validates_max_length 250, :biography
    validates_format /\d{4}-\d{2}-\d{2}/, :formed_date
    validates_less_than_or_equal_to Time.now, :formed_date
  end
end
