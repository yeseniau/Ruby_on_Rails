class Person
    attr_accessor :first_name, :last_name, :age, :type     # attr_accesor permite obtener y modificar los datos
  
    def initialize(first = '', last = '', age = '', type = '')
      @first_name = first
      @last_name = last
      @age = age
      @type = type
    end
  
    def birthday
      @age += 1
    end
  
    def talk
    end
  
    def introduce
    end
  end
  
  # 1. Identificar las posibles subclases que aparecen en el código a refactorizar. Cada una
  # de ella contendrá los métodos correspondientes, talk e introduce.
  
  class Student < Person
    def talk
      puts 'Aquí es la clase de programación con Ruby?'
    end
  
    def introduce
      puts "Hola profesor. Mi nombre es #{@first_name} #{@last_name}."
    end
  end
  
  class Teacher < Person
    def talk
      puts 'Bienvenidos a la clase de programación con Ruby!'
    end
  
    def introduce
      puts "Hola alumnos. Mi nombre es #{@first_name} #{@last_name}."
    end
  end
  
  class Parent < Person
    def talk
      puts 'Aquí es la reunión de apoderados?'
    end
  
    def introduce
      puts "Hola. Soy uno de los apoderados. Mi nombre es #{@first_name} #{@last_name}."
    end
  end
  
  persona = Person.new('yesenia', 'urdaneta', 45)
  estudiante = Student.new('yesenia', 'urdaneta', 45)
  profesor = Teacher.new('yesenia', 'urdaneta', 45)
  apoderado = Parent.new('yesenia', 'urdaneta', 45)
  
  puts persona.birthday
  puts profesor.talk
  puts apoderado.introduce
  
  estudiante.first_name="yoselin"
  puts estudiante.introduce
  