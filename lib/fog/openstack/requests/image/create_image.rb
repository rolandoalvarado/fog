module Fog
  module Image
    class OpenStack
      class Real

        def create_image(attributes)


          data = {
              'Content-Type'=>'application/octet-stream',
              'x-image-meta-name' => attributes[:name],
              'x-image-meta-disk-format' => attributes[:disk_format],
              'x-image-meta-container-format' => attributes[:container_format],
              'x-image-meta-size' => attributes[:size],
              'x-image-meta-is-public' => attributes[:is_public],
              'x-image-meta-min-ram'  => attributes[:min_ram],
              'x-image-meta-min-disk' => attributes[:min_disk],
              'x-image-meta-checksum' => attributes[:checksum],
              'x-image-meta-owner' => attributes[:owner],
              'x-glance-api-copy-from' => attributes[:copy_from]
          }

          body = String.new
          if attributes[:location]
            file = File.open(attributes[:location], 'rb')
            body = file.read
          end

          unless attributes[:properties].nil?
            attributes[:properties].each do |key,value|
              data['x-image-meta-property-#{key}'] = value
            end
          end

          #TODO: Edit this once https://bugs.launchpad.net/glance/+bug/1008874 is fixed

          upload_thread = Thread.new {
            request(
              :headers     => data,
              :body     => body,
              :expects  => 201,
              :method   => 'POST',
              :path     => 'images'
            )
          }

          upload_thread.abort_on_exception = true

          sleep 2

          images = request(
            :expects => [200, 204],
            :method  => 'GET',
            :path    => 'images'
          ).body['images']

          response = Excon::Response.new
          response.status = 201
          response.body = {'image' => images.select { |image| image['name'] == attributes[:name] }.first}
          response
        end

      end

      class Mock

        def create_image(attributes)
          response = Excon::Response.new
          response.status = 201
          response.body = {
                            'image'=> {
                              'name'             => attributes['name'],
                              'size'             => Fog::Mock.random_numbers(8).to_i,
                              'min_disk'         => 0,
                              'disk_format'      => attributes['disk_format'],
                              'created_at'       => Time.now.to_s,
                              'container_format' => attributes['container_format'],
                              'deleted_at'       => nil,
                              'updated_at'       => Time.now.to_s,
                              'checksum'         => Fog::Mock.random_hex(32),
                              'id'               => Fog::Mock.random_hex(32),
                              'deleted'          => false,
                              'protected'        => false,
                              'is_public'        => false,
                              'status'           => 'queued',
                              'min_ram'          => 0,
                              'owner'            => attributes['owner'],
                              'properties'       => attributes['properties']
                            }
                          }
          response
        end
      end
    end
  end
end
