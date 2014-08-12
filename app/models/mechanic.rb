require_relative 'fancy_record'
require_relative 'user'

class Mechanic < User
  def initialize(params)
    params[:role]=:mechanic
    super(params)
  end
  
  def announce_review(params)
    raise 'machine_not_found' if(Machine.find_by(id:params[:machine_id]).nil?)
    raise 'empty_comment' if(params[:comment].length==0)
    MachineReview.create(mechanic_id:id, machine_id:params[:machine_id], comment:params[:comment], time: Time.new)
  end
  
  def announce_repair(params)
    raise 'machine_not_found' if(Machine.find_by(id:params[:machine_id]).nil?)
    raise 'empty_comment' if(params[:comment].length==0)
    Repair.create(mechanic_id:id, machine_id:params[:machine_id], comment:params[:comment], time: Time.new, status: :completed, decider_id: nil)
  end
  
  def propose_repair(id_as_param)
    raise 'machine_not_found' if(Machine.find_by(id:id_as_param).nil?)
    Repair.create(mechanic_id:id, machine_id:id_as_param, time: Time.new, status: :waiting, decider_id: nil, comment: nil)
  end
  
  def mark_car_as_damaged(id_as_param)
    raise 'machine_not_found' if(Machine.find_by(id:id_as_param).nil?)
    Machine.find_by(id:id_as_param).condition=:damaged
  end
  
  def mark_car_as_wrecked(id_as_param)
    raise 'machine_not_found' if(Machine.find_by(id:id_as_param).nil?)
    Machine.find_by(id:id_as_param).condition=:wrecked
  end
  
  def request_repairing_funds(params)
    raise 'machine_not_found' if(Machine.find_by(id:params[:machine_id]).nil?)
    raise 'not_positive_ammount' if(params[:ammount]<=0)
    MoneyTransfer.create(status:'requested', receiver_id:id, source: :repair_needs, is_profit: false, time: Time.new, confirmer_id: nil, ammount: params[:ammount], comment: params[:machine_id])
  end
  
end
