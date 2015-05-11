class User

  def initialize(name, pass)
    @login = name
    @first_name = name + 'First'
    @last_name = name + 'Last'
    @email = name + '@exmpl.com'
    @password = 112233
    @project_name = name + 'project'
    @full_name = @first_name + ' ' + @last_name
  end

  attr_reader :login, :password, :first_name, :last_name, :email, :password, :project_name, :full_name
  attr_writer :first_name, :last_name, :password, :password, :project_name

end
