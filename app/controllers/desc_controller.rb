class DescController < ApplicationController

  def index
    return Desc.all
  end

end
