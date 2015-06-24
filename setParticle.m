%% setParticle
%  Input : Particle Array and index of the particle you want to set in the bed (j)
%  Result : jth particle is placed in the bed

function [] = setParticle(particleArray,j)                            
import bedGeometry.*        % Package of functions controlling bed Geometry

%**************************************************************************
%   Makes an array of structure arrays which represents a collection of 
%circular particles, then places them as if they'd fallen onto the floor 
%from gravity. You can set the particle radii as well as their number and 
%range. The alogrithm for placement simulates falling as the particles
%are dropped in the vertictal direction untill collision with floor or
%other particle and then rotated around particles untill further collision
%and eventual resting based on reversal of rotation after collision. 
%**************************************************************************                                            
    % Initialize jth particle in bed, first droping then rotating around collided particles to find final position
                                                 
        jthParticle = particleArray(j);                   % Simplify Notation 
        drop(particleArray,j);                            % Move particle towards floor while gathering touched particle indicies and aligning
                                                          % jth particle along the border of the particles it touches   
        if jthParticle.touching == 0                      % If particle j is not touching anyone after drop than it is on the ground
            grounded = true;                              
            return                                        % no need to contine if your on the ground
        end
        while isTouching(particleArray,j) > 0             % If particle is touching multiple others after intial drop and allignment
            jthParticle.landing = isTouching(particleArray,j); % Select an overlaping particle to land on, (counting backwards from nParticles)
            place(particleArray,j);                       % Place jth paticle between the particle it's touching and the particle it will land on
            jthParticle.prevTouch = jthParticle.land;     % Save the particle you landed on 
        end

        %FIND THE FINAL POSITION OF P(I) THROUGH ROATATE LOOP AND REVERSAL TERMNIATE
        while (reversed(particleArray,j) == false)                       %TERMINATE IF PARTICLE REVERSES ROTATION UPON COLLISION AND PLACEMENT
            while ((touching(particleArray,j) == 0)) && (particleArray(j).y > particleArray(j).r) %while not touching other particles and within bounds
                rotate(particleArray,j);                               %rotate
                jthParticle.land = touching(particleArray,j);                %Assign min to the particle P(i) is touching (0 if not touching)
            end
            if land == 0                                           %If there is no closest
                particleArray = floorSet(particleArray,j,init,c);                           %Set on floor
                break                                               %and terminate 
            end
            %PLACE PARTICLE 
            particleArray = place(particleArray,j,land,init);                              %Calculate and assign new position
            while (touching(particleArray,j,init,land) ~= 0)                   %If particle is overlapping others after plac
                land = touching(particleArray,j,init,land);
                particleArray = place(particleArray,j,land,init);
            end
            prevInit = init;                                        %Resest variables for next run
            init = land;
            land = 0;
        end
    end                                                             %END OF INITIALIZE
    fprintf('bed intialized\n')
end