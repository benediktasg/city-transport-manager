require_relative 'fancy_record'

class Route < ActiveRecord::Base
  #not-migrated attribute :id, :type_of_machine, :number, :header
  
  def initialize(params)
    @id=params[:id]
    @type_of_machine=params[:type_of_machine]
    @number=params[:number]
    @header=params[:header]
  end
  
end
