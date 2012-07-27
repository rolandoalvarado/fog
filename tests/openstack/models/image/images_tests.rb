Shindo.tests("Fog::Image[:openstack] | images", ['openstack']) do
  @instance = Fog::Image[:openstack].create_image({:name => "model test image"}).body

  tests('success') do
    tests('#find_by_id').succeeds do
      pending
      image = Fog::Image[:openstack].images.find_by_id(@instance['image']['id'])
      image.id == @instance['image']['id']
    end

    tests('#destroy').succeeds do
      pending
      Fog::Image[:openstack].images.destroy(@instance['image']['id'])
    end
  end
end
