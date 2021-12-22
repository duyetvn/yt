module ApplicationHelper
  def flash_type(msg_type)
    case msg_type
    when 'error'
      'danger'
    when 'success'
      'success'
    when 'warning'
      'warning'
    else
      'info'
    end
  end
end
