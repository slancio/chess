class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name, @title, @salary, @boss = name, title, salary, boss
    boss.add_employee(self) unless boss.nil?
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier = 1)
    total_salary = 0
    employees.each do |employee|
      total_salary += employee.salary
      total_salary += employee.bonus if employee.is_a?(Manager)
    end
    total_salary * multiplier
  end

  def add_employee(employee)
    @employees << employee
  end

end
