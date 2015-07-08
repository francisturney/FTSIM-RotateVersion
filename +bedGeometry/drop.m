
% Function: drop
% Description: Drop the jth particle untill it collides with the bed, then allign jth particle on the surface of the particles it collides with.

function drop(particleArray,j)          
                                             
import bedGeometry.*                         % Package of functions controlling bed Geometry
jthParticle = particleArray(j);              % More readable notation

    while (jthParticle.y > jthParticle.r)                         
        	jthParticle.y = jthParticle.y - .5;                   % Move jth particle downward by some increment
            jthParticle.center=[jthParticle.x, jthParticle.y];  % Update center
            if jthParticle.y < jthParticle.r                    % If jth particle's center passes the floor place it there
               jthParticle.y = jthParticle.r;
               jthParticle.center=[jthParticle.x, jthParticle.y];
               break
            end
            if isTouching(particleArray,j) ~= 0                                 % If jth particle touches another particle (touching returns index of the touched)
                jthParticle.touching = isTouching(particleArray,j);             % Denote intex of touched paticle in jthParticle.touch 
                jthParticle.LR = whichSide(particleArray,j);                    % Determine orientation of jth paticle against closest neighbor
                allign(particleArray,j);                                        % allign jthParticle on the surface of the particle its touching
                break
            end
            
    end
end