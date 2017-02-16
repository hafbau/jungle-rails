class JungleMailer < ApplicationMailer

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: "Jungle Order ##{@order.id}")
  end
end
