$mod_mode = 0  #change criteria for printing student list
@students = []
@modifier = "" #specifier for printing student list criteria
@mod_list = [] #student list returned after applying mods

def input_students 
  puts "Please enter the names of the students and their cohorts"
  puts "Use this format 'Namey McName,cohort'"
  puts "To finish just hit return twice"
  loop do
    return if populate_student_array == 0
    puts @students.count == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"
  end
end

def mod
  if $mod_mode == 1 #print all students with name beginning with a certain letter
    @students.select{|student| student[:name][0].downcase == @modifier}
  elsif $mod_mode == 2 #print all students with a name less than a certain length
    @students.select{|student| student[:name].length < @modifier.to_i}
  elsif $mod_mode == 3 #print by cohort
    @students.select{|student| student[:cohort] == @modifier.to_sym}
  else
    @students
  end
end
    
def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print_students_list
  @mod_list.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(40)
  end
end

def print_footer
  puts @mod_list.count == 1 ? "Overall, we have 1 great student!" : "Overall, we have #{@mod_list.count} great students"
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def show_students
  mod_select
  @mod_list = mod
  if !@mod_list.empty?
    print_header
    print_students_list
    print_footer
  else
    puts "No student data"
  end
end

def print_mod_menu
  puts "Choose a selection criteria:"
  puts "0. No criteria"
  puts "1. Sort by name"
  puts "2. Sort by length of name"
  puts "3. Sort by cohort"
end

def mod_select
  print_mod_menu
  mod_process(STDIN.gets.chomp)
end

def mod_process(selection)
  case selection
    when "0"
      $mod_mode = 0
    when "1"
      $mod_mode = 1
      puts "Choose a letter to sort by (a - z):"
      @modifier = STDIN.gets.chomp.downcase
    when "2"
      $mod_mode = 2
      puts "Choose name length to sort by (as integer):"
      @modifier = STDIN.gets.chomp
    when "3"
      $mod_mode = 3
      puts "Choose a cohort:"
      @modifier = STDIN.gets.chomp
    else
      puts "Invalid command"
  end
end

def print_menu
  puts "Student directory menu:"
  puts "1. Input students"
  puts "2. Show the students"
  puts "3. Save the student list to students.csv"
  puts "4. Load the student list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "Invalid command"
  end
end
    
def save_students
  File.open("students.csv", "w") do |f|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      f.puts csv_line
    end
  end
end
  
def load_students(filename = "students.csv")
  File.open(filename, "r") do |f|
    f.readlines.each do |line|
      populate_student_array(line)
    end
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
    return
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "#{filename} doesn't exist"
    exit
  end
end

def populate_student_array(input = STDIN.gets)
  name, cohort = input.chomp.split(",")
  return 0 if name.nil?
  cohort = "unassigned" if cohort.nil?
  @students << {name: name, cohort: cohort.downcase.to_sym, hobbies: 'things', birth_country: 'place', height: 0}
end

interactive_menu


