require "gviz"
require './cl.tab.rb'

$gv = Gviz.new

class InterPreter

  def initialize(file_name)
    @file_name = file_name
    begin
      tree = nil
      File.open(@file_name) {|file| tree = ClParser.new.parse(file, @file_name)}
    rescue Racc::ParseError, IntpError, Errno::ENOENT
      $stderr.puts "#{$0}: #{$!}"
      exit 1
    end
  end
end

InterPreter.new(ARGV[0])
$gv.save :sample, :png