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
global_temp=0;     %ȫ��temp�����ڰ�ԭʼ����������ͽǵ������������
ad_temp=0;         %���ڵ�����tempֵ

End_flag=0;
end_flag=0;
rule_flag=0;

ii=imread('F:\������\��ҵ���\��ҵ��ƶ��ڹ������㷨��ƣ���֤��Ӳ��ƽ̨�˽⣩\�㷨������֤ͼ��\72\12.bmp');%F:\������\��ҵ���\��ҵ��ƶ��ڹ������㷨��ƣ���֤��Ӳ��ƽ̨�˽⣩\�㷨������֤ͼ��\72\
i=imrotate(ii,-90);
j=rgb2gray(i);   %ȡ��ͼ��ĻҶ�ͼ
bw_level=graythresh(j)
BW=im2bw(j,bw_level);
BW4=im2bw(j,0.4);
%%%%%%%%%    �ԻҶ�ͼ������˲�
K1=filter2(fspecial('average',3),j)/255;   %�ԻҶ�ͼ����3*3�ľ�ֵ�˲�

BWK14=im2bw(K1,bw_level);        %0.4Ч������   0.35�Ϻ�
BWK14K3=medfilt2(BWK14,[3,3]);
BWK14K5=medfilt2(BWK14,[3,3]);
BWK14K7=medfilt2(BWK14,[3,3]);


K2=filter2(fspecial('average',7),j)/255;    %7*7
  
bw_level1=bw_level-0.05;
key5=im2bw(K2,0.37);  
%key5=edge(BWK24,'canny');
figure,imshow(key5);


for m=640:-1:1   %�ҵ���ʼ��    key5(y,x)  640*480  ��*��
    
    for n=1:1:480
           if(key5(m,n)==1) %���ͼ��Ϊbai�㱣��   
                 global_temp=global_temp+1;
                 arrx(h)=n;
                 arry(h)=m;
                 h=h+1;
                 rule_flag=1;      %������־λ
                 End_flag=1;

           end
           
           if(End_flag==1)
             break;    %���break������n��forѭ��         
           end
           
    end
    
    if(End_flag==1)
             break;    %���break������m��forѭ��         
    end
end

%%%  m,nΪ��ʼ�����������
%����������������
%End_flag ������־λ  0 ����  1 ����
%rule_flag ���������־λ  1 �������� 2 ��������
%dir_flag  �����־λ 1 ���� 2 ���� 3 ���� 4 ����
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
                        
                    else              %�������������������û������������ô���� ���ӳ�����������
                        %temp=temp+1;
                        %if(temp==6)     %������������ӳ�������û�У����������Ϊ��ֵ�㣬����������������
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
                 
    elseif(rule_flag==2)        %��������
        while rule_flag==2   % ԭ������������ name��  lzl
            %�޸Ŀ�ʼ
            if((key5(m,n+temp)==1)&&((m~=m_temp)||(n+temp~=n_temp)))%����
                 global_temp=h;
                arry(h)=m;
                 arrx(h)=n+temp;
                 h=h+1;
                 m_temp=m;n_temp=n;
                 n=n+temp;  
                 if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %���б���У���Ϊ����   ����¼���˳�                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
               
             elseif((key5(m+temp,n)==1)&&(((m+temp)~=m_temp)||(n~=n_temp)))   %��������
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n;
                h=h+1;
                m_temp=m;n_temp=n;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %���б���У���Ϊ����   ����¼���˳�                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
                 
             elseif((key5(m,n-temp)==1)&&((m~=m_temp)||(n-temp~=n_temp)))%����
                global_temp=h;
                arry(h)=m;
                arrx(h)=n-temp;
                 h=h+1;
                 m_temp=m;n_temp=n;
                 n=n-temp;
                 if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %���б���У���Ϊ����   ����¼���˳�                   
                        key_ypoint(tem)=m;
                        key_xpoint(tem)=n;
                        global_number(tem)=global_temp;
                        tem=tem+1;
                        rule_flag=1;
                 end
            elseif((key5(m+temp,n+temp)==1)&&((m+temp~=m_temp)||(n+temp~=n_temp)))%������
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n+temp;
                h=h+1;
                m_temp=m;n_temp=n;
                n=n+temp;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %���б���У���Ϊ����   ����¼���˳�                   
                    key_ypoint(tem)=m;
                    key_xpoint(tem)=n;
                    global_number(tem)=global_temp;
                    tem=tem+1;
                    rule_flag=1;
                end
            elseif((key5(m+temp,n-temp)==1)&&((m+temp~=m_temp)||(n-temp~=n_temp)))%������
                global_temp=h;
                arry(h)=m+temp;
                arrx(h)=n-temp;
                h=h+1;
                m_temp=m;n_temp=n;
                n=n-temp;
                m=m+temp;
                if((key5(m-temp,n+temp)==1)&&(key5(m,n+temp)==1)&&(key5(m,n+temp+temp)==1)&&(key5(m-temp,n+temp+temp)==1)) %���б���У���Ϊ����   ����¼���˳�                   
                    key_ypoint(tem)=m;
                    key_xpoint(tem)=n;
                    global_number(tem)=global_temp;
                    tem=tem+1;
                    rule_flag=1;
                end
             
             end
            %�޸Ľ���
        end      
    end     %�ж�rule_flag �������ϻ������£�ÿ�ж�һ�ξͰ����������־λ��1   ����11���˳�ѭ������
    end_flag=end_flag+1;
    if(end_flag==10)
        End_flag=0;
        rule_flag=0;
    end
end


%%%   �ǵ��ٴ���

