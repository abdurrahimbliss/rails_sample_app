require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example user", email: "example@mail.com", password: "abcdef", password_confirmation: "abcdef" )}

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present it should not be valid" do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should not be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example user", email: "example@mail.com",
                        password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when password confirmation mismatches" do
    before { @user.password_confirmation = 'mismatch' }

    it { should_not be_valid }
  end

  describe "return value of authentication method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:invalid_password_result) { found_user.authenticate("invalidpassword") }
      it { should_not eq invalid_password_result }
      specify { expect(invalid_password_result).to be_false }
    end
  end

  describe "email with mixed cases" do
    let(:mixed_case_email) { 'fOOl@Example.com' }

    it "should be saved as all lower case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
end
