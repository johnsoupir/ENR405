%ENR 405 - Root locus homework.
%John Soupir, Feb 20, 2023
function rlks(poles,zeros,zeta)
tic
%Constant to convert to degrees
degco = 180/pi;

%clear the plot
clf;

%Print usage if missing arguments
if (nargin != 3)
  warning("Missing arguments! Usage: rlks(poles,zeros,zeta)")
endif

%Find angle of zeta line
phi = acos(zeta);
printf("Phi (angle of zeta) is: %0.3d degrees\n", phi*180/pi)

%Turn on the plot and set it up
hold on
ylabel ("Im")
xlabel ("Re")
xlim ([-5,1])
ylim ([-5,5])

%x-axis line
line([0 0], [-10 10], "linestyle", "--", "color", "r")
%y-axis line
line([-10 0], [0 0], "linestyle", "--", "color", "g")
%zeta line
line([0 -2*cos(phi)], [0 2*sin(phi)])

%Plot poles and zeros
plot (poles,0,"b*")
plot (zeros,0,"ro")

%Sweep along zeta until 2
for r = 0:0.001:2

%Zeros the veriables
angleSum = 0;
anglep=0;
anglez=0;

%Find the x and y component of this point along the zeta line
xpoint = -r*cos(phi);
ypoint = r*sin(phi);

%Plot which point we are testing
plot(xpoint,ypoint,"r*");


%%%%%%%%%%%%%%%%   Find pole angles   %%%%%%%%%%%%%%%%%%%
%Find angle of all poles
for i = 1:length(poles)
deltaX = abs(xpoint - poles(i));
deltaY = ypoint - 0;
if(xpoint < poles(i))
%Subtract from 180 degrees
thisAngle = ((pi) - abs(atan(deltaY/deltaX)));
else
%Do not subtract from 180 degrees
thisAngle = abs(atan(deltaY/deltaX));
endif
anglep += thisAngle;
endfor


%%%%%%%%%%%%%%%%   Find zero angles   %%%%%%%%%%%%%%%%%%%
%Find angle of all zeros
for i = 1:length(zeros)
deltaX = abs(xpoint - zeros(i));
deltaY = ypoint - 0;
if(xpoint < zeros(i))
%Subtract from 180 degrees
thisAngle = ((pi) - abs(atan(deltaY/deltaX)));
else
%Do not subtract from 180 degrees
thisAngle = abs(atan(deltaY/deltaX));
endif
anglez += thisAngle;
endfor


%%%%%%%%%%%%%   Process results   %%%%%%%%%%%%%%%%%%%
%Get sum of poles and zeros. I am looking for positive 180, so math follows.
angleSum = anglep - anglez;

%Print the current angle of this test point
%printf("Angle at r=%0.3d is %d degrees. Angle Zeros = %-4.3d Angle Poles = %-4.3d\n", r, angleSum*degco, anglez*degco, anglep*degco)

%If angle of 180 (or close enough) is found, plot it and exit.
if (angleSum*degco > 179.99 && angleSum*degco < 180.01)

printf("######### Found angle at %0.2d is %d!\n", r, angleSum*degco);
plot(xpoint,ypoint,"g*");

%Plot lines to point
for j = 1:length(poles)
line([poles(j) xpoint], [0 ypoint], "color", "k");
endfor
%for k = 0:length(zeros)
line([zeros(1) xpoint], [0 ypoint], "color", "k");
%endfor
break

endif

endfor
toc

endfunction

