class MoneyTransfer < ActiveRecord::Base
  #not-migrated attribute :id, :status, :receiver_id, :source, :is_profit
  #not-migrated attribute :time, :confirmer_id, :comment, :ammount
  
  def initialize(params)
    @id=params[:id]
    @status=params[:status]
    @receiver_id=params[:receiver_id]
    @source=params[:source]
    @is_profit=params[:is_profit]
    @time=params[:time]
    @confirmer_id=params[:confirmer_id]
    @comment=params[:comment]
    @ammount=params[:ammount]
  end
  
end
