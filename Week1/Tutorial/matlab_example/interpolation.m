% interpolation demo
% interp1 for 1-d interpolation
% interp2 for 2-d interpolation

x = 0:0.01:2*pi;    
y = sin(x);    
xx = 0:0.5:2*pi;    
  
% Linear Interpolation Example
y1 = interp1(x,y,xx,'linear');    
subplot(2,1,1);  
plot(x,y,'b',xx,y1,'r')    
title('Linear Interpolation')   
legend('real', 'interp')
    
% Linear Interpolation Example
y2 = interp1(x,y,xx,'nearest');    
subplot(2,1,2);  
plot(x,y,'b',xx,y2,'r');    
title('Nearest Interpolation') 
legend('real', 'interp')
