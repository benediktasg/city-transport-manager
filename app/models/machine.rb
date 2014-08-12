require_relative 'fancy_record'

class Machine < ActiveRecord::Base
  #not-migrated attribute :id, :type_of_machine, :number, :condition
  
  def initialize(params)
    @id=params[:id]
    @type_of_machine=params[:type_of_machine]
    @number=params[:number]
    @condition=params[:condition]
  end
end
