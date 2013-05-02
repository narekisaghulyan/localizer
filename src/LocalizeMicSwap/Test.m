mics = [ ...
    0.08,   0.16; ... 1
    0.16,   0.16; ... 2
    0.16,   0 ...     3
    ];

testXY = [  ...
    2, 8;   ...
    5, 13;  ...
    0, 10;  ...
    10, 0;  ...
    1, 20;  ...
    0, 20;  ...
    20, 0;  ...
    1,  2;  ...
    5,  6   ...
    ];
    

X = 1;
Y = 2;

fprintf('\n');
for i=1:size(testXY,1)
    XY = testXY(i,:);

    fprintf('Testing point (%4.1f, %4.1f): ', XY(X), XY(Y));
    tau = MakeTau(XY, mics);
    
    LXY = Localize(tau, mics);
    
    error = LXY - XY;
    scalarError = sqrt(error*error');
    
    
    fprintf('Got (%4.1f, %4.1f), an error of %4.1f m.\n', ...
        LXY(X), LXY(Y), scalarError);
end

fprintf('\nSwapping mic indices: 1<>2\n');
newMics = [     ...
    mics(2,:);  ...
    mics(1,:);  ...
    mics(3,:)   ...
    ];
for i=1:size(testXY,1)
    XY = testXY(i,:);

    fprintf('Testing point (%4.1f, %4.1f): ', XY(X), XY(Y));
    tau = MakeTau(XY, newMics);
    
    LXY = Localize(tau, newMics);
    
    error = LXY - XY;
    scalarError = sqrt(error*error');
    
    
    fprintf('Got (%4.1f, %4.1f), an error of %4.1f m.\n', ...
        LXY(X), LXY(Y), scalarError);
end
