require_relative 'fancy_record'
require_relative 'user'

class Manager < User

  def initialize(params)
    params[:role]=:manager
    super(params)
  end
  
  def register(params)
    raise 'username_already_exists' if(!User.find_by(username:params[:username]).nil?)
    raise 'empty_username' if(params[:username].length==0)
    raise 'empty_password' if(params[:password].length==0)
    User.create(username: params[:username], password: params[:password], last_query_time: Time.new, paid_days:0, acc_days:0, name: params[:name], surname: params[:surname], health_condition:'ok')
  end
  
  def unregister(username_as_param)
    user=User.find_by(username: username_as_param)
    raise 'user_not_found' if(user.nil?)
    raise 'cannot_unregister_yourself' if(username_as_param==username)
    User.delete_by_id(user.id)
  end

  def pay_salary(params)
    receiver=User.find_by(id: params[:receiver_id])
    raise 'user_not_found' if(receiver.nil?)
    raise 'not_positive_ammount' if(params[:ammount]<=0)
    raise 'empty_comment' if(params[:comment]=='')
    MoneyTransfer.create(status:'paid', receiver_id:params[:receiver_id], source: :paid_salaries, is_profit: false, time: Time.new, confirmer_id: id, comment: params[:comment], ammount: params[:ammount])
    receiver.paid_days=receiver.paid_days+params[:number_of_days]
  end
  
  def resolve_imprest(params)
    imprest=MoneyTransfer.find_by(id: params[:transfer_id])
    raise 'request_not_found' if(imprest.nil? or imprest.source != :imprest_request)
    imprest.status=params[:mark_as]
    receiver=User.find_by(id: imprest.receiver_id)
    receiver.paid_days=receiver.paid_days+params[:plus_paid_days]
  end
  
  def resolve_repair_fund_request(params)
    request=MoneyTransfer.find_by(id: params[:transfer_id])
    raise 'request_not_found' if(request.nil? or request.source != :repair_needs)
    request.status=params[:mark_as]
  end
  
  def add_route(params)
    raise 'route_already_exists' if(!Route.find_by(number: params[:number], type_of_machine: params[:type_of_machine]).nil?)
    raise 'empty_header' if(params[:header].length==0)
    Route.create(type_of_machine: params[:type_of_machine], number: params[:number], header: params[:header])
  end
  
  def edit_route(params)
    route=Route.find_by(id:params[:route_id])
    raise 'route_not_found' if(route.nil?)
    matching_routes=Route.find_by(type_of_machine: params[:new_type_of_machine], number: params[:new_number])
    raise 'route_already_exists' if(!matching_routes.nil? and matching_routes.id !=params[:route_id])
    raise 'empty_header' if(params[:new_header].length==0) 
    route.number=params[:new_number]
    route.type_of_machine=params[:new_type_of_machine]
    route.header=params[:new_header]
  end
  
  def delete_route(id_as_param)
    raise 'route_not_found' if(Route.find_by(id: id_as_param).nil?)
    Route.delete_by_id(id_as_param)
  end
  
  def add_machine(params)
    raise 'machine_already_exists' if(!Machine.find_by(number: params[:number]).nil?)
    Machine.create(type_of_machine: params[:type_of_machine], number: params[:number], condition: params[:condition])
  end
  
  def delete_machine(id_as_param)
    raise 'machine_not_found' if(Machine.find_by(id: id_as_param).nil?)
    Machine.delete_by_id(id_as_param)
  end
  
  def add_new_journeys(params)
    raise 'incorrect_journeys_number' if (params[:how_much]<=0)
    raise 'past_date' if(params[:time]<Time.new)
    raise 'route_not_found' if(Route.find_by(id: params[:route_id]).nil?)
    params[:how_much].times do
      Journey.create(status:'waiting', route_id: params[:route_id], day: params[:time], is_still_accepted: false, driver_id: nil, note:'', noter_id: nil, note_time: nil)
    end
  end
  
end
