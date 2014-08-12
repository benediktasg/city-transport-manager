require_relative 'fancy_record'
require_relative 'user'

class Driver < User

  
  def announce_driving_day(year, month, day) #hh:mm:ss == 00:00:00 by default, cause it doesn't matter
    time_object=Time.new(year,month,day,0,0,0)
    raise 'past_date' if(Time.new > time_object)
    raise 'duplicate_driving_day' if(DrivingDay.where(user_id:id, day:time_object) != nil)
    DrivingDay.create(user_id:id, day:time_object, status: :waiting)
  end
  
  def cancel_driving_day(time_object)
    @item=DrivingDay.where(user_id:id, day:time_object)
    raise 'driving_day_not_exists' if(@item.nil? || @item.status==:cancelled || @item.status==:rejected)
    @item.status=:cancelled
  end
  
  def list_journeys(params)
    @my_items=Journey.where(driver_id:id)
    return [] if(@my_items==nil)
    @my_items=@my_items.select{ |journey_record|
      (params[:from]<=journey_record.day) && (params[:to]>=journey_record.day)
    }
    return [@my_items] if(@my_items.respond_to?('id')) #contains only one item, but need array, not item itself!
    @my_items
  end
  
  def forfeit_journey(id_as_param)
    @journey_object=Journey.find_by(id:id_as_param)
    raise 'journey_not_exists' if(@journey_object.nil?)
    raise 'permission_denied' if(@journey_object.driver_id != id)
    @journey_object.status='rejected'
    @journey_object.driver_id=nil
    @journey_object.is_still_accepted=false
  end
  
end
