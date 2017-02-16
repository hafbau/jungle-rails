class JungleMailerPreview < ActionMailer::Preview
  def order_email
    JungleMailer.order_email(Order.first)
  end
end