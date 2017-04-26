function [F, covar] = training(data)
F1=0;F6=0; F11=0;
F2=0;F7=0; F12=0;
F3=0;F8=0; F13=0;
F4=0;F9=0;
F5=0;F10=0;
F1c=[];F2c=[];F3c=[];F4c=[];F5c=[];F6c=[];F7c=[];
F8c=[];F9c=[];F10c=[];F11c=[];F12c=[];F13c=[];
for i=1:3:30  
T=data(:,i:i+2);
x_values=T(:,1);
y_values=T(:,2);
time=T(:,3);
x_values(x_values==0)=[];
y_values(y_values==0)=[];
time(time==0)=[];
%cosine and sine of the initial angle
f1=(x_values(3)-x_values(1))/(sqrt((x_values(3)-x_values(1))^2+(y_values(3)-y_values(1))^2));
F1= F1+f1;
F1c=cat(1,F1c,f1);
f2=(y_values(3)-y_values(1))/(sqrt((x_values(3)-x_values(1))^2+(y_values(3)-y_values(1))^2));
F2= F2+f2;
F2c=cat(1,F2c,f2);
x_max=max(x_values);
y_max=max(y_values);
x_min=min(x_values);
y_min=min(y_values);
% calculating the values for bounding box diagonal
f3=sqrt((x_max-x_min)^2+(y_max-y_min)^2);
F3= F3+f3;
F3c=cat(1,F3c,f3);
f4=atan((y_max-y_min)/(x_max-x_min));
F4= F4+f4;
F4c=cat(1,F4c,f4);
%calculating the line from initial point to the final point
f5=sqrt((x_values(end)-x_values(1))^2+(y_values(end)-y_values(1))^2);
F5= F5+f5;
F5c=cat(1,F5c,f5);
f6=(x_values(end)-x_values(1))/f5;
F6= F6+f6;
F6c=cat(1,F6c,f6);
f7=(y_values(end)-y_values(1))/f5;
F7= F7+f7;
F7c=cat(1,F7c,f7);
%calculating the total gesture length and stuff pertaining to that
dX=cumsum(x_values);
dY=cumsum(y_values);
dT=cumsum(time);
% delta_x=dX(2:end)-dX(1:end-1);
% delta_y=dY(2:end)-dY(1:end-1);
% delta_t=dT(2:end)-dT(1:end-1);

delta_x=x_values(2:end)-x_values(1:end-1);
delta_y=y_values(2:end)-y_values(1:end-1);
delta_t=time(2:end)-time(1:end-1);
f8=sum(sqrt(delta_x.^2+delta_y.^2));
F8= F8+f8;
F8c=cat(1,F8c,f8);
theta_p=atan((delta_x(2:end).*delta_y(1:end-1)-delta_x(1:end-1).*delta_y(2:end))./(delta_x(2:end).*delta_x(1:end-1)+delta_y(1:end-1).*delta_y(2:end)));
f9=sum(theta_p);
F9= F9+f9;
F9c=cat(1,F9c,f9);
f10=sum(abs(theta_p));
F10= F10+f10;
F10c=cat(1,F10c,f10);
f11=sumsqr(theta_p);
F11= F11+f11;
F11c=cat(1,F11c,f11);
f12=max(((delta_x).^2+(delta_y).^2)./delta_t.^2);
F12= F12+f12;
F12c=cat(1,F12c,f12);
f13=time(end)-time(1);
F13= F13+f13;
F13c=cat(1,F13c,f13);
end
F=[F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13];
F=F/10;
Fc=[F1c,F2c,F3c,F4c,F5c,F6c,F7c,F8c,F9c,F10c,F11c,F12c,F13c];   
covar = cov(Fc);






