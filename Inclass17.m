%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 
img1=imread('img1.tif');
img2=imread('img2.tif');

subplot(1,2,1);imshow(img1,[]);
subplot(1,2,2);imshow(img2,[]);

diffs=zeros(100,100); 
for ov1=1:200
    for ov2=1:200
    pix1=img1((end-ov1):end,(end-ov2):end);
    pix2=img2(1:(1+ov1),1:(1+ov2)); 
    diffs(ov1,ov2)=sum(sum(abs(pix1-pix2)))/(ov1*ov2);
    end   
end 
figure; 
plot(diffs);


%% Fourier transformation
img1=imread('img1.tif');
img2=imread('img2.tif');
img1ft=fft2(img1); 
img2ft=fft2(img2); 
[nr,nc]=size(img2ft);
CC=ifft2(img1ft.*conj(img2ft));
CCabs=abs(CC);
figure; 
imshow(CCabs, []); 
[row, col]=find(CCabs==max(CCabs(:)));
Nr=ifftshift(-fix(nr/2):ceil(nr/2)-1); 
Nc=ifftshift(-fix(nc/2):ceil(nc/2)-1);
row=Nr(row);
col=Nc(col); 
imgshift=zeros(size(img2)+[800-rows,800-cols]);
imgshift((end-800)+1:end,(end-800)+1:end)=img2;
figure;
imshowpair(img1,imgshift);

