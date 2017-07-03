class TopController < ApplicationController
  def index
    @datum = Datum.new
  end

  private
    def datum_params
      params.require(:datum).permit(:title, :from, :to, :datas)
    end
end
