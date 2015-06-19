function P = rotate(P, i, j, c)                                 %Rotate i about j (c denotes oriantation)
import bedGeometry.*        % Package of functions controlling bed Geometry
            
        th = asin((P(i).y - P(j).y)/pdist([P(i).center; P(j).center],'euclidean'));    
        r = P(i).r + P(j).r;
        P(i).y = P(j).y + r*sin(th - (1/9)*pi);             %1/10pi is angle of rotation
        P(i).x = P(j).x + c*r*cos(th - (1/9)*pi);
        P(i).center=[P(i).x,P(i).y];
end

        
            
        
        
        