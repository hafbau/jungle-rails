require 'rails_helper'

def generate_user_attr
  user_attr = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: '123456',
    password_confirmation: '123456'
  }
end

RSpec.describe User, type: :model do
  
  # before(:all) do
  #   User.create!(generate_user_attr)
  # end

  before(:each) do
    @user_attr = generate_user_attr
    @old_count = User.count
  end

  it "must be created with a password" do
    @user_attr[:password] = nil
    user = User.new(@user_attr)
    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Password can't be blank")
    expect(User.count).to eql(@old_count)
  end

  it "must be created with a password_confirmation" do
    @user_attr[:password_confirmation] = nil
    user = User.new(@user_attr)
    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    expect(User.count).to eql(@old_count)
  end

  it "password and password_confirmation must match" do
    @user_attr[:password_confirmation] = 'nomach'
    user = User.new(@user_attr)
    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    expect(User.count).to eql(@old_count)
  end

  it "email must be unique" do
    @user_attr[:email] = User.find(2).email
    user = User.new(@user_attr)
    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Email has already been taken")
    expect(User.count).to eql(@old_count)
  end

  it "email must be uniquely case insensitive" do
    @user_attr[:email] = User.find(2).email.upcase
    user = User.new(@user_attr)
    expect(user.save).to be false
    expect(user.errors.full_messages).to include("Email has already been taken")
    expect(User.count).to eql(@old_count)
  end
end
