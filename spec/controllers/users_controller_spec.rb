require 'spec_helper'

describe UsersController do
  before(:each) do
    activate_authlogic
  end

  it "should let a member view their own page" do
    user = Factory(:member_user)
    farm = Factory(:farm)
    Factory(:subscription, :farm => farm, :member => user.member)
    UserSession.create user
    get :show, :id => user.member.id, :farm_id => farm.id
    response.should be_success
    response.should render_template('home')
  end

  it "should deny a non-admin member from seeing the index of users" do
    user = Factory(:member_user)
    UserSession.create user
    get :index
    response.should render_template('home/access_denied')
  end

  it "should allow an admin to see the index" do
    admin = Factory(:admin_user)
    UserSession.create admin
    get :index, :farm_id => Factory(:farm).id
    response.should render_template('index')
  end

  it "should only have users from the specified farm in index" do
    admin = Factory(:admin_user)
    UserSession.create admin

    farm1 = Factory(:farm_with_members)
    farm2 = Factory(:farm_with_members)

    get :index, :farm_id => farm1.id

    assigns(:users).each do |user|
      user.member.farms.include?(farm1).should == true
    end
  end

  it "should assign a subscription when rendering home" do
    farm = Factory(:farm)
    member = Factory(:member)
    user = Factory(:member_user, :member => member)
    sub = Factory(:subscription, :member => member, :farm => farm)

    UserSession.create user
    get :show, :farm_id => farm.id, :id => user.id

    response.should  render_template('users/home')
    assigns(:subscription).should == sub
    
  end

  it "should let members only edit their own user profile" do
    member = Factory(:member_user)
    UserSession.create member
    get :edit, :id => member.id
    assigns(:user).should == member

    get :edit, :id => 34
    assigns(:user).should == member

  end

  it "should allow admins to edit any user profile" do
    admin = Factory(:admin_user)
    UserSession.create admin
    member = Factory(:member_user)

    get :edit, :id => member.id
    assigns(:user).should == member

  end

end