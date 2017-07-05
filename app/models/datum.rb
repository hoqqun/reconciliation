class Datum < ActiveRecord::Base

  VALID_DATAS_REGEX = /\A[0-9]*(,[0-9]+){1,}\z/
  validates :datas, format: { with: VALID_DATAS_REGEX }
  validates :from, numericality: {only_integer: true}
  validates :to, numericality: {only_integer: true}
  validate :check_length

  belongs_to :user
  
  serialize :datas
  serialize :results

  # リコンサイル処理を行い結果をDBに格納する。
  # リコンサイル処理が重いため、非同期処理ができるようラッパーメソッドにした。
  def reconcileUpdate(rec)
    rec.reconcile
    self.results =  rec.results
    self.save
  end

  def check_length
    
    if datas.split(",").length > 15
      errors.add(:datas, "は処理負荷の問題で、15個以上指定できません。")
    end
  end
end
