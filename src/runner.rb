#  -------------
# | runner.rb   |
# | Run Program |
#  -------------
require 'byebug'
class Runner
  def initialize(tkn)
    @token = tkn
    @line  = 1
    @var   = {}
  end

  def run(ss,ff)
    pp = ss # sも処理される。fも処理される。
    while true
      case @token[pp]
      when /\A1(.+)/
        puts getVar($1)
      when "0"
        @line+=1
      when /\A3(\w+!=\w+)=(\d)/
        pp+=1
        while getVar($1)!=false
          run(pp,$2.to_i-1)
        end
        pp=$2.to_i
      when /\A2(\w+)=(.+)/
        @var[$1]=getVar($2)
      when /5(\w)/
        @var[$1]+=1
        # Please write your new method here.
        # sample:
        # when "Token_Name"
        #  Your Method Movement
      else
        rerror(4,pp)
        break
      end
      pp+=1

      if @token[pp] == nil || pp==ff+1
        # byebug
        break
      end
    end
  end

  def rerror(n,pp)
    puts "Error: #{@line}:#{pp.to_i+1}th ( #{@token[pp.to_i]} ): RunnerError, (Point: #{n})"
  end


  def getValue(e)
    exp = e.split(/(\+|-)/)

    if exp[0] == ""
      exp.delete_at(0)
    end

    i=0
    type="start"
    acc=0
    while i != exp.size
      if exp[i] == "+" && type != "opr"
        type = "opr"
      elsif exp[i] == "-" && type != "opr"
        type = "opr"
      elsif exp[i] =~ /\d+/ && type != "value" && type != "var"
        type = "value"
      elsif exp[i] =~ /\w+/ && type != "var" && type != "value"
        type = "var"
        exp[i] = getVar(exp[i])
      else
      end
      i+=1
    end

    if exp[0] != "+" && exp[0] != "-"
      exp.unshift("+")
    end

    i=0
    while i != exp.size
      if exp[i] == "+"
        i+=1
        acc += exp[i].to_i
      elsif exp[i] == "-"
        i+=1
        acc -= exp[i].to_i
      end
      i+=1
    end
    return acc
  end

  def evalCond(c)
    # if @var["i"]==10
    # 	byebug
    # end
    l = c.split(/(==|!=|<|>)/)[0]
    ope = c.split(/(==|!=|<|>)/)[1]
    r = c.split(/(==|!=|<|>)/)[2]
    if ope == "=="
      s = (getVar(l) == getVar(r))
    elsif ope == "!="
      s = (getVar(l) != getVar(r))
    elsif ope == "<"
      s = (getVar(l) < getVar(r))
    elsif ope == ">"
      s = (getVar(l) > getVar(r))
    end
    # if s
    # 	return "true"
    # else
    # 	return "false"
    # end
    return s
  end

  def getVar(c)
    case c
    when /"(.+)"/
      return $1.gsub("\\n","\n")
    when "true"
      return eval(c)
    when "false"
      return eval(c)
    when /\w+==\w+/
      return evalCond(c)
    when /\w+!=\w+/
      return evalCond(c)
    when /\w+<\w+/
      return evalCond(c)
    when /\w+>\w+/
      return evalCond(c)
    when /(\w(\+|-))+\w/
      return getValue(c)
    when /[0-9\.]+/
      return c.to_i
    when /.+/ # 最後
      return @var[c]
    else
      puts c
      rerror(6,p)
    end
  end
end

