%Reading the picture
I=imread("fail_ex.jpg");

%Taking the mean of the R, G and B channels to estimate the illuminant
%according to the grey-world model
illumination=mean(I,[1 2]);

%Putting these values in a vector

%First in the RGB color space
illumination_rgb=[0 0 0];
illumination_rgb(1)=illumination(1,1,1);
illumination_rgb(2)=illumination(1,1,2);
illumination_rgb(3)=illumination(1,1,3);

%Converting to XYZ color space, because the next part of the algorith uses that space 
illumination_XYZ1=rgb2xyz(illumination_rgb);
illumination_XYZ=illumination_XYZ1/illumination_XYZ1(2)*100; %Scaling the Y value to 100

%Initallizing the transformation matrix of the von Kries model (http://www.brucelindbloom.com/index.html?Eqn_ChromAdapt.html)
M_vk=[[0.4002400  0.7076000 -0.0808100];
    [-0.2263000  1.1653200  0.0457000];
    [0.0000000  0.0000000  0.9182200]];

%Transformating the source and the destination XYZ coordinates to the cone
%space
cone_source=M_vk*(illumination_XYZ)';
cone_destination=M_vk*[95.047;100;108.883]; %Reference D65 white light

%Now we can compute the M matrix
M=inv(M_vk)*diag(cone_destination./cone_source)*M_vk;

%Transforming the original image to XYZ coordinates
I_xyz=rgb2xyz(I);

%Transformating the XYZ values of all pixels via the M matrix
result=I_xyz;
[row,column,a]=size(result);
for i=1:row
    for j=1:column %i and j denotes the rows and columns
        for k=1:3  %denotes the X, Y, Z values of the pixel (i,j)
            result(i,j,k)=0;
            for l=1:3 %l is a dummy index for the summation 
               result(i,j,k)=result(i,j,k)+M(k,l)*I_xyz(i,j,l); %(X',Y',Z')=M(X,Y,Z)
            end
        end
    end
end

%Plotting
subplot(1,2,1)
imshow(I);
title('Original');

subplot(1,2,2)
imshow(result);
title('Corrected');



