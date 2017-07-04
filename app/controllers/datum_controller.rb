class DatumController < ApplicationController
  before_action :authenticate_user!

  def index
    @datums = Datum.where(user_id: current_user.id).order(id: :DESC).page(params[:page])
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

  def new
    @datum = Datum.new
  end

  def create
    @datum = Datum.new(datum_params)
    @datum.user_id = current_user.id
    @rec = Reconcile.new(@datum.datas.split(",").map{ |str| str.to_i },@datum.from.to_i,@datum.to.to_i)
    if @datum.save
      @datum.delay.reconcileUpdate(@rec)
      redirect_to datum_index_path, notice: "計算登録完了しました。"
    else
      render 'new'
    end

  end

  private
    def datum_params
      params.require(:datum).permit(:title, :from, :to, :datas)
    end
end
