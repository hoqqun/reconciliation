class DatumController < ApplicationController

  def index
    @datums = Datum.all
  end

  def show
    @datum = Datum.find(params[:id])

    respond_to do |format|
      format.html
      format.csv do
        filename = @datum.id.to_s + ":" + @datum.title
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      end
    end
    
  end


  def create
    @datum = Datum.new(datum_params)
    @rec = Reconcile.new(@datum.datas.split(",").map{ |str| str.to_i },@datum.from.to_i,@datum.to.to_i)
    @datum.save
    @datum.delay.reconcileUpdate(@rec)

    redirect_to root_path, notice: "計算登録完了しました。"

  end

  private
    def datum_params
      params.require(:datum).permit(:title, :from, :to, :datas)
    end
end
