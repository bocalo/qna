class LinksController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :link

  def destroy
    if current_user&.author?(@link.linkable)
      @link.destroy
    end
  end

  private

  def link
    @link = Link.find(params[:id])
  end
end
