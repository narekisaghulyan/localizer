% positions of mic 1,2,3
% mic 0 at origin: <0,0>

x1   =  0.08;   y1   = .16;
x2   = .16;  y2   = .16;
x3   = .16;  y3   =  0;

P = [ x1, y1; ...
      x2, y2; ...
      x3, y3];

% v = speed of sound in m/s
v = 340.3;

% tau = TDOA between microphones.
% tau > 0 if an acoustic source reaches p0 earlier than pm
% tau is in s
taum =  @(m,x,y) (...
    sqrt( (P(m,1)-x)^2 + (P(m,2)-y)^2) - ...
    sqrt( x^2 + y^2 )) / v;

% acoustic location
Ax = 0.26;
Ay = 0.36;

tau1 = taum(1, Ax, Ay) 
tau2 = taum(2, Ax, Ay) 
tau3 = taum(3, Ax, Ay)


% coefficient for x, y calculation
A2 = 2*x2*tau1 - 2*x1*tau2;
A3 = 2*x3*tau1 - 2*x1*tau3;

B2 = 2*y2*tau1 - 2*y1*tau2;
B3 = 2*y3*tau1 - 2*y1*tau3;

C2 = (v^2)*tau2*tau1*(tau2-tau1) + tau2*((x1^2) + (y1^2)) - tau1*((x2^2) + (y2^2));
C3 = (v^2)*tau3*tau1*(tau3-tau1) + tau3*((x1^2) + (y1^2)) - tau1*((x3^2) + (y3^2));

% position y of the source
%y = -1*((C3 - C2*(A3/A2))/(B3 - B2*(A3/A2)));
y =  (A3*C2 - A2*C3)/(A2*B3 - A3*B2);
x =  (B2*C3 - B3*C2)/(A2*B3 - A3*B2);

% position x of the source
%x = -1*((C2 + B2*y)/A2);

A2*B3 - A3*B2
position = [x,y]
dlmwrite('position.txt', position);
