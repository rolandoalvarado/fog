module Fog
  module Storage
    class Openstack
      class Real

        # Delete an existing container
        #
        # ==== Parameters
        # * container<~String> - Name of container to delete
        # * object<~String> - Name of object to delete
        #
        def delete_object(container, object)
          request(
            :expects  => 204,
            :method   => 'DELETE',
            :path     => "#{Fog::Openstack.escape(container)}/#{Fog::Openstack.escape(object)}"
          )
        end

      end
    end
  end
end
