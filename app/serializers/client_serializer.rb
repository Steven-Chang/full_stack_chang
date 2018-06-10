class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :balance

  def balance
    costs = Job.where( :user_id => current_user.id ).where( :client_id => object.id ).sum( :cost )
    paid = ClientPayment.where( :client_id => object.id ).sum( :amount )
    costs - paid
  end
end
