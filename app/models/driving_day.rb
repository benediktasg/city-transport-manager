class DrivingDay < ActiveRecord::Base
  
  #not-migrated attribute :id, :user_id, :day, :status
  
  def initialize(params)
    @id=params[:id]
    @user_id=params[:user_id]
    @day=params[:day]
    @status=params[:status]
  end

end
