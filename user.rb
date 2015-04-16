class User

  def initialize(name, pass)
    @login = name
    @first_name = name + 'first'
    @last_name = name + 'last'
    @email = name + '@exmpl.com'
    @password = 112233
    @project_name = name + "project"
  end

  attr_reader :login, :password, :first_name, :last_name, :email, :password, :project_name
  attr_writer :first_name, :last_name, :password, :password, :project_name


end