%Adjust_x ,Adjust_y
%arrx  ,arry


    for x=1:1:9
      for y=0:18
         if(arry(global_number(x)-y)==arry(global_number(x))&&(key5(arry(global_number(x)-y)-1,arrx(global_number(x)-y))~=1))
             ad_temp=ad_temp+1;
         else
             Adjust_x(x)=arrx(global_number(x)-round((ad_temp-1)/2));
             Adjust_y(x)=arry(global_number(x));      %�ҵ��µĽǵ�
             ad_temp=0;
             break;
         end
      end
      
    end
    
 

   
    
%%%%  �ǵ㾫ȷ

%��1���ǵ�   v

final_x(1)=Adjust_x(1);
final_y(1)=Adjust_y(1);

%��2���ǵ�   ���
rule_flag=0;
for y=1:5
     if((arry(global_number(2)-y)-arry(global_number(2)-y-10))>=8)     %��2���ǵ����������� ��ȷ�ǵ�
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

%��3���ǵ�
rule_flag=0;
for y=1:35
     if((arry(global_number(2)+y)-arry(global_number(2)+y+10))>=8)     %��3���ǵ����������� ��ȷ�ǵ�
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

%��4���ǵ�

final_x(4)=Adjust_x(3);
final_y(4)=Adjust_y(3);

%��5���ǵ�
rule_flag=0;
for y=1:35
     if((arry(global_number(4)-y)-arry(global_number(4)-y-10))>=8)     %��2���ǵ����������� ��ȷ�ǵ�
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

%��6���ǵ�
rule_flag=0;
for y=1:35
     if((arry(global_number(4)+y)-arry(global_number(4)+y+10))>=8)     %��3���ǵ����������� ��ȷ�ǵ�
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


%��7���ǵ�

final_x(7)=Adjust_x(5);
final_y(7)=Adjust_y(5);

%��8���ǵ�
rule_flag=0;
for y=1:35
     if((arry(global_number(6)-y)-arry(global_number(6)-y-10))>=8)     %��2���ǵ����������� ��ȷ�ǵ�
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


%��9���ǵ�
rule_flag=0;
for y=1:35
     if((arry(global_number(6)+y)-arry(global_number(6)+y+10))>=8)     %��3���ǵ����������� ��ȷ�ǵ�
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

%��10���ǵ�

final_x(10)=Adjust_x(7);
final_y(10)=Adjust_y(7);



%2015.05.06�޸�
%��Ҫ���ҵ�����ָ����ֵ��1/2�Ŀ��

%����ָ

End_flag=1; 
k=1;
ring_height=round((final_y(4)+final_y(3))/2);   %����ָ�ĸ߶�   finger_ring
while End_flag==1   
    if(arry(global_number(3)-k)==ring_height)    %�� ����ǰ��
        finger_ring_y(1)=arry(global_number(3)-k);
        finger_ring_x(1)=arrx(global_number(3)-k);
        End_flag=0;
    end
    k=k+1;
end


End_flag=1;
k=1;
ring_height=round((final_y(5)+final_y(4))/2);   %����ָ�ĸ߶�   finger_ring
while End_flag==1   
    if(arry(global_number(3)+k)==ring_height)     %�� ��������
        finger_ring_y(2)=arry(global_number(3)+k);
        finger_ring_x(2)=arrx(global_number(3)+k);
        End_flag=0;
    end
    k=k+1;
end


%��ָ

End_flag=1; 
k=1;
ring_height=round((final_y(6)+final_y(7))/2);   %����ָ�ĸ߶�   finger_ring
while End_flag==1   
    if(arry(global_number(5)-k)==ring_height)    %�� ����ǰ��
        finger_middle_y(1)=arry(global_number(5)-k);
        finger_middle_x(1)=arrx(global_number(5)-k);
        End_flag=0;
    end
    k=k+1;
end


End_flag=1;
k=1;
ring_height=round((final_y(7)+final_y(8))/2);   %����ָ�ĸ߶�   finger_ring
while End_flag==1   
    if(arry(global_number(5)+k)==ring_height)     %�� ��������
        finger_middle_y(2)=arry(global_number(5)+k);
        finger_middle_x(2)=arrx(global_number(5)+k);
        End_flag=0;
    end
    k=k+1;
end

    
    


figure,
subplot(2,3,1),imshow(i);  %ԭͼ
subplot(2,3,2),imshow(j);  %�Ҷ�ͼ
subplot(2,3,3),imshow(BW); %��ֵ��ͼ


figure, imshow(key5);title('7*7��ֵ0.35');  
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


%ʶ���㷨�����
L1=sqrt((final_y(2)-final_y(1))^2+(final_x(2)-final_x(1))^2);%Сָ ָͷ��Сָ�Ҳ�ָ��
L2=sqrt((final_y(3)-final_y(4))^2+(final_x(4)-final_x(3))^2);%����ָ ָͷ��ָ���ָ��
L3=sqrt((final_y(5)-final_y(4))^2+(final_x(5)-final_x(4))^2);%����ָ ָͷ��ָ�Ҳ�ָ��
L4=sqrt((final_y(6)-final_y(7))^2+(final_x(7)-final_x(6))^2);%��ָ ָͷ��ָ���ָ��
L5=sqrt((final_y(8)-final_y(7))^2+(final_x(8)-final_x(7))^2);%��ָ ָͷ��ָ�Ҳ�ָ��
L6=sqrt((final_y(9)-final_y(10))^2+(final_x(10)-final_x(9))^2);%ʵָ ָͷ��ָ���ָ��

W1=sqrt((finger_ring_x(1)-finger_ring_x(2))^2+(finger_ring_y(1)-finger_ring_y(2))^2);%����ָ���м䳤��
W2=sqrt((finger_middle_x(1)-finger_middle_x(2))^2+(finger_middle_y(1)-finger_middle_y(2))^2);%����ָ���м䳤��



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








