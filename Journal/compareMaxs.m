
theta=0:0.01:0.2294;

f1=1- sqrt(1.0897 *theta); 
f2=(1+sqrt(1-4*1.0897*theta))/2;


plot(f1); 
hold on;
plot(f2,'r');
 