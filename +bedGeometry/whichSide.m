function LR = whichSide(particleArray,j)          % Which side of P(j) is P(i) on (left/right) (c=-1,c=1)
    
    % Declare 
    import bedGeometry.*                                % Package of functions controlling bed Geometry
    jthParticle = particleArray(j);                     % Simplify notation
    jTouched = particleArray(particleArray(j).touching);   % Particle that jth particle is touching
    
    LR = -1;                                % Derermine which side of the touching particle the jth particle is on 
    if (jthParticle.x > jTouched.x) 
        LR = 1;
    else
        LR = -1;
    end
end 