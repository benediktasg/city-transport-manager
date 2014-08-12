require_relative 'fancy_record'
require_relative 'user'

class Controller < User

  def assign_journey(params)
    driver=User.find_by(:role=>:driver, id:params[:driver_id])
    journey=Journey.find_by(id:params[:journey_id])
    raise 'journey_not_found' if(journey.nil?)
    driving_day=DrivingDay.find_by(user_id:driver.id, day:journey.day)
    raise 'driver_already_assigned' if (!journey.driver_id.nil?)
    raise 'driver_is_busy' if (driving_day.nil? or driving_day.status != :waiting)
    journey.driver_id=driver.id
    journey.status='planned'
    journey.is_still_accepted=true
    driving_day.status=:accepted
  end
  
  def reassign_journey(params)
    driver=User.find_by(:role=>:driver, id:params[:driver_id])
    journey=Journey.find_by(id:params[:journey_id])
    raise 'journey_not_found' if(journey.nil?)
    driving_day=DrivingDay.find_by(user_id:driver.id, day:journey.day)
    raise 'driver_is_busy' if (driving_day.nil? or driving_day.status != :waiting)
    driving_day.status=:accepted
    journey.driver_id=driver.id
    journey.is_still_accepted=true
  end
  
  def cancel_journey(id_as_param)
    journey=Journey.find_by(id:id_as_param)
    raise 'journey_not_found' if(journey.nil?)
    raise 'journey_not_assigned' if(journey.driver_id.nil?)
    driving_day=DrivingDay.find_by(user_id:journey.driver_id, day:journey.day)
    journey.status='cancelled'
    journey.driver_id=nil
    driving_day.status=:waiting
  end
  
  def mark_journey_as_completed(id_as_param)
    journey=Journey.find_by(id:id_as_param)
    raise 'journey_not_found' if(journey.nil?)
    raise 'future_date' if(journey.day > Time.now)
    raise 'driver_missing' if(journey.driver_id.nil?)
    driver=User.find_by(id:journey.driver_id)
    journey.status='completed'
    driver.acc_days=driver.acc_days+1
  end
  
  def report_journey_problem(params)
    journey=Journey.find_by(id:params[:journey_id])
    raise 'journey_not_found' if(journey.nil?)
    raise 'note_required' if(params[:note].respond_to?('length') and params[:note].length==0)
    journey.noter_id=id
    journey.note=params[:note]
    journey.note_time=Time.now
  end
  
end

