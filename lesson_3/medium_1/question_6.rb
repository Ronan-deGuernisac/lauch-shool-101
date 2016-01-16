# question_6.rb

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# Yes, here is a difference. 
#
# rolling_buffer1 implements the functionality correctly. On each pass the new element 
# is added. When the max_buffer_size is reached the oldest element is shifted
#
# rolling_buffer2 does not implement the functionality correctly. The buffer array is only
# changed within the method so each time the method is called an empty array is passed to it
