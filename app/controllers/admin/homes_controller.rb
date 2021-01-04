class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, only: [:top]

  def top
  end

end
