require_relative 'fancy_record'

class Repair < ActiveRecord::Base
  #not-migrated attribute :id, :machine_id, :mechanic_id, :time
  #not-migrated attribute :comment, :status, :decider_id
  
  def initialize(params)
    @id=params[:id]
    @machine_id=params[:machine_id]
    @mechanic_id=params[:mechanic_id]
    @time=params[:time]
    @comment=params[:comment]
    @status=params[:status]
    @decider_id=params[:decider_id]
  end
  
end
