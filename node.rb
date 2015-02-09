# module Intp

  class IntpError < StandardError; end
  class IntpArgumentError < IntpError; end

  # class Core

  #   def initialize
  #     @function_table = {}
  #     @obj = Object.new
  #     @stack = []
  #     @stack.push(Frame.new("(toplevel)"))
  #   end

  #   def frame
  #     @stack[-1]
  #   end

  #   def call_function_or(function_name, args)
  #     call_intp_function_or(function_name, args) do
  #       call_ruby_toplevel_or(function_name, args) do
  #         yield
  #       end
  #     end
  #   end

  #   def call_intp_function_or(function_name, args)
  #     if function = @function_table[function_name]
  #       frame = Frame.new(function_name)
  #       @stack.push(frame)
  #       function.call(self, frame, args)
  #       @stack.pop
  #     else
  #       yield
  #     end
  #   end

  #   def call_ruby_toplevel_or(function_name, args)
  #     if @obj.respond_to?(function_name, true)
  #       @obj.send(function_name, *args)
  #     else
  #       yield
  #     end
  #   end

  # end

  # class Frame

  #   attr :function_name

  #   def initialize(function_name)
  #     @function_name = function_name
  #     @local_vars = {}
  #   end

  #   def local_var?(var_name)
  #     @local_vars.key?(var_name)
  #   end

  #   def [](var_name)
  #     @local_vars[var_name]
  #   end

  #   def []=(var_name, val)
  #     @local_vars[var_name] = val
  #   end

  # end

  class Node

    attr_reader :file_name
    attr_reader :lineno

    @@indent = 0
    @@subroutine_table = {}

    def initialize(file_name, lineno)
      @file_name = file_name
      @lineno = lineno
    end

    def exec_list(intp, nodes)
      v = nil
      nodes.each {|node| v = node.evaluate(intp)}
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
      exec_list(Core.new, @tree)
    end


  end

  # class AssignNode < Node

  #   def initialize(file_name, lineno, var_name, val)
  #     super(file_name, lineno)
  #     @var_name = var_name
  #     @val = val
  #   end

  #   def evaluate(intp)
  #     intp.frame[@var_name] = @val.evaluate(intp)
  #     # debug
  #     p @val.evaluate(intp)
  #   end

  #   def to_s
  #     str = ""
  #     str << "#{@var_name} = "
  #     str << @val.to_s
  #   end

  #   def draw(flowchart)
  #     flowchart.add_edge(self.to_s)
  #   end

  # end

  # class VarRefNode < Node

  #   def initialize(file_name, lineno, var_name)
  #     super(file_name, lineno)
  #     @var_name = var_name
  #   end

  #   def evaluate(intp)
  #     if intp.frame.local_var?(@var_name)
  #       intp.frame[@var_name]
  #     else
  #       intp.call_function_or(@var_name, []) do
  #         intp_error!("unknown method or local variable #{@var_name.id2name}")
  #       end
  #     end
  #   end

  #   def to_s
  #     "#{@var_name}"
  #   end

  # end

  # class CallNode < Node

  #   def initialize(file_name, lineno, primary)
  #     super(file_name, lineno)
  #     @primary = primary
  #   end

  #   def evaluate(intp)
  #     InterPreter.new(@primary.evaluate(intp))
  #   end

  #   def to_s
  #     str = ""
  #     str << "call "
  #     str << @primary.to_s
  #   end

  #   def draw(flowchart)
  #     flowchart.add_edge(self.to_s)
  #   end

  # end

# end # module Intp