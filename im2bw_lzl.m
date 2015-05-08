close all
clear all
clc

arrx=zeros(2840,1);arry=zeros(2840,1);
key_xpoint=zeros(10,1);key_ypoint=zeros(10,1);
global_number=zeros(10,1);
Adjust_x=zeros(8,1);Adjust_y=zeros(8,1);
final_x=zeros(10,1);final_y=zeros(10,1);
finger_ring_x=zeros(2,1); finger_ring_y=zeros(2,1); 
finger_middle_x=zeros(2,1); finger_middle_y=zeros(2,1);

h=1;g=1;

tem=1;
temp=1;
m_temp=0;
n_temp=0;
global_temp=0;     %全局temp，用于把原始轮廓链矩阵和角点矩阵连接起来
ad_temp=0;         %用于调整的temp值

End_flag=0;
end_flag=0;
rule_flag=0;

ii=imread('F:\梁泽浪\毕业设计\毕业设计二期工作（算法设计，验证，硬件平台了解）\算法处理验证图库\72\12.bmp');%F:\梁泽浪\毕业设计\毕业设计二期工作（算法设计，验证，硬件平台了解）\算法处理验证图库\72\
i=imrotate(ii,-90);
j=rgb2gray(i);   %取得图像的灰度图
bw_level=graythresh(j)
BW=im2bw(j,bw_level);
BW4=im2bw(j,0.4);
%%%%%%%%%    对灰度图像进行滤波
K1=filter2(fspecial('average',3),j)/255;   %对灰度图进行3*3的均值滤波

BWK14=im2bw(K1,bw_level);        %0.4效果还行   0.35较好
BWK14K3=medfilt2(BWK14,[3,3]);
BWK14K5=medfilt2(BWK14,[3,3]);
BWK14K7=medfilt2(BWK14,[3,3]);


K2=filter2(fspecial('average',7),j)/255;    %7*7
  
bw_level1=bw_level-0.05;
key5=im2bw(K2,0.37);  
%key5=edge(BWK24,'canny');
figure,imshow(key5);


for m=640:-1:1   %找到起始点    key5(y,x)  640*480  行*列
    
    for n=1:1:480
           if(key5(m,n)==1) %如过图像为bai点保存   
                 global_temp=global_temp+1;
                 arrx(h)=n;
                 arry(h)=m;
                 h=h+1;
                 rule_flag=1;      %搜索标志位
                 End_flag=1;

           end
           
           if(End_flag==1)
             break;    %这个break是跳出n的for循环         
           end
           
    end
    
    if(End_flag==1)
             break;    %这个break是跳出m的for循环         
    end
end

