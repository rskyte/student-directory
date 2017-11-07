$mod_mode = 0
#put students in array
def input_students 
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts students.count == 1 ? "Now we have #{students.count} student" : "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def mod(string)
  if $mod_mode == 1
    if string[0].downcase == 'a'
      true
    else
      false
    end
  elsif $mod_mode == 2
    if string.length < 13
      true
    else
      false
    end
  else
    true
  end
end
    
      
def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)" if (mod(student[:name]) == true)
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students!"
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)

