class Journey < ActiveRecord::Base

  #not-migrated attribute :id, :status, :route_id, :day, :driver_id
  #not-migrated attribute :is_still_accepted, :note, :noter_id, :note_time

  def initialize(params)
    @id=params[:id]
    @status=params[:status]
    @route_id=params[:route_id]
    @day=params[:day]
    @driver_id=params[:driver_id]
    @is_still_accepted=params[:is_still_accepted]
    @note=params[:note]
    @noter_id=params[:noter_id]
    @note_time=params[:note_time]
  end
  
  def assigned?
    @driver_id !=nil
  end
  
  def scheduled?
    @day !=nil
  end
  
end
