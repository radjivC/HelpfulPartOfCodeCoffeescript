#!/usr/bin/env ruby

#  calculate the empirical probabilities.rb
#  
#
#  Created by radjiv on 10/24/13.
#


#calculate all distance


require 'logger'
$logger = Logger.new('proba.log')

def bubble_sort(list)
  return list if list.size <= 1 # already sorted
  swapped = true
  while swapped do
    swapped = false
    0.upto(list.size-2) do |i|
      if list[i] > list[i+1]
        list[i], list[i+1] = list[i+1], list[i] # swap values
        swapped = true
      end
    end    
  end

  list
end

tab = [2, 4, 5, 0, 2, 5, 4, 0, 4, 6, 7, 8, 0, 5, 3, 2, 3, 1, 1, 2]

tab = bubble_sort(tab);

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
	$logger.debug("number = "+tabNumber[i].to_s+"   freq = " + tabFreq[i].to_s)
end


$logger.close




        
    