require_relative '../calculator'

describe Calculator do
  
  before :all do
    @calculator = Calculator.new
  end
  
  context '#add' do
    it 'returns 0 adding empty strings' do
      @calculator.add().should == 0
      @calculator.add(nil).should == 0
      @calculator.add('').should == 0
    end

    it 'can add integers correctly' do
      @calculator.add('1').should == 1
      @calculator.add('1, 1').should == 2
      @calculator.add('1, 1, 1').should == 3
    end

    it 'can add floats correctly, even if they are strings' do
      @calculator.add('2.2').should == 2.2
      @calculator.add('2.2, 2.2').should == 4.4
      @calculator.add('2.2, 2.2, 2.2').should == 6.6
    end
  end

end
