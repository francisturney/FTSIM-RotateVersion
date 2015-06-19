function P = assnAntiPivot(P,N) %ASSIGN ANTI-PIVOT PARTICLES & CREATE ANTI-PIVOT POINT                   
import bedGeometry.*        % Package of functions controlling bed Geometry

    [P.antiPiv]=deal(0);                                                     %intialize feild to 0
    [P.antiPivPoint]=deal(0);                                                %initialize feild to 0
    for i=1:N
        if P(i).top                                                          %find only the top particles
           for j=2:N                                                            %look at all particles that could touch
               if P(i).x > P(j).x                                         %look only to the right of top particles
                   if pdist([P(i).center; P(j).center],'euclidean') <= (P(i).r + P(j).r + 0.5) % look for touching particle (.05 is an error term)
                       if P(i).antiPiv == 0;                                   %if there was no other pivot particle
                           P(i).antiPiv = j;
                       else if P(P(i).antiPiv).y < P(j).y                      %if there was other pivot particle then only use the highest one
                           P(i).antiPiv = j;
                           end   
                       end
                   end  
               end
           end
        end
    end
    theta = 0;                                                  %theta is the angle between gravity force and lever arm
    beta = 0;                                                   %beta is the angle between drag force and lever arm
    for i=1:N
            if P(i).top
                theta = asin((P(P(i).antiPiv).x - P(i).x)/(P(P(i).antiPiv).r + P(i).r)); %Solving for angles between lever and forces 
                beta = acos((P(P(i).antiPiv).x - P(i).x)/(P(P(i).antiPiv).r + P(i).r));  
                if P(i).y < P(P(i).antiPiv).y
                    P(i).antiPivPoint = [P(i).x + P(i).r*sin(theta),P(i).y + P(i).r*sin(beta)];
                else
                    P(i).antiPivPoint = [P(i).x + P(i).r*sin(theta),P(i).y - P(i).r*sin(beta)];
                end
            end
    end
end