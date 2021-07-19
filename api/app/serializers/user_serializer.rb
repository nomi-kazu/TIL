class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :image, :confirmed_at, :update_at
end
