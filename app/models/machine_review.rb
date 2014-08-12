require_relative 'fancy_record'

class MachineReview < ActiveRecord::Base
  
  #not-migrated attribute :id, :mechanic_id, :machine_id, :comment

  def initialize(params)
    @id=params[:id]
    @mechanic_id=params[:mechanic_id]
    @machine_id=params[:machine_id]
    @comment=params[:comment]
  end
  
end
