$mod_mode = 0

def input_students 
  puts "Please enter the names of the students and their cohorts"
  puts "Use this format 'Namey McName/cohort"
  puts "To finish just hit return twice"
  students = []
  inp = gets.delete "\n"
  input = inp.split("/")
  while !input.empty? do
    students << {name: input[0], cohort: (input[1] ? input[1].downcase.to_sym : :noCohortData), hobbies: 'things', birth_country: 'place', height: 0}
    puts students.count == 1 ? "Now we have 1 student" : "Now we have #{students.count} students"
    input = gets.chomp.split("/")
  end
  students
end

def mod(student)
  if $mod_mode == 1 #print all students with name beginning with a certain letter
    if student[:name][0].downcase == 'a'
      true
    else
      false
    end
  elsif $mod_mode == 2 #print all students with a name less than a certain length
    if student[:name].length < 13
      true
    else
      false
    end
  elsif $mod_mode == 3 #print by cohort
    if student[:cohort] == :november
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
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(40) if (mod(student) == true)
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students!"
end

students = input_students
print_header
print(students)
print_footer(students)

