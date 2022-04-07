class LinksController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :link

  authorize_resource

  def destroy
    @link.destroy if current_user&.author?(@link.linkable)
  end

  private

  def link
    @link = Link.find(params[:id])
  end
end
