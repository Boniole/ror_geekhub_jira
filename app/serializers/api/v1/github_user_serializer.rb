class Api::V1::GithubUserSerializer < ActiveModel::Serializer
  attributes :username, :name, :avatar_url, :url

  ATTRIBUTES_RESPONSE = %i[login name avatar_url url].freeze

  ATTRIBUTES_RESPONSE.each do |attr|
    define_method attr do
      object[attr]
    end
  end

  def username
    object.login
  end
end
