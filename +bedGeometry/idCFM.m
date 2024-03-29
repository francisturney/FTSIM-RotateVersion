% Function: idCFM (Canidates For Movement)
% Description: If the jth particle is above the particles it touches than it is a canidate for movement

function idCFM(particleArray,nParticles,ave)                         
    import bedGeometry.*        % Package of functions controlling bed Geometry
    P = particleArray;          % Simplify notation

    for i=1:nParticles                                               %reset top
        if P(i).isTop == true;
            P(i).isCFM = true;
            k=0;                              % Counter for touching above positioned particles
            for j=1:nParticles
                if i == j
                    continue
                end
                if (pdist([P(i).center; P(j).center],'euclidean') <= (P(i).r + P(j).r + 1)) && (P(i).z < P(j).z) %If the P(i) touches and is below P(j) then P(i) is not on top
                     P(i).isCFM = false;
                end
                if P(i).z <= (P(i).r + 1)
                   P(i).isCFM = false;
                end
                if P(i).z <= ave
                   P(i).isCFM = false;
                end
                if (P(i).x < 10) || (P(i).x > 170)              %If P(i) is too close to the edge of range then it is not on top
                    P(i).isCFM = false;
                end
            end
        end
    end
end
    
