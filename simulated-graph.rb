#!/usr/bin/env ruby

FIELD_SIZE = 100.0
N_DEVICES = 50000
CONNECTION_RANGE = 6.0
OUTGOING_CONNECTIONS = 2
GRAPH_PIXELS = 1000
GRAPH_BORDER_PIXELS = 20
$distance_exist = Array.new
require 'logger'
start = Time.now
$logger_empiratical = Logger.new('empiratical_devices.log')
$tag = Array.new
class Device
    def initialize(x, y)
        @x, @y = x, y
    end

    def x
        @x
    end

    def y
        @y
    end

    def distance_to(d)
        Math.sqrt((@x-d.x)**2 + (@y - d.y)**2)
    end
end

def exist(son)
    exist =false
    $tag.each do |item|
        if item == son
            exist = true
        end
    end
    return exist
end

def register(s)
    $tag<<s

end

def dfs(s)
    s_neighbor = Array.new
    existb= false
    register(s)
    s_neighbor = calcul_son_neighbor(s)
    s_neighbor.each_with_index do |index, item|
        existb =  exist(s_neighbor[item])
		if  existb == false && $tag.length <= N_DEVICES
			dfs(s_neighbor[item])
		end

	end

end


def calcul_son_neighbor(s)
    s_neighbor = Array.new
    $links[s].each do |son|
        $links[son].each do |neighbor|
            s_neighbor<< neighbor
        end
    end
    p s_neighbor
    return s_neighbor
end


#ticket 4
def calculate_empiratical(tab)
    tab.sort
    currentNumber = 0
    tabNumber = Array.new()
    tabFreq = Array.new()
    countFreq=0
    tabPosition=0
    currentNumber = tab[0]
    tabNumber[0]= tab[0]

    tab.each_with_index do |tab1,i|
        if(currentNumber == tab[i])
            countFreq += 1
            tabNumber[tabPosition]= currentNumber
            else
            tabFreq[tabPosition] = countFreq
            tabPosition += 1
            countFreq = 1
            currentNumber = tab[i]
            tabNumber[tabPosition]= currentNumber
            tabFreq[tabPosition] = countFreq
        end
    end

    tabFreq.each_with_index do |tab2,i|
        tabFreq[i] = tabFreq[i].to_f/tab.size.to_f
    end
    tabFreq.each_with_index do |tab2,i|
        $logger_empiratical.debug("number = "+tabNumber[i].to_s+"   freq = " + tabFreq[i].to_s)
    end
    $logger_empiratical.close
end


devices = Array.new(N_DEVICES) {|i| Device.new(rand*FIELD_SIZE, rand*FIELD_SIZE)}
$links = Array.new(N_DEVICES) {|i| Array.new}

devices.each_with_index do |d, i|
    n = attempts = 0
    $connect = Array.new
    $connect.clear
    while n < OUTGOING_CONNECTIONS && attempts < N_DEVICES*5
        attempts += 1
        j = rand(N_DEVICES)
        if d.distance_to(devices[j]) < CONNECTION_RANGE && i != j
            # bidirectional
            $distance_exist << d.distance_to(devices[j])
            $connect << j
            n += 1
        end
    end
    $links[i] = $connect
end

require 'rubygems'
require 'chunky_png'

def pixels(x)
    GRAPH_BORDER_PIXELS + Integer((GRAPH_PIXELS-GRAPH_BORDER_PIXELS*2)*x/FIELD_SIZE)
end

png = ChunkyPNG::Image.new(GRAPH_PIXELS, GRAPH_PIXELS, ChunkyPNG::Color::WHITE)

devices.each do |d|
    png.circle(pixels(d.x), pixels(d.y), 2, ChunkyPNG::Color::BLACK, ChunkyPNG::Color::WHITE)
end

$links.each_with_index do |link, index|
    if link.length > 0
        link.each do |item|
            d0 = devices[index]
            d1 = devices[item]
            png.line_xiaolin_wu(pixels(d0.x), pixels(d0.y), pixels(d1.x), pixels(d1.y), ChunkyPNG::Color::BLACK, true)
        end
    end
end

png.save('graph.png', :interlace => true)

#ticket 3 graph connected

dfs(0)
p $tag

if $tag.size == N_DEVICES
    puts " connected "
else
    puts " not connected "
end




#ticket 4
calculate_empiratica($distance_exist)
puts "\nTime elapsed: #{Time.now - start} seconds\n"
