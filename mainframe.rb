require 'readline'
require 'coderay'

class MainFrameTerminal
  def initialize
    @line = 1
  end

  def run
    puts "Welcome to Dunder Mifflin. Please type a command"
    bnd = binding()
    loop do
      input = Readline.readline("(mainframe):#{@line}-> ", :terminal)
      
      if input == "exit"
        puts "Bye!"
        break
      else
        begin
          result = bnd.eval(input)
        rescue StandardError => e
          puts "\e[31m#{e.class}:\e[0m #{e.message}"
          puts "perhaps you wanted to type \e[31mexit\e[0m?"
        else
          puts CodeRay.encode(result.inspect, :ruby, :terminal)
        end
        @line += 1
      end
    end
  end

  self
end.new.run
