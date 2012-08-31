module Fog
  module Compute
    class OpenStack
      class Real

        def get_quota(tenant_id)
          request(
            :expects  => 200,
            :method   => 'GET',
            :path     => "/os-quota-sets/#{tenant_id}"
          )
        end

      end

      class Mock

        def get_quota(tenant_id)
          response = Excon::Response.new
          response.status = 200
          response.body = {
            'quota_set' => {
              'cores' => 20,
              'floating_ips' => 10,
              'gigabytes' => 5000,
              'id' => tenant_id,
              'injected_file_content_bytes' => 10240,
              'injected_files' => 5,
              'instances' => 10,
              'metadata_items' => 128,
              'ram' => 51200,
              'security_group_rules' => 20,
              'security_groups' => 10,
              'volumes' => 10
            }
          }
          response
        end

      end

    end
  end
end
