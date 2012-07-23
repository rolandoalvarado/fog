# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

if ENV["FOG_MOCK"] == "true"
  Fog.mock!
end

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :local_root                       => '~/.fog',
#    :public_key_path                  => '~/.ssh/id_rsa.pub',
#    :private_key_path                 => '~/.ssh/id_rsa',
    :openstack_api_key                => 'openstack_api_key',
    :openstack_username               => 'openstack_username',
    :openstack_tenant                 => 'openstack_tenant',
    :openstack_auth_url               => 'http://openstack:35357/v2.0/tokens',
  }
end
