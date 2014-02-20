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
    
    it 'can add all sorts of numbers' do 
      numbers = [1,2,3,4,5]
      @calculator.add(numbers.join(',')).should == numbers.inject(:+)
    end

   it 'cannot add negative numbers' do
     expect { @calculator.add("-1,4")  }.to raise_error(ArgumentError, /-1/)
     expect { @calculator.add("-1,-5") }.to raise_error(ArgumentError, /-1,-5/)
   end

   context 'with a new delimiter' do

      before :each do
        @calculator.delimiters = [",", "\n"]
      end

      after :each do 
        @calculator.delimiters = Calculator::DEFAULT_DELIMITERS
      end

      it 'can handle multiple delimiters' do 
        @calculator.add("1\n2,3").should == 6
      end

      it 'rejects malformed delimitation' do
        expect { @calculator.add("1,\n") }.to raise_error(ArgumentError)
        expect { @calculator.add("1\n,") }.to raise_error(ArgumentError)
      end
    end

    it 'can accept delimiters in the input with ^//' do
      @calculator.add("//;\n1;2").should == 3
    end


  end

end
