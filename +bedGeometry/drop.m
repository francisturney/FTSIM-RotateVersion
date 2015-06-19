function [P,i,init,c] = drop(P,i,init,c)          %Drop P(i) to find P(init) or place on ground
import bedGeometry.*        % Package of functions controlling bed Geometry

    while (P(i).y > P(i).r)                         
        	P(i).y = P(i).y-.5;                   %Drop P(i).y by some amount
            P(i).center=[P(i).x, P(i).y];
            if P(i).y < P(i).r                    %If P(i) passes the floor place it there
               P(i).y = P(i).r;
               P(i).center=[P(i).x, P(i).y];
               break
            end
            if touching(P,i,i,i) ~= 0             %If P(i) touches another particle
                init = touching(P,i,i,i);         %denote particle index Max 
                c = whichSide(P,i,init);          %Determine if P(i) is left or right of P(init)
                P = allign(P,i,init,c);           %allign P(i) on P(init)
                break
            end
            
    end
end