require_relative 'fancy_record'

class HealthCheck < ActiveRecord::Base
  #not-migrated attribute :id, :user_id, :doctor_id, :time
  #not-migrated attribute :desicion, :note
  
  def initialize(params)
    @id=params[:id]
    @user_id=params[:user_id]
    @doctor_id=params[:doctor_id]
    @time=params[:time]
    @desicion=params[:desicion]
    @note=params[:note]
  end
end
