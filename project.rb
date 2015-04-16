class Project

  def initialize
    @project_name
    @project_identifier
    @feature_name = 'Feature #1'
    @bug_name = 'Bug #1'
    @support_ticket_name = 'Support ticket #1'
  end

  attr_reader :project_name, :project_identifier
  attr_writer :project_name

end