%%%  m,n为起始点的像素坐标
%整个的搜索规则是
%End_flag 结束标志位  0 结束  1 继续
%rule_flag 搜索规则标志位  1 向上搜索 2 向下搜索
%dir_flag  方向标志位 1 向上 2 向左 3 向右 4 向下
while End_flag==1
    if(rule_flag==1)    %up
             while rule_flag==1    
                     if((key5(m,n-temp)==1)&&((m ~= m_temp)||((n-temp)~=n_temp)))
                        global_temp=h;
                        arry(h)=m;
                        arrx(h)=n-temp;
                        h=h+1;
                        m_temp=m;n_temp=n;
                        n=n-temp;                          
                    elseif((key5(m-temp,n)==1)&&(((m-temp)~=m_temp)||(n~=n_temp)))
                        global_temp=h;
                        arrx(h)=n;
                        arry(h)=m-temp;
                        h=h+1;
                        m_temp=m;n_temp=n;
                        m=m-temp;                 
                    elseif((key5(m,n+temp)==1)&&((m~=m_temp)||((n+temp)~=n_temp)))
                        global_temp=h;
                        arry(h)=m;
                        arrx(h)=n+temp;
                        h=h+1;
                        m_temp=m;n_temp=n;
                        n=n+temp;                        
                    elseif((key5(m-temp,n-temp)==1)&&(((m-temp)~=m_temp)||((n-temp)~=n_temp)))
                        global_temp=h;
                        arry(h)=m-temp;
                        arrx(h)=n-temp;
                        h=h+1;
                        m_temp=m;n_temp=n;
                        n=n-temp;m=m-temp;
                        
                    elseif((key5(m-temp,n+temp)==1)&&(((m-temp)~=m_temp)||((n+temp)~=n_temp)))
                        global_temp=h;
                        arry(h)=m-temp;
                        arrx(h)=n+temp;
                        h=h+1;
                        m_temp=m;n_temp=n;
                        n=n+temp;m=m-temp;
                        
                    else              %如果搜索规则三个方向都没有搜索到，那么进入 ’延长搜索规则‘中
                        %temp=temp+1;
                        %if(temp==6)     %如果三个方向延长搜索都没有，则视这个点为极值点，并保存至行向量中
                        %    key_ypoint(tem)=m;
                         %   key_xpoint(tem)=n;
                          %  tem=tem+1;
                           % rule_flag=2;                            
                        %end
                         key_ypoint(tem)=m;
                         key_xpoint(tem)=n;
                         global_number(tem)=global_temp;
                         tem=tem+1;
                         rule_flag=2;         
                            
                    end
                     
             end
                 
    elseif(rule_flag==2)        %向下搜索
        while rule_flag==2   % 原程序至于桌面 name：  lzl
            %修改开始
            if((key5(m,n+temp)==1)&&((m~=m_temp)||(n+temp~=n_temp)))%向右
                 global_temp=h;
                arry(h)=m;
                 arrx(h)=n+temp;
                 h=h+1;
                 m_temp=m;n_temp=n;
                 n=n+temp;  
                 if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %如果斜上有，则为极点   ，记录并退出                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
               
             elseif((key5(m+temp,n)==1)&&(((m+temp)~=m_temp)||(n~=n_temp)))   %向下搜索
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n;
                h=h+1;
                m_temp=m;n_temp=n;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %如果斜上有，则为极点   ，记录并退出                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
                 
             elseif((key5(m,n-temp)==1)&&((m~=m_temp)||(n-temp~=n_temp)))%向左
                global_temp=h;
                arry(h)=m;
                arrx(h)=n-temp;
                 h=h+1;
                 m_temp=m;n_temp=n;
                 n=n-temp;
                 if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %如果斜上有，则为极点   ，记录并退出                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
            elseif((key5(m+temp,n+temp)==1)&&((m+temp~=m_temp)||(n+temp~=n_temp)))%向右下
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n+temp;
                h=h+1;
                m_temp=m;n_temp=n;
                n=n+temp;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %如果斜上有，则为极点   ，记录并退出                   
                    key_ypoint(tem)=m;
                    key_xpoint(tem)=n;
                    global_number(tem)=global_temp;
                    tem=tem+1;
                    rule_flag=1;
                end
            elseif((key5(m+temp,n-temp)==1)&&((m+temp~=m_temp)||(n-temp~=n_temp)))%向左下
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n-temp;
                h=h+1;
                m_temp=m;n_temp=n;
                n=n-temp;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %如果斜上有，则为极点   ，记录并退出                   
                    key_ypoint(tem)=m;
                    key_xpoint(tem)=n;
                    global_number(tem)=global_temp;
                    tem=tem+1;
                    rule_flag=1;
                end
             
             end
            %修改结束
        end      
    end     %判断rule_flag ，是向上还是向下，每判断一次就把整体结束标志位加1   ，到11就退出循环搜索
    end_flag=end_flag+1;
    if(end_flag==10)
        End_flag=0;
        rule_flag=0;
    end
end


%%%   角点再处理

