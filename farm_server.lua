local component = require("component")
local event = require("event")
local modem = component.modem

tableloc=0
tabletaks={}

function sendtask(add,port,mess)
  send(add,port,mess)
end


function setTime()

  time= os.time
  return time
end


function putnewTask(task,table,place)
  table[place]=task
  place=place+1
  return table,place
end

function tableSetup(namefarm,hlong,hwide,seedsloc)
  a = {}
  a[name]= namefarm
  a[long]=hlong
  a[wide]=hwide
  a[seed]=seedloc

  return a
end
