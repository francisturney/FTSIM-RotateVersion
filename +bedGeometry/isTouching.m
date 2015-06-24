%% IsTouching
% Inputs : Particle Array, and index of the particle you're interested in (j). 
% Outputs : Index of the particle that the jth particle is touching (touching). 
    % If the jth particle is touching more than one particle it returns the 
    % particle with the highest index.
function touching = isTouching(particleArray,j)           
import bedGeometry.*                                      % Package of functions controlling bed Geometry
jthParticle = particleArray(j);                           % Easier to read notation

    touching = 0;
    for k=(j-1):-1:1                                        % Check if particles touching starting with last
        kthParticle = particleArray(k);                     % Easier to read notation                                           
          if ((k == jthParticle.touching) || (k == 0)) || (k == jthParticle.prevTouch)   % Don't consider the particles that the jth Particle
                continue                                                              % have already been placed against
          end
              if pdist([jthParticle.center; kthPaticle.center],'euclidean') <= (jthPaticle.r + kthParticle.r) %If distance between particles is less than the
                  touching = k;                                                                               %the sum of radii then they are touching 
                  return
              end         
    end
end
           