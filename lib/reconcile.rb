class Reconcile

  attr_accessor :test_data
  attr_accessor :from
  attr_accessor :to
  attr_reader   :flux
  attr_reader   :results
  def initialize(test_data,from,to)
    @test_data = test_data
    @from = from
    @to = to
    @results = []

    calculateflux
  end

  def calculateflux
    @flux = @to - @from
  end

  def reconcile
    result = 0
    createPtns(@test_data).each do |ptn|
      createFormula(ptn).each do |formula|
        result = 0
        temp_formula = formula.split("")
        temp_ptn = ptn.dup
        temp_formula.each do |op|
          if op == "0"
            result = result + temp_ptn.first
          elsif op == "1"
            result = result - temp_ptn.first
          end
          temp_ptn.shift
        end
        if result == @flux
          @results << temp_formula.join.gsub("1","-").gsub("0","+").split("").zip(ptn).join
        end
      end
    end
  end

  private

    def createFormula(test_data)
      first_formula = "".rjust(test_data.length,"0")
      end_formula = "".rjust(test_data.length,"1")
      current_formula = first_formula
      formulas = []

      while current_formula.length <= end_formula.length
        formulas << current_formula
        current_formula = addBinaryOne(current_formula)
      end
      
      formulas

    end

    def createPtns(test_data)
      test_ptns = []

      createFormula(test_data).each do |formula|
        formula = formula.split("")
        temp_data = []
        test_data.each do |n|
          if formula.first == "1"
            temp_data << n
          end
          formula.shift
        end
        test_ptns << temp_data
      end
      test_ptns.shift
      test_ptns
    end

    def addBinaryOne(binary)
      (binary.to_i(2) + 1).to_s(2).rjust(binary.length,"0")
    end

end