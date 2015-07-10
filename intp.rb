require './cl.tab.rb'
require './node.rb'

class InterPreter

  def initialize(option, file_name)
    @file_name = file_name
    case option
    when "-p" 
      print
    else
      raise Intp::IntpError, "#{option} incorrect option"
    end
  end

  def print
    begin
      tree = nil
      File.open(@file_name) {|file| tree = ClParser.new.parse(file, @file_name)}
      tree.print
    rescue Racc::ParseError, IntpError, Errno::ENOENT
      $stderr.puts "#{$0}: #{$!}"
      exit 1
    end
  end

end

InterPreter.new(ARGV[0], ARGV[1])