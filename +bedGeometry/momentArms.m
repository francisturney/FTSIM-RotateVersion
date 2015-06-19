function P = momentArms(P,N)%CALCULATE MOMENT ARMS AND ASSIGN PIVOT POINTS
import bedGeometry.*        % Package of functions controlling bed Geometry

    theta = 0;                                                  %theta is the angle between gravity force and lever arm
    beta = 0;                                                   %beta is the angle between drag force and lever arm
    for i=1:N
            if P(i).top
                theta = asin((P(P(i).piv).x - P(i).x)/(P(P(i).piv).r + P(i).r)); %Solving for angles between lever and forces 
                beta = acos((P(P(i).piv).x - P(i).x)/(P(P(i).piv).r + P(i).r));  
                P(i).mG = P(i).r*sin(theta);                    %mG is the moment arm for gravity force
                P(i).mD = P(i).r*sin(beta);                     %mD is the moment arm for drag force
                if P(i).y < P(P(i).piv).y
                    P(i).pivPoint = [P(i).x + P(i).r*sin(theta),P(i).y + P(i).r*sin(beta)];
                else
                    P(i).pivPoint = [P(i).x + P(i).r*sin(theta),P(i).y - P(i).r*sin(beta)];
                end
            end
    end
end