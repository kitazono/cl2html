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
    nodes.each {|node| v = node.print}
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

  def print
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

  def print
    if @command == :CALL
      puts @command
      @parms.each {|p| p.print }
    end
  end
end

class FuncallNode < Node

  def initialize(file_name, lineno, function_name, args)
    super(file_name, lineno)
    @function_name = function_name
    @args = args
  end

  def print
    p @function_name
    p @args
  end
end


class IfNode < Node

  def initialize(file_name, lineno, condition, true_stmt)
    super(file_name, lineno)
    @condition = condition
    @true_stmt = true_stmt
    # @false_stmt = false_stmt
  end

  def print
    if @true_stmt.command == :CALL
      printf 'IF'
      @condition.print
      printf 'THEN'
      @true_stmt.print
    end
  end
end

class VarRefNode < Node

  def initialize(file_name, lineno, var_name)
    super(file_name, lineno)
    @var_name = var_name
  end

  def print
  end
end

class ParmNode < Node

  def initialize(file_name, lineno, parm_name, args)
    super(file_name, lineno)
    @parm_name = parm_name
    @args = args
  end

  def print
    @args.each {|v| v.print}
  end
end

class LiteralNode < Node

  def initialize(file_name, lineno, val)
    super(file_name, lineno)
    @val = val
  end

  def print
    puts @val
  end
end

class StringNode < Node

  def initialize(file_name, lineno, str)
    super(file_name, lineno)
    @val = str
  end
end

class ReservedNode < Node

  def initialize(file_name, lineno, resereved_word)
    super(file_name, lineno)
    @resereved_word = resereved_word
  end
end
