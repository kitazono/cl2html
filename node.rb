class IntpError < StandardError; end

class Node

  attr_reader :file_name
  attr_reader :lineno

  def initialize(file_name, lineno)
    @file_name = file_name
    @lineno = lineno
  end

  def exec_list(nodes)
    v = nil
    nodes.each {|node| v = node.evaluate}
    v
  end

  def intp_error!(msg)
    raise IntpError, "in #{file_name}:#{lineno}: #{msg}"
  end

  def inspect
    "#{self.class.name}/#{lineno}"
  end

end

class RootNode < Node

  def initialize(tree)
    super(nil, nil)
    @tree = tree
  end

  def evaluate
    exec_list(@tree)
  end
end

class CommandNode < Node

  attr_reader :command

  def initialize(file_name, lineno, command, parms)
    super(file_name, lineno)
    @command = command
    @parms = parms
  end

  def evaluate
    if @command == "CALL"
      puts "#{@parms[0].args[0][1]}"
      @file_name =~ /.*#{File::Separator}(.*)\.txt/
      InterPreter.new(@file_name.gsub($1, @parms[0].args[0][1]))
    elsif @command == "SBMJOB"
      @parms[0].evaluate
    end
  end
end

class IfNode < Node

  def initialize(file_name, lineno, condition, true_stmt)
    super(file_name, lineno)
    @condition = condition
    @true_stmt = true_stmt
    # @false_stmt = false_stmt
  end

  def evaluate
    @true_stmt.evaluate
  end
end

class ParmNode < Node

  attr_reader :args

  def initialize(file_name, lineno, parm_name, args)
    super(file_name, lineno)
    @parm_name = parm_name
    @args = args
  end
end
