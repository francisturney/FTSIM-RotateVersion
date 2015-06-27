% Function: averageHeight
% Description: Finds the average height of the top row of particles

function averageHeight = averageHeight(particleArray,nParticles) 
import bedGeometry.*        % Package of functions controlling bed Geometry

    averageHeight = 0;
    n = 0;
    for i=1:nParticles
        if particleArray(i).isTop
            n = n+1;
            averageHeight = averageHeight + particleArray(i).y;
        end
    end
    averageHeight = averageHeight/n;
end