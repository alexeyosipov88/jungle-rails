require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should not create a user if password is blank" do
      @user = User.new(name: "Alex", email: "23@mail.ru")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user).to_not be_valid
    end
    it "should not create a user if password and password confirmation don't match" do
      @user = User.new(name: "Alex", email: "23@mail.ru", password: "12345678", password_confirmation: "123451113678")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      expect(@user).to_not be_valid
    end
    it "should not create a user if email is blank" do
      @user = User.new(name: "Alex", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
      expect(@user).to_not be_valid
    end
    it "should not create a user if email is blank" do
      @user = User.new(email: "asdf@mail.ru", password: "12345678", password_confirmation: "12345678")
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
      expect(@user).to_not be_valid
    end
    it "should not create a user if emal already exists in the database" do
      @user1 = User.new(name: "alex", email: "aaaa@mail.ru", password: "12345678", password_confirmation: "12345678")
      @user1.save
      @user2 = User.new(name: "alex", email: "AAAA@mail.ru", password: "12345678", password_confirmation: "12345678")
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      expect(@user2).to_not be_valid
    end
    it "should not create a user if password is less that 8 characters" do
      @user = User.new(name: "alex", email: "aaaa@mail.ru", password: "123", password_confirmation: "123")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      expect(@user).to_not be_valid
    end
    describe ".authenticate_with_credentials" do
      it "succesfully authenticate when email and password match with existing user" do
        @user = User.new(name: "alex", email: "aaaa@mail.ru", password: "12345678", password_confirmation: "12345678")
        @user.save
        @user1 = User.authenticate_with_credentials('aaaa@mail.ru', "12345678")
        expect(@user1).to eql(@user)
      end
      it "authenticate_with_credentials method returns nil when email or password don't match" do
        @user = User.new(name: "alex", email: "aaaa@mail.ru", password: "12345678", password_confirmation: "12345678")
        @user.save
        @user1 = User.authenticate_with_credentials('aaaa@mail.ru', "123453678")
        expect(@user1).to_not eql(@user)
      end
      it "succesfully authenticate when email even with whitespaces around email or uppercase charaters" do
        @user = User.new(name: "alex", email: "aaaa@mail.ru", password: "12345678", password_confirmation: "12345678")
        @user.save!
        @user1 = User.authenticate_with_credentials('Aaaa@mail.ru', "12345678")
        expect(@user1).to eql(@user)
      end
    end
  end
end
