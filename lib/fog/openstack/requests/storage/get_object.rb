module Fog
  module Storage
    class Openstack
      class Real

        # Get details for object
        #
        # ==== Parameters
        # * container<~String> - Name of container to look in
        # * object<~String> - Name of object to look for
        #
        def get_object(container, object, &block)
          request({
            :block    => block,
            :expects  => 200,
            :method   => 'GET',
            :path     => "#{Fog::Openstack.escape(container)}/#{Fog::Openstack.escape(object)}"
          }, false, &block)
        end

      end
    end
  end
end
