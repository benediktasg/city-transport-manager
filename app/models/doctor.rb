require_relative 'fancy_record'
require_relative 'user'

class Doctor < User
  
  def mark_user_as_healthy(id_as_param)
    user=User.find_by(id:id_as_param)
    raise 'user_not_found' if(user.nil?)
    raise 'already_healthy' if(user.healthy?)
    User.find_by(id:id_as_param).health_condition='ok'
  end
  
  def mark_user_as_ill(params)
    user=User.find_by(id:params[:user_id])
    raise 'user_not_found' if(user.nil?)
    user.health_condition=params[:illness]
  end
  
  def submit_illness_report(params)
    user=User.find_by(id:params[:user_id])
    raise 'user_not_found' if(user.nil?)
    raise 'empty_note' if(params[:note]=='')
    HealthCheck.create(user_id: params[:id], doctor_id: id, time: Time.new, desicion: params[:desicion], note: params[:note])
  end
  
  def list_medical_papers(id_as_param)
    raise 'user_not_found' if(User.find_by(id: id_as_param).nil?)
    MedicalPaper.where(user_id: id_as_param)
  end
end
