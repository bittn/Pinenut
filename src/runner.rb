#-------------
#|runner.rb|
#|RunProgram|
#-------------
require'byebug'
classRunner
definitialize(tkn)
@token=tkn
@line=1
@var={}
end

defrun(ss,ff)
pp=ss#sも処理される。fも処理される。
whiletrue
case@token[pp]
when/\A1(.+)/
putsgetVar($1)
when"0"
@line+=1
when/\A3(\w+!=\w+)=(\d)/
pp+=1
whilegetVar($1)!=false
run(pp,$2.to_i-1)
end
pp=$2.to_i
when/\A2(\w+)=(.+)/
@var[$1]=getVar($2)
when/5(\w)/
@var[$1]+=1
#Pleasewriteyournewmethodhere.
#sample:
#when"Token_Name"
#YourMethodMovement
else
rerror(4,pp)
break
end
pp+=1

if@token[pp]==nil||pp==ff+1
#byebug
break
end
end
end

defrerror(n,pp)
puts"Error:#{@line}:#{pp.to_i+1}th(#{@token[pp.to_i]}):RunnerError,(Point:#{n})"
end


defgetValue(e)
exp=e.split(/(\+|-)/)

ifexp[0]==""
exp.delete_at(0)
end

i=0
type="start"
acc=0
whilei!=exp.size
ifexp[i]=="+"&&type!="opr"
type="opr"
elsifexp[i]=="-"&&type!="opr"
type="opr"
elsifexp[i]=~/\d+/&&type!="value"&&type!="var"
type="value"
elsifexp[i]=~/\w+/&&type!="var"&&type!="value"
type="var"
exp[i]=getVar(exp[i])
else
end
i+=1
end

ifexp[0]!="+"&&exp[0]!="-"
exp.unshift("+")
end

i=0
whilei!=exp.size
ifexp[i]=="+"
i+=1
acc+=exp[i].to_i
elsifexp[i]=="-"
i+=1
acc-=exp[i].to_i
end
i+=1
end
returnacc
end

defevalCond(c)
#if@var["i"]==10
#	byebug
#end
l=c.split(/(==|!=|<|>)/)[0]
ope=c.split(/(==|!=|<|>)/)[1]
r=c.split(/(==|!=|<|>)/)[2]
ifope=="=="
s=(getVar(l)==getVar(r))
elsifope=="!="
s=(getVar(l)!=getVar(r))
elsifope=="<"
s=(getVar(l)<getVar(r))
elsifope==">"
s=(getVar(l)>getVar(r))
end
#ifs
#	return"true"
#else
#	return"false"
#end
returns
end

defgetVar(c)
casec
when/"(.+)"/
return$1.gsub("\\n","\n")
when"true"
returneval(c)
when"false"
returneval(c)
when/\w+==\w+/
returnevalCond(c)
when/\w+!=\w+/
returnevalCond(c)
when/\w+<\w+/
returnevalCond(c)
when/\w+>\w+/
returnevalCond(c)
when/(\w(\+|-))+\w/
returngetValue(c)
when/[0-9\.]+/
returnc.to_i
when/.+/#最後
return@var[c]
else
putsc
rerror(6,p)
end
end
end
