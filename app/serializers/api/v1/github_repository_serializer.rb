class Api::V1::GithubRepositorySerializer < ActiveModel::Serializer
  attributes :name, :description, :url, :git_url

  ATTRIBUTES_RESPONSE = %i[name description url git_url].freeze

  ATTRIBUTES_RESPONSE.each do |attr|
    define_method attr do
      object[attr]
    end
  end
end
