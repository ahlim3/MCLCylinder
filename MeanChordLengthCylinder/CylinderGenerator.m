function [x0, y0, z0, x1, y1, z1, l] = CylinderGenerator(radius,height)
% Generation of P0
x0 = -radius;
y0 = 0;
z0 = rand * height;

% Angle bewteen P0 and P1, randomized and distributed like particle fluence
% path. 
phi = rand * 2 * pi;
theta = acos(1-rand * 2) * pi;

% Unit vector bewteen P0 and P1
u = cos(theta);
v = sin(theta) * cos(phi);
w = sin(theta) * sin(phi);

% Excuting condition for both point on circular surface
l = (2 * radius * u)/(u^2 + v^2);
% P1 z-axis calculation for conditions
z1 = z0 + l * w;
%Case 1 if z1 is below the minium height, 0
    if z1 < 0
        z1 = 0;
        l = (-z0)/(w);
    %Case 2 if z1 is above the maxium height, height
    elseif z1 > height
        z1 = height;
        l = (height - z0) / (w);
    %Case 3 P0 is in either Top or Bottom Surface and P1 is on the Circular
    %Surface
    elseif z0 == 0 && z1 > 0 && z1 < height | z0 == height && z1 > 0 && z1 < height
       a = -2 * (x0 * u + y0 * w);
       b = a^2;
       c = 4 * (u ^ 2 + v ^ 2)*(radius ^ 2 + x0 ^ 2 + y0 ^ 2)
       d = 2 * (u ^ 2 + v ^ 2);
       l = (a + sqrt(b + c))/d;
       z1 = l * w;
    %Case 4 P0 is in either Top or Bottom Surface and P1 is Opposite
    %Surface
    elseif z0 == 0 && z1 > height | z0 == height && z1 < 0
           z1 = height;
           if z0 == height
               z1 = 0;
           end
           l = height / (w);
    %Case 5 P0 and P1 on Bottom Bottom or Top Top Surface
    elseif z0 == 0 && z1 < 0 | z0 == height && z1 > height
        l = 0;
    end
    
    x1 = x0 + l * u;
    y1 = l * v;
end



