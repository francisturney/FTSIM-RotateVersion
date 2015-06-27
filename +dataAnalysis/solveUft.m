% Function: solveUft
% Definition: Calculate Fluid Threshold From Moment Balance of Drag and Gravity Forces

function solveUft(particleArray,nParticles,Cd,k,rhoAir,rhoSand,g,z0,ave)
        P = particleArray;          % Simplify notation
        Itop = 0;                   % Top half of integral (top windward quadrant)
        Ibot = 0;                   % Integral for bottown windward quadrant            
        
    for i=1:nParticles
        if P(i).isCFM
            z = P(i).y - ave;
            %CALULATION OF DRAG FORCE 
            %CALCULATE INTEGRAL OF WIND SPEED AND EXPOSED AREA (I)
             P(i).I = 0;             %integral of wind and area per particle
             f = @(z) (log(z./z0)).^2.*(abs(z-P(i).y)./sqrt(P(i).r.^2 - (z-P(i).y).^2));     %integrand

                %NUMERICAL INTEGRATION USING GLOBAL ADAPTIVE QUADRATURE AND DEFAULT ERROR TOLERANCES
                    Itop = integral(f,P(i).y,P(i).y+P(i).r);    %calulate top half of integral (top windward quadrant)
                    %NEW SOLUTION
                    % a and b are the limits of integration with b being
                    % the top integrand
%                     a = P(i).y;
%                     b = P(i).y + P(i).r;
%                     Itop = b*(log(b/z0)).^2 - a*(log(a/z0)).^2 + 2*z0*((b-a)*z0 - (b*log(b/z0) - a*log(a/z0)));
                 if (P(i).y - P(i).r) < z0                       %then claculate bottown windward quadrant based on antiPivPoint and z0 
                     Ibot = integral(f,z0,P(i).y);               %if particle dips below z0 then integrate upwards from z0
%                     a = z0;
%                     b = P(i).y;
%                     Ibot = b*(log(b/z0)).^2 - a*(log(a/z0)).^2 + 2*z0*((b-a)*z0 - (b*log(b/z0) - a*log(a/z0)));
                else
                    Ibot = integral(f,P(i).liftPoint(2),P(i).y);      %else integrate upwards from anti-pivot point
%                     a = P(i).antiPivPoint(2);
%                     b = P(i).y;
%                     Ibot = b*(log(b/z0)).^2 - a*(log(a/z0)).^2 + 2*z0*((b-a)*z0 - (b*log(b/z0) - a*log(a/z0)));
                end
                P(i).I = Itop + Ibot;                           %add integrals to get total integral
                % Solve for threshold shear velocity
                c = 80000;      % (conversion step)
                P(i).uft = sqrt((rhoSand - rhoAir)*g*(P(i).r*2/c)^3*k^2*P(i).mG/(P(i).mD*6*Cd*(P(i).I/c)*(P(i).r/c)));  %factors of ten are conversion factors between hectomicrons and meters (I is meters squared)
         end

     end
end