%Adjust_x ,Adjust_y
%arrx  ,arry


    for x=1:1:9
      for y=0:18
         if(arry(global_number(x)-y)==arry(global_number(x))&&(key5(arry(global_number(x)-y)-1,arrx(global_number(x)-y))~=1))
             ad_temp=ad_temp+1;
         else
             Adjust_x(x)=arrx(global_number(x)-round((ad_temp-1)/2));
             Adjust_y(x)=arry(global_number(x));      %找到新的角点
             ad_temp=0;
             break;
         end
      end
      
    end
    
 

   
    
%%%%  角点精确

%第1个角点   v

final_x(1)=Adjust_x(1);
final_y(1)=Adjust_y(1);

%第2个角点   左边
rule_flag=0;
for y=1:5
     if((arry(global_number(2)-y)-arry(global_number(2)-y-10))>=8)     %第2个角点是向左搜索 精确角点
         final_y(2)=arry(global_number(2)-y); 
         final_x(2)=arrx(global_number(2)-y);
         rule_flag=rule_flag+1;
         break;   
     end     
end
if(rule_flag==0)
    final_x(2)=Adjust_x(2);
    final_y(2)=Adjust_y(2);
end 

%第3个角点
rule_flag=0;
for y=1:35
     if((arry(global_number(2)+y)-arry(global_number(2)+y+10))>=8)     %第3个角点是向左搜索 精确角点
         final_y(3)=arry(global_number(2)+y); 
         final_x(3)=arrx(global_number(2)+y);
         rule_flag=rule_flag+1;
         break;
     end    
end
if(rule_flag==0)
    final_x(3)=Adjust_x(2);
    final_y(3)=Adjust_y(2);
end

%第4个角点

final_x(4)=Adjust_x(3);
final_y(4)=Adjust_y(3);

%第5个角点
rule_flag=0;
for y=1:35
     if((arry(global_number(4)-y)-arry(global_number(4)-y-10))>=8)     %第2个角点是向左搜索 精确角点
         final_y(5)=arry(global_number(4)-y); 
         final_x(5)=arrx(global_number(4)-y);
         rule_flag=rule_flag+1;
         break;
     end    
end
if(rule_flag==0)
    final_x(5)=Adjust_x(4);
    final_y(5)=Adjust_y(4);
end

%第6个角点
rule_flag=0;
for y=1:35
     if((arry(global_number(4)+y)-arry(global_number(4)+y+10))>=8)     %第3个角点是向左搜索 精确角点
         final_y(6)=arry(global_number(4)+y); 
         final_x(6)=arrx(global_number(4)+y);
         rule_flag=rule_flag+1;
         break;
     end    
end
if(rule_flag==0)
    final_x(6)=Adjust_x(4);
    final_y(6)=Adjust_y(4);
end


%第7个角点

final_x(7)=Adjust_x(5);
final_y(7)=Adjust_y(5);

%第8个角点
rule_flag=0;
for y=1:35
     if((arry(global_number(6)-y)-arry(global_number(6)-y-10))>=8)     %第2个角点是向左搜索 精确角点
         final_y(8)=arry(global_number(6)-y); 
         final_x(8)=arrx(global_number(6)-y);
         rule_flag=rule_flag+1;
         break;
     end    
end

if(rule_flag==0)
    final_x(8)=Adjust_x(6);
    final_y(8)=Adjust_y(6);
end


%第9个角点
rule_flag=0;
for y=1:35
     if((arry(global_number(6)+y)-arry(global_number(6)+y+10))>=8)     %第3个角点是向左搜索 精确角点
         final_y(9)=arry(global_number(6)+y); 
         final_x(9)=arrx(global_number(6)+y);
         rule_flag=rule_flag+1;
         break;
     end    
end
if(rule_flag==0)
    final_x(9)=Adjust_x(6);
    final_y(9)=Adjust_y(6);
end

%第10个角点

final_x(10)=Adjust_x(7);
final_y(10)=Adjust_y(7);



