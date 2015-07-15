% Function: idTop
% Description: Identify Top Layer of particles by droping dummy particles and assuming
% the particles they collide with are on top.

function idTop(particleArray,nParticles)                         
    import bedGeometry.*                                                 % Package of functions controlling bed Geometry
    
    for i=1:nParticles                                               % reset top
        particleArray(i).isTop = false; 
    end
    for i=20:2:120
        top = false;                                                 
        for z = 55:-2:0 
            for j=1:nParticles
                if (pdist([[i,z]; particleArray(j).center],'euclidean') <= (particleArray(j).r + 5))    % If collision with bed
                   particleArray(j).isTop = true;                               
                   top = true;  
                end
            end
            if top                                                  % If you found a top particle stop
                break;
            end
        end
    end
end