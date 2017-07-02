class Datum < ActiveRecord::Base
  serialize :datas
  serialize :results
end
