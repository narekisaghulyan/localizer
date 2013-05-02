%%%%%%%% INPUTS %%%%%%%%%%%

% positions of mic 1,2,3
% mic 0 at origin: <0,0>
s=2^25;

x1   =  0.08;   y1   = .16;
x2   = .16;  y2   = .16;
x3   = .16;  y3   =  0;

P = [ x1, y1; ...
      x2, y2; ...
      x3, y3];
X = 1;  % column of x's in P
Y = 2;  % column of y's in P

sP = s*P;

% v = speed of sound in m/s
v = 340.3;
sv = v;

% tau = TDOA between microphones.
% tau > 0 if an acoustic source reaches p0 earlier than pm
% tau is in s
taum =  @(m,x,y) (...
    sqrt( (P(m,1)-x)^2 + (P(m,2)-y)^2 ) - ...
    sqrt( x^2 + y^2 )) / v;

% acoustic location
A = [12, 17];
sA = s*A;

tau = [ taum(1, A(X), A(Y)),    ...
        taum(2, A(X), A(Y)),    ...
        taum(3, A(X), A(Y))];
stau = s*tau

%%%%%%%%%%%% LOCALIZE %%%%%%%%%%%%
testS = @(a,b) log(a/b)/log(2);

% coefficient for x, y calculation
A2 = 2*P(2,X)*tau(1) - 2*P(1,X)*tau(2);
sA2 = 2*sP(2,X)*stau(1) - 2*sP(1,X)*stau(2)
testS(sA2,A2);

a2_1 = 2*sP(2,X)
a2_2 = stau(1)
a2_3 = 2*sP(1,X)
a2_4 = stau(2)
a2_5 = a2_1*a2_2
a2_6 = a2_3*a2_4
a2_7 = a2_5-a2_6


A3 = 2*P(3,X)*tau(1) - 2*P(1,X)*tau(3);
sA3 = 2*sP(3,X)*stau(1) - 2*sP(1,X)*stau(3)
testS(sA3,A3);

a3_1 = 2*sP(3,X)
a3_2 = stau(1)
a3_3 = 2*sP(1,X)
a3_4 = stau(3)
a3_5 = a3_1*a3_2
a3_6 = a3_3*a3_4
a3_7 = a3_5-a3_6

B2 = 2*P(2,Y)*tau(1) - 2*P(1,Y)*tau(2);
sB2 = 2*sP(2,Y)*stau(1) - 2*sP(1,Y)*stau(2)
testS(sB2,B2);

b2_1 = 2*sP(2,Y)
b2_2 = stau(1)
b2_3 = 2*sP(1,Y)
b2_4 = stau(2)
b2_5 = b2_1*b2_2
b2_6 = b2_3*b2_4
b2_7 = b2_5-b2_6

B3 = 2*P(3,Y)*tau(1) - 2*P(1,Y)*tau(3);
sB3 = 2*sP(3,Y)*stau(1) - 2*sP(1,Y)*stau(3)
testS(sB3,B3);

b3_1 = 2*sP(3,Y)
b3_2 = stau(1)
b3_3 = 2*sP(1,Y)
b3_4 = stau(3)
b3_5 = b3_1*b3_2
b3_6 = b3_3*b3_4
b3_7 = b3_5-b3_6

C2 = (v^2)*tau(2)*tau(1)*(tau(2)-tau(1)) + tau(2)*((P(1,X)^2) + (P(1,Y)^2)) - tau(1)*((P(2,X)^2) + (P(2,Y)^2));
sC2 = (sv^2)*stau(2)*stau(1)*(stau(2)-stau(1)) + stau(2)*((sP(1,X)^2) + (sP(1,Y)^2)) - stau(1)*((sP(2,X)^2) + (sP(2,Y)^2))
testS(sC2,C2);

c1 = (sv^2)*stau(2)*stau(1)
c2 = (stau(2)-stau(1))
c3 = stau(2)
c4 = (sP(1,X)^2) 
c5 = (sP(1,Y)^2)
c6 = stau(1)
c7 = (sP(2,X)^2)
c8 = (sP(2,Y)^2)
c9 = c1*c2
c10 = c3
c11 = c4 + c5
c12 = c6
c13 = c7 + c8
c14 = c3*c11
c15 = c6*c13
c16 = c9+c14
c17 = c16-c15

d1 = (sv^2)*stau(3)*stau(1)
d2 = (stau(3)-stau(1))
d3 = stau(3)
d4 = (sP(1,X)^2) 
d5 = (sP(1,Y)^2)
d6 = stau(1)
d7 = (sP(3,X)^2)
d8 = (sP(3,Y)^2)
d9 = d1*d2
d10 = d3
d11 = d4 + d5
d12 = d6
d13 = d7 + d8
d14 = d3*d11
d15 = d6*d13
d16 = d9+d14
d17 = d16-d15

%c5 = c1*c2 + c3 - c4


C3 = (v^2)*tau(3)*tau(1)*(tau(3)-tau(1)) + tau(3)*((P(1,X)^2) + (P(1,Y)^2)) - tau(1)*((P(3,X)^2) + (P(3,Y)^2));
sC3 = (sv^2)*stau(3)*stau(1)*(stau(3)-stau(1)) + stau(3)*((sP(1,X)^2) + (sP(1,Y)^2)) - stau(1)*((sP(3,X)^2) + (sP(3,Y)^2))
testS(sC3,C3);

% position y of the source
%y = -1*((C3 - C2*(A3/A2))/(B3 - B2*(A3/A2)));
x =  (B2*C3 - B3*C2)/(A2*B3 - A3*B2);
sx =  (sB2*sC3 - sB3*sC2)/(sA2*sB3 - sA3*sB2);
testS(sx,x);


y =  (A3*C2 - A2*C3)/(A2*B3 - A3*B2);
sy =  (sA3*sC2 - sA2*sC3)/(sA2*sB3 - sA3*sB2);
testS(sy,y);

% position x of the source
%x = -1*((C2 + B2*y)/A2);


%%%%%%%%%%% OUTPUT %%%%%%%%%%

%A2*B3 - A3*B2
position = [x,y];
sposition = [sx,sy]
sposition/s

dlmwrite('position.txt', position);
