% Function : initializeBed
% Description : Initializes particle bed, first by droping, then rotating each particle around subsequent
% collied particles to find the final position upon rotation reversal.
% Input : Particle Array and number of particles in bed

function initializeBed(particleArray,nParticles)
    % Setup
    import bedGeometry.*                              % Package of functions controlling bed Geometry    
    import particle
    dummyIndex = 0;                                   % Number of dummy particles for makeing periodic boundary conditions
    
    for i=1:nParticles
        ithParticle = particleArray(i);                   % Simplify Notation
        fprintf('On particle %i\n',i)    
        
        % Drop and Allign
        drop(particleArray,i);                            % Move particle towards floor while gathering touched particle indicies and aligning
        if ithParticle.touching == 0                      % f particle i is not touching anyone after drop than it is on the ground                              
            continue                                        % no need to contine if your on the ground
        end

        % Allign With Multiple Particles
        ithParticle.prevTouch = ithParticle.landing;           % Denote landing particle as previously touching to allign with multiple particles
        while isTouching(particleArray,i) > 0                  % If particle is touching multiple others after intial drop and allignment
            ithParticle.landing = isTouching(particleArray,i); % Select an overlaping particle to land on, (counting backwards from nParticles)
            place(particleArray,i);                            % Place ith paticle between the particle it's touching and the particle it will land on
            ithParticle.prevTouch = ithParticle.landing;       % Save the particle you landed on 
        end

        % Rotate
        while (reversed(particleArray,i) == false)             % While particle doesn't reverse rotation
            notCollided = @(particleArray,i) isTouching(particleArray,i) == 0; %
            aboveGround = @(particleArray,i) ithParticle.y > ithParticle.r;

            while notCollided(particleArray,i) && aboveGround(particleArray,i) % While not touching other particles and within bounds
                rotate(particleArray,i);                                       % Rotate the ith Paticle around its touching particle
                ithParticle.landing = isTouching(particleArray,i);             % Declare landing partilce as the partice the ith particle rolls into
            end
            if ithParticle.landing == 0                            % If you rotated and y went below 0, then place between floor and touching particle
                floorSet(particleArray,i);                         % Set on floor
                break                                              % and terminate 
            end

            % Place Particle 
            place(particleArray,i);                                % Place ith particle between touching and landing particles
            ithParticle.prevTouch = ithParticle.landing;           % Denote landing particle as previously touching in case ith particle touches multiple particles
            while (isTouching(particleArray,i) > 0)                % If particle is overlapping others after placement place again
                ithParticle.landing = isTouching(particleArray,i);
                place(particleArray,i);
                ithParticle.prevTouch = ithParticle.landing;           % Denote landing particle as previously touching to allign with multiple particles
            end

            % Reset Properties
            ithParticle.prevTouch = ithParticle.touching;                   % Resest variables for next loop
            ithParticle.touching = ithParticle.landing;                     % Landing particle becomes touching particle
            ithParticle.landing = 0;
        end
    end
end                                                             
    

