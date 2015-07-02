class Employee
  attr_reader :name, :title, :salary, :boss, :employees

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @employees = []
    @boss = boss
    boss.employees << self unless boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def get_total_salary
    @salary
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    (self.get_total_salary - salary) * multiplier
  end

  def get_total_salary
    total_salary = self.salary
    @employees.each do |worker|
      total_salary += worker.get_total_salary
    end
    total_salary
  end
end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new("Ned", "Founder", 1_000_000)
  darren = Manager.new("Darren", "TA Manager", 78_000, ned)
  shawna = Employee.new("Shawna", "TA", 12_000, darren)
  david = Employee.new("David", "TA", 10_000, darren)

  puts "Ned bonus: #{ned.bonus(5)}"
  puts "Darren bonus: #{darren.bonus(4)}"
  puts "David bonus: #{david.bonus(3)}"
end
