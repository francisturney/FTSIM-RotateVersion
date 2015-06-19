function P = assnPivot(P,N)         %ASSIGN PIVOT PARTICLES 
import bedGeometry.*        % Package of functions controlling bed Geometry

    for i = 1:N                                                           %initialize to zero
        P(i).piv = 0;
    end
    for i=1:N
        if P(i).top                                                        %find only the top particles
           for j=2:N                                                       %look at all particles that could touch
               if P(i).x < P(j).x                                          %look only to the right of top particles
                   if pdist([P(i).center; P(j).center],'euclidean') <= (P(i).r + P(j).r +.05) % look for touching particle (.05 is an error term)
                       if P(i).piv == 0;                                   %if there was no other pivot particle
                           P(i).piv = j;
                       else if P(P(i).piv).y < P(j).y                      %if there was other pivot particle then only use the highest one
                                P(i).piv = j;
                           end   
                       end
                   end  
               end
           end
        end
    end
end