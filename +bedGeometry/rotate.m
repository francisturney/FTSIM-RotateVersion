function [] = rotate(particleArray, j)      % Rotate jth particle around the particle it's touching
        import bedGeometry.*                % Package of functions controlling bed Geometry
            
        P = particleArray;                          % Simplify notation
        touching = particleArray(j).touch;          % ...
        LR = particleArray(j).LR ;                  % ...
        
        theta = asin((P(j).y - P(touching).y)/pdist([P(j).center; P(touching).center],'euclidean'));    
        r = P(j).radius + P(touching).radius;
        P(j).y = P(touching).y + r*sin(theta - (1/9)*pi);             %(1/9)pi is angle of rotation
        P(j).x = P(touching).x + LR*r*cos(theta - (1/9)*pi);
        P(j).center=[P(j).x,P(j).y];
end

        
            
        
        
        