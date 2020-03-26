function dx = combinedDub(t,x,u)
%COMBINEDDUB Combined dynamics of 2 Dubins airplanes
    v = 807; % ft/s
    % Ownship
    dx(1,1) = v*cos(x(3)); % x (ft)
    dx(2,1) = v*sin(x(3)); % y (ft)
    dx(3,1) = u;           % heading (rad)
    % Intruder
    dx(4,1) = v*cos(x(6)); % x (ft)
    dx(5,1) = v*sin(x(6)); % y (ft)
    dx(6,1) = 0; % Constant heading (rad)
    % nn inputs (environment)
    dx(7,1) = -((-x(4)+x(1))*dx(4,1))/sqrt((x(4)-x(1))^2+(x(2)-x(5))^2) + ((-x(4)+x(1))*dx(1,1))/sqrt((-x(4)+x(1))^2+(x(2)-x(5))^2) + ((x(2)-x(5))*dx(2,1))/sqrt((-x(4)+x(1))^2+(x(2)-x(5))^2) - ((x(2)-x(5))*dx(5,1))/sqrt((x(4)-x(1))^2+(x(2)-x(5))^2);
    % State 8 derivative is very complex, let's analyze by parts
    % dx(8,1) = ((x(4)-x(1))*(x(4)-x(1)+sqrt(((x(4)-x(1))^2)+(x(5)-x(2))^2)*dx(5,1)))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)*((x(4)-x(1))^2+(x(5)-x(2))^2+x(4)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2))-x(1)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2)))); % Partial 1
    % dx(8,1) = ((x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2*(1+(x(5)-x(2)^2)/(x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2)); % Denominator of partials 2 and 3
    % dx(8,1) = - (2*(1+(x(4)-x(1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)))*(x(5)-x(2))*dx(4,1)); % Numerator of partial 2
    % dx(8,1) = - (2*(1+(x(4)-x(1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)))*(x(5)-x(2))*dx(4,1))/(eps+((x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2*(1+(x(5)-x(2)^2)/(x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2))); % Partial 2
    % dx(8,1) = - (2*(-1-(x(4)-x(1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)))*(x(5)-x(2))*dx(1,1))/(eps+((x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2*(1+(x(5)-x(2)^2)/(x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2))) ; % Partial 3
    % dx(8,1) = - ((x(4)-x(1))*(x(4)-x(1)+sqrt(((x(4)-x(1))^2)+(x(5)-x(2))^2)*dx(2,1)))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)*((x(4)-x(1))^2+(x(5)-x(2))^2+ x(4)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2))-x(1)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2)))) ; % Partial 4
    % Original full derivative
    dx(8,1) = ((x(4)-x(1))*(x(4)-x(1)+sqrt(((x(4)-x(1))^2)+(x(5)-x(2))^2)*dx(5,1)))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)*((x(4)-x(1))^2+(x(5)-x(2))^2+ x(4)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2))-x(1)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2)))+eps)    -     (2*(1+(x(4)-x(1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)))*(x(5)-x(2))*dx(4,1))/(eps+((x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2*(1+(x(5)-x(2)^2)/(x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2)))    -   (2*(-1-(x(4)-x(1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)))*(x(5)-x(2))*dx(1,1))/(eps+((x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2*(1+(x(5)-x(2)^2)/(x(4)-x(1)+sqrt((x(4)-x(1))^2+(x(5)-x(2))^2))^2)))    -    ((x(4)-x(1))*(x(4)-x(1)+sqrt(((x(4)-x(1))^2)+(x(5)-x(2))^2)*dx(2,1)))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)*((x(4)-x(1))^2+(x(5)-x(2))^2+ x(4)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2))-x(1)*sqrt(x(5)^2+x(4)^2-2*x(4)*x(1)+x(1)^2+x(2)^2-2*x(5)*x(2)))+eps)   ; % theta
    dx(9,1) = dx(6,1) - dx(3,1);
%     disp('State 1 = ' + string(dx(1,1)));
%     disp('State 2 = ' + string(dx(2,1)));
%     disp('State 4 = ' + string(dx(4,1)));
%     disp('State 5 = ' + string(dx(5,1)));
%     disp('State 8 = ' + string(dx(8,1)));
end

