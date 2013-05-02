function [ XY ] = Localize(tau, mics)

%%%%%%%% INPUTS %%%%%%%%%%%
s = 2^25;

P = s * mics;
X = 1;  % column of x's in P
Y = 2;  % column of y's in P


% v = speed of sound in m/s (distance and time are both scaled by 2^24)
v = 340.3;

%%%%%%%%%%%% LOCALIZE %%%%%%%%%%%%

% coefficient for x, y calculation
A2 = 2*P(2,X)*tau(1) - 2*P(1,X)*tau(2);
A3 = 2*P(3,X)*tau(1) - 2*P(1,X)*tau(3);

B2 = 2*P(2,Y)*tau(1) - 2*P(1,Y)*tau(2);
B3 = 2*P(3,Y)*tau(1) - 2*P(1,Y)*tau(3);

C2 = (v^2)*tau(2)*tau(1)*(tau(2)-tau(1)) + ...
    tau(2)*((P(1,X)^2) + (P(1,Y)^2)) - ...
    tau(1)*((P(2,X)^2) + (P(2,Y)^2));
C3 = (v^2)*tau(3)*tau(1)*(tau(3)-tau(1)) + ...
    tau(3)*((P(1,X)^2) + (P(1,Y)^2)) - ...
    tau(1)*((P(3,X)^2) + (P(3,Y)^2));


x =  (B2*C3 - B3*C2)/(A2*B3 - A3*B2);
y =  (A3*C2 - A2*C3)/(A2*B3 - A3*B2);



%%%%%%%%%%% OUTPUT %%%%%%%%%%

XY = 1/s * [x,y];

end