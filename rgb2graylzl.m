close all
clear all
clc
k=0.5;
i=imread('F:\梁泽浪\毕业设计\毕业设计二期工作（算法设计，验证，硬件平台了解）\算法处理验证图库\72\1.bmp');
j=rgb2gray(i);
r=i;
r(:,:,2)=0;
r(:,:,3)=0;
ri=imadjust(r,[0.5 0.8],[0 1],k);
%ri=imadjust(r);
g=i;
g(:,:,1)=0;
g(:,:,3)=0;
gi=imadjust(g,[0.3 0.5],[0 1],k);
b=i;
b(:,:,2)=0;
b(:,:,1)=0;
bi=imadjust(b,[0.3 0.5],[0 1],k);
rgb=r(:,:,1)*0.5+g(:,:,2)*0.6+b(:,:,3)*0.2;  %此处可以调整灰度化的参数
set(0,'defaultFigurePosition',[100,100,1000,500]);
set(0,'defaultFigureColor',[1,1,1]);
figure(1);
subplot(1,2,1),imshow(r);
subplot(1,2,2),imshow(ri);
figure(2);
subplot(1,2,1),imshow(g);
subplot(1,2,2),imshow(gi);
figure(3);
subplot(1,2,1),imshow(b);
subplot(1,2,2),imshow(bi);
figure(4);
subplot(1,2,1),imshow(j);
subplot(1,2,2),imshow(rgb);