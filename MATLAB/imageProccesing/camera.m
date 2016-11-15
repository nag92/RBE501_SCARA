function [ output_args ] = camera( port,name )
%CAMERA Summary of this function goes here
%   Detailed explanation goes here
   cam = webcam(port);
  image= snapshot(cam);
  imshow(image)
  save('image','name')
    

end

