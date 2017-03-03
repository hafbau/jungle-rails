class JungleMailer < ApplicationMailer

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: "Jungle Order ##{@order.id}") if @order.email
  end
end
