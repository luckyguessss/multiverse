=begin
File Name: myrsort.rb
Author: Jack Nelson

Course: CS 3363-60635
Professor: Richard Churchill

Due Date: 10/22/22 @ 23:59
Submitted: 10/22/22 @ 17:23

Build: Ruby
Description: A Ruby implementation of the Radix Sort algorithm. Run code by simply inputting
             "ruby myrsort.rb". Please note: only works with positive integers.

Credits: Code based on these two resources: https://gist.github.com/aPeacefull/b40145f4aeafd568daa8
                                            https://www.youtube.com/watch?v=4ungd6NXFYI
=end

#TODO: counting sort method takes input array and current exponent position, returns sorted output array
def countingSort (input, exp)
    count = Array.new(10,0) #init counting array of length 10 (base ten number system used)
    output = Array.new(input.size) #init output array of input length

    #populating count array with number of times digit occurs
    #NOTE! numbers start at index 1. arrays start at index 0.
    for i in 0...input.size
        count[((input[i]/(10**exp))%10)] += 1
    end

    #shifting count array to index the same as numbers
    for i in 1..9
        count[i] = count[i-1] + count[i]
    end

    #populate output array
    i = input.size - 1
    while i >= 0
        current_element = input[i]
        output[count[((current_element)/(10**exp))%10] - 1] = current_element
        count[((current_element)/(10**exp))%10] -= 1
        i -= 1
    end

    output #return
end

#TODO: radix sort method
def radixSort
    arr = receiveInput
    max = arr.max #find largest number to determine number of exponents
    #puts max

    exp = 0
    #simple loop to assign exp value
    until max == 0 do
        exp += 1
        max /= 10
    end
    #puts exp

    for i in 0...exp #note: .. inclusive of end value vs ... exclusive of end value
        arr = countingSort(arr, i) #passing arr and current exp value
    end

    #printing sorted array to screen
    puts "Sorted array:"
    puts arr
end

#helper method, returns user-inputted array
def receiveInput
    puts "Enter integers to be sorted."
    input = gets.chomp #note: chomp removes "\n" from input
    arr = input.split
    if arr[0] == nil
        puts "No integers inputted."
        receiveInput
    end
    arr.map(&:to_i)#converting String input to int.
                   #note: last interpreted value is auto returned (arr)
end

#calling method
radixSort