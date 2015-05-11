class Project

  def initialize(project_name, identifier)
    @project_name = project_name
    @project_identifier = identifier
=begin
    @feature_name = 'Feature #1'
    @bug_name = 'Bug #1'
    @support_ticket_name = 'Support ticket #1'
=end
  end

  attr_reader :project_name, :project_identifier
  attr_writer :project_name

end