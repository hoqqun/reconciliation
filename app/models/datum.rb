class Datum < ActiveRecord::Base
  serialize :datas
  serialize :results

  def reconcileUpdate(rec)
    rec.reconcile
    self.results =  rec.results
    self.save
  end
end
