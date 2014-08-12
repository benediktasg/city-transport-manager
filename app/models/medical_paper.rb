class MedicalPaper < ActiveRecord::Base
  #not-migrated attribute :user_id, :time_start, :time_finish, :reason
  #not-migrated attribute :id, :number
  
  def initialize(params)
    @user_id=params[:user_id]
    @time_start=params[:time_start]
    @time_finish=params[:time_finish]
    @reason=params[:reason]
    @id=params[:id]
    @number=params[:number]
  end
  
end
