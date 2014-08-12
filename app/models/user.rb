require_relative 'fancy_record'
require_relative 'medical_paper'

class User<ActiveRecord::Base
  #not-migrated attribute :id, :role, :last_query_time
  #not-migrated attribute :password, :paid_days, :acc_days, :username #acc_days means accumulated_days
  #not-migrated attribute :name, :surname, :health_condition
  
  MIN_PASSWORD_LENGTH=3
  
  def initialize(params)
    return if(!params[:id])
    @id=params[:id]
    @username=params[:username]
    @role=params[:role]
    @last_query_time=params[:last_query_time]
    @password=params[:password]
    @paid_days=params[:paid_days]
    @acc_days=params[:acc_days]
    @name=params[:name]
    @surname=params[:surname]
    @health_condition=params[:health_condition]
  end
  
  def change_password(old_passw, new_passw)
    raise 'old_password_wrong' if(old_passw !=@password)
    raise 'new_password_too_short' if(new_passw.length<MIN_PASSWORD_LENGTH)
    @password=new_passw
  end
  
  def submit_medpaper(params)
     raise 'reason_not_defined' if(params[:reason].nil? or params[:reason].length==0)
     params[:user_id]=@id
     MedicalPaper.create(params)
  end
  
  def request_imprest(params)
    raise 'non_positive_ammount' if(params[:ammount]<=0)
    params[:status]='waiting'
    params[:receiver_id]=@id
    params[:source]=:imprest_request
    params[:is_profit]=false
    params[:time]=Time.new
    params[:confirmer_id]=nil
    MoneyTransfer.create(params)
  end
  
  def list_salaries
    MoneyTransfer.where(receiver_id: @id)
  end
  
  def submit_complaint(params)
    raise 'incorrect_complaint' if(params[:header]=='' or params[:content]=='')
    params[:user_id]=@id
    params[:time]=Time.new
    params[:status]='waiting'
    params[:answer]=''
    params[:answerer_id]=nil
    Complaint.create(params)
  end
  
  def healthy?
    @health_condition=='ok'
  end
  
end
