function [f] = features(data)
T=data;
x_values=T(:,1);
y_values=T(:,2);
time=T(:,3);
x_values(x_values==0)=[];
y_values(y_values==0)=[];
time(time==0)=[];
%cosine and sine of the initial angle
f1=(x_values(3)-x_values(1))/(sqrt((x_values(3)-x_values(1))^2+(y_values(3)-y_values(1))^2));
f2=(y_values(3)-y_values(1))/(sqrt((x_values(3)-x_values(1))^2+(y_values(3)-y_values(1))^2));
x_max=max(x_values);
y_max=max(y_values);
x_min=min(x_values);
y_min=min(y_values);
% calculating the values for bounding box diagonal
f3=sqrt((x_max-x_min)^2+(y_max-y_min)^2);
f4=atan((y_max-y_min)/(x_max-x_min));
%calculating the line from initial point to the final point
f5=sqrt((x_values(end)-x_values(1))^2+(y_values(end)-y_values(1))^2);
f6=(x_values(end)-x_values(1))/f5;
f7=(y_values(end)-y_values(1))/f5;
%calculating the total gesture length and stuff pertaining to that
delta_x=x_values(2:end)-x_values(1:end-1);
delta_y=y_values(2:end)-y_values(1:end-1);
delta_t=time(2:end)-time(1:end-1);
% delta_x=(2:end)-dX(1:end-1);
% delta_y=dY(2:end)-dY(1:end-1);
% delta_t=dT(2:end)-dT(1:end-1);
f8=sum(sqrt(delta_x.^2+delta_y.^2));
theta_p=atan((delta_x(2:end).*delta_y(1:end-1)-delta_x(1:end-1).*delta_y(2:end))./(delta_x(2:end).*delta_x(1:end-1)+delta_y(1:end-1).*delta_y(2:end)));
f9=sum(theta_p);
f10=sum(abs(theta_p));
f11=sumsqr(theta_p);
f12=max(((delta_x).^2+(delta_y).^2)./delta_t.^2);
f13=time(end)-time(1);
f=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13];

