class TopController < ApplicationController
  def index
    @datum = Datum.new
  end

  def create
    @datum = Datum.new(datum_params)
    
  end

  private
    def datum_params
      params.require(:datum).permit(:title, :from, :to, :datas)
    end
end
