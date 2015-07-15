% Function : initializeBed
% Description : Initializes particle bed, first by droping, then rotating each particle around subsequent
% collied particles to find the final position upon rotation reversal.
% Input : Particle Array and number of particles in bed
function newInitializeBed(particleArray)    
    % Setup
    import bedGeometry.*                              % Package of functions controlling bed Geometry    
    import particle
    global nDummies;                           % Number of dummy particles for making periodic boundary conditions
    global terminate;                          % Terminates placement of particle
    global nParticles;                         % Number of particles in bed
    nDummies = 0;                              % Start off with no dummies
    P = particleArray;                         % Simplify notation
  
    for i=1:nParticles
        fprintf('On particle %i\n',i)    
        if mod(i,5) == 0
           clf
           for j=1:(i-1)
               viscircles(P(j).center,P(j).r,'EdgeColor','b');   % debug
           end
           %for j = 51:(nParticles + nDummies)
           %   viscircles(P(j).center,P(j).r,'EdgeColor','b');   % debug
           %end
           pause;
        end
        % Drop
        inLine = 0;                             % Particles in the way of P(i)
        k = 0;                                  % Number of particle in the way of P(i)
        for j=(i-1):-1:1
            iRight = P(i).x + P(i).r;           % Boundaries of P(i)'s and P(j)'s projection on the x-axis
            iLeft = P(i).x - P(i).r;
            jRight = P(j).x + P(j).r;
            jLeft = P(j).x - P(j).r;
            if (iLeft < jRight) && (jLeft < iRight)     % If the two lines are not overlapping
                inLine(j) = P(j).z + P(j).r;            % inLine records the highest particle in line and it's index in P
%                 k = k+1;                        
            end
        end
        if inLine == 0;                       % If nothing in the way to the bottom
            P(i).z = P(i).r;                  % Set P(i) on ground
            P(i).center = [P(i).x, P(i).z];
            viscircles(P(i).center,P(i).r,'EdgeColor', 'b');   % debug
            pause;
            continue
        end
        [M,iTouch] = max(inLine);
        P(i).touching = iTouch;
%         if k > 1                % If in the way of multiple particles 
%             inLine(iLand) = 0;
%             [M,iTouch] = max(inLine);
%             P(i).touching = iTouch;
%             place(P,i);
%             continue
%         end
  
        % Place From Drop
        P(i).z = P(iTouch).z + sqrt((P(i).r + P(iTouch).r)^2 - (P(i).x - P(iTouch).x)^2);
        P(i).center = [P(i).x, P(i).z];
        viscircles(P(i).center,P(i).r);   % debug
        pause;
        
        
        % Place unitl wedged
        k = 0;
        while notWedged(P,i)
            terminate = false;
            k = k + 1;
            if k > 1
                 P(i).touching = P(i).landing;
                 P(i).landing = 0;
            end
            Dist = [];
            Min = 0;
            P(i).LR = whichSide(P,i);
            if P(i).LR == -1;
                for j=(i-1):-1:1
                    if P(j).x < P(P(i).touching).x 
                        Dist(j) = pdist([P(i).center; P(j).center],'euclidean');
                    else
                        Dist(j) = 200;
                    end
                    [Min,iLand] = min(Dist);
                    P(i).landing = iLand;
                end
            else if P(i).LR == 1;
                    for j=(i-1):-1:1
                        if P(j).x > P(P(i).touching).x 
                            Dist(j) = pdist([P(i).center; P(j).center],'euclidean');
                        else
                            Dist(j) = 200;
                        end
                        [Min,iLand] = min(Dist);
                        P(i).landing = iLand;
                    end    
                end
            end
            while ~place(P,i)
                Dist(iLand) = 200; % Distance to iLand is much farther     
                [Min,iLand] = min(Dist);
                P(i).landing = iLand;
                if Min == 200;
                    floorSet(P,i);
                    viscircles(P(i).center,P(i).r, 'EdgeColor', 'b')   % debug
                    pause;
                    terminate = true;
                    break
                end
            end
            if terminate == true; break; end
            %viscircles(P(i).center,P(i).r);   % debug
            %pause;
            while isTouching2(P,i) > 0
                P(i).prevTouch = P(i).landing;
                P(i).landing = isTouching2(P,i);
                P(i).touching = P(i).prevTouch;
                place(P,i);
                viscircles(P(i).center,P(i).r);   % debug
                fprintf('P(i).touching = %f P(iTouch).x = %f\n',P(i).touching,P(P(i).touching).x)
                fprintf('P(i).landing = %f P(iLand).x = %f\n',P(i).landing,P(P(i).landing).x)
                fprintf('isTouching2(P,i) = ')
                isTouching2(P,i)
                pause;
            end
            viscircles(P(i).center,P(i).r, 'EdgeColor', 'r');   % debug
            pause;
        end

    end
end