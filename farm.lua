local robot = require("robot")
local component = require("component")
local nav = component.navigation
local net= component.modem
local computer=require("computer")
local event = require("event")

function dump(give)

  for i = 1,16 do
  total= robot.count(i)
  if i<=give then
    robot.select(i)
    robot.dropDown(total-1)
  else
    robot.select(i)
    robot.dropDown(total)
    end
  end
end

function moveby(x)
  for i=1,x do
    robot.forward()
  end
end

function setdir(d,ns)
  if d<0 and ns == false then
    dir= 4
  elseif d<0 and ns == true then
    dir = 2
  elseif d>0 and ns == false then
    dir = 5
  else
    dir = 3
  end

  while nav.getFacing() ~= dir do
      robot.turnLeft()
  end
end

function defDir(dir)
  while (nav.getFacing()~=dir) do
    robot.turnLeft()
  end
end

function action(find)
  place =1
  loc=nil
  way= nav.findWaypoints(100)

  while way[place] ~= nil do
   if (string.match(way[place]["label"],find)) then
      loc= way[place]["position"]
      break
    end

    place=place+1
  end
  if loc[1]~= nil
    setdir(loc[1],false)
    moveby(math.abs(loc[1]))
    setdir(loc[3],true)
    moveby(math.abs(loc[3]))
    end
end

function harvest (length,seed)
  robot.select(seed)

    for i = 1,length do
      robot.forward()
      robot.swingDown()
      robot.placeDown()

      end
end

function task()

  _,_,from,port,_,message= event.pull("modem_message")
  demessage={}
  for i in string.gmatch(message,"%S+") do
    demessage[i]
  end
  return demessage
end



-- demessage format "place" long wide items seedsloc

while true do

  info = task()
  place = info[1]
  action(place)

  --how long is the farm
  long=tonumber(info[2])
  --"how wide is the farm
  wide=tonumber(info[3])
  --how much items
  items=tonumber(info[4])
  --seed loction in inventory
  seedloc=tonumber(info[5])
  ordir=nav.getFacing()


  for i=1,wide do

    harvest(long,seedloc)
    if (i%2 == 0) then
      robot.turnLeft()
      robot.forward()
      robot.turnLeft()
    else
      robot.turnRight()
      robot.forward()
      robot.turnRight()
    end

  end

  if (computer.energy()<2000) then
    action(true)
  end

  action(false)
  dump(items)
  defDir(ordir)

end
