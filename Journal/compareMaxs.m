
theta=0:0.01:0.1060;

f1=1- sqrt(2.3589 *theta); 
f2=(1+sqrt(1-4*2.3589*theta))/2;


plot(f1); 
hold on;
plot(f2,'r');
 