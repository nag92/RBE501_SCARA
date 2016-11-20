function [ output_args ] = camera( port,name )
%{
   CAMERA grabs the image from a camera and saves it to a jpeg
   port: ID of camera
   name: sting to name image

%}
  cam = webcam(port);
  image= snapshot(cam);
  imshow(image)
  save('image','name')
    

end