%2015.05.06修改
%主要是找到无名指和中值的1/2的宽度

%无名指

End_flag=1; 
k=1;
ring_height=round((final_y(4)+final_y(3))/2);   %无名指的高度   finger_ring
while End_flag==1   
    if(arry(global_number(3)-k)==ring_height)    %减 是往前走
        finger_ring_y(1)=arry(global_number(3)-k);
        finger_ring_x(1)=arrx(global_number(3)-k);
        End_flag=0;
    end
    k=k+1;
end


End_flag=1;
k=1;
ring_height=round((final_y(5)+final_y(4))/2);   %无名指的高度   finger_ring
while End_flag==1   
    if(arry(global_number(3)+k)==ring_height)     %加 是往后走
        finger_ring_y(2)=arry(global_number(3)+k);
        finger_ring_x(2)=arrx(global_number(3)+k);
        End_flag=0;
    end
    k=k+1;
end


%中指

End_flag=1; 
k=1;
ring_height=round((final_y(6)+final_y(7))/2);   %无名指的高度   finger_ring
while End_flag==1   
    if(arry(global_number(5)-k)==ring_height)    %减 是往前走
        finger_middle_y(1)=arry(global_number(5)-k);
        finger_middle_x(1)=arrx(global_number(5)-k);
        End_flag=0;
    end
    k=k+1;
end


End_flag=1;
k=1;
ring_height=round((final_y(7)+final_y(8))/2);   %无名指的高度   finger_ring
while End_flag==1   
    if(arry(global_number(5)+k)==ring_height)     %加 是往后走
        finger_middle_y(2)=arry(global_number(5)+k);
        finger_middle_x(2)=arrx(global_number(5)+k);
        End_flag=0;
    end
    k=k+1;
end

    
    


figure,
subplot(2,3,1),imshow(i);  %原图
subplot(2,3,2),imshow(j);  %灰度图
subplot(2,3,3),imshow(BW); %二值化图


figure, imshow(key5);title('7*7均值0.35');  
hold on
plot(key_xpoint,key_ypoint,'r-.o');
hold on
plot(Adjust_x,Adjust_y,'g-.o');
hold on
plot(final_x,final_y,'b-.o');
hold on 
plot(finger_ring_x,finger_ring_y,'b-.o');
hold on 
plot(finger_middle_x,finger_middle_y,'b-.o');


%识别算法算距离
L1=sqrt((final_y(2)-final_y(1))^2+(final_x(2)-final_x(1))^2);%小指 指头到小指右侧指跟
L2=sqrt((final_y(3)-final_y(4))^2+(final_x(4)-final_x(3))^2);%无名指 指头到指左侧指跟
L3=sqrt((final_y(5)-final_y(4))^2+(final_x(5)-final_x(4))^2);%无名指 指头到指右侧指跟
L4=sqrt((final_y(6)-final_y(7))^2+(final_x(7)-final_x(6))^2);%中指 指头到指左侧指跟
L5=sqrt((final_y(8)-final_y(7))^2+(final_x(8)-final_x(7))^2);%中指 指头到指右侧指跟
L6=sqrt((final_y(9)-final_y(10))^2+(final_x(10)-final_x(9))^2);%实指 指头到指左侧指跟

W1=sqrt((finger_ring_x(1)-finger_ring_x(2))^2+(finger_ring_y(1)-finger_ring_y(2))^2);%无名指的中间长度
W2=sqrt((finger_middle_x(1)-finger_middle_x(2))^2+(finger_middle_y(1)-finger_middle_y(2))^2);%无名指的中间长度



L=(L1+L2+L3+L4+L5+L6)/6.0;

W=(W1+W2)/2.0;

SL1=L1/L2;
SL2=L2/L3;
SL3=L3/L4;
SL4=L4/L5;
SL5=L5/L6;
SL6=L6/L;

SW1=W1/W2;
SW2=W2/W;








