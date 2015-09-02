require './cl.tab.rb'
require './node.rb'

class InterPreter

  def initialize(file_name)
    @file_name = file_name
    begin
      tree = nil
      File.open(@file_name) {|file| tree = ClParser.new.parse(file, @file_name)}
      tree.evaluate
    rescue Racc::ParseError, IntpError, Errno::ENOENT
      $stderr.puts "#{$0}: #{$!}"
      exit 1
    end
  end
end

InterPreter.new(ARGV[0])