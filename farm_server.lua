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

end


function putnewTask(task,table)
  table[tableloc]=task
  tableloc=tableloc+1
end

function tableTasks()



end
