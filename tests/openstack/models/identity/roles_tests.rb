Shindo.tests("Fog::Identity[:openstack] | roles", ['openstack']) do
  @tenant   = Fog::Identity[:openstack].tenants.create(:name => 'test_user')
  @user     = Fog::Identity[:openstack].users.create(:name => 'test_user', :tenant_id => @tenant.id, :password => 'spoof')
  @role     = Fog::Identity[:openstack].roles(:user => @user, :tenant => @tenant).create(:name => 'test_role')
  @roles    = Fog::Identity[:openstack].roles(:user => @user, :tenant => @tenant)

  tests('success') do
    tests('#all').succeeds do
      pending
      @roles.all
    end

    tests('#get').succeeds do
      pending
      @roles.get @roles.first.id
    end
  end

  @user.destroy
  @tenant.destroy
end
