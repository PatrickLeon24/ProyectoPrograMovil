# user.rb
require_relative 'base_model'

class User < BaseModel
  set_dataset :users

  # Ejemplo de relaciones (añade solo si existen esas tablas y relaciones)
  # one_to_many :posts
  # many_to_many :roles, join_table: :roles_users

  # Validaciones opcionales
  def validate
    super
    errors.add(:name, 'no puede estar vacío') if name.nil? || name.strip.empty?
    errors.add(:username, 'no puede estar vacío') if username.nil? || username.strip.empty?
    errors.add(:email, 'no puede estar vacío') if email.nil? || email.strip.empty?
  end

  # Métodos de ayuda
  def full_name
    "#{name} #{last_name}"
  end

  def verified?
    is_verified == 1
  end
end
