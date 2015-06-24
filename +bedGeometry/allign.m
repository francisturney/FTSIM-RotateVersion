function [] = allign(particleArray,j)                       % Align particles on surface after overlap from collision
import bedGeometry.*                                % Package of functions controlling bed Geometry
jthParticle = particleArray(j);                     % More readable notation
jTouched = particleArray(particleArray(j).touch);  % Particle that jth particle is touching
LR = jthParticle.LR;                                % Left/Right coeficient (-1) for left (+1) for right    

    theta = asin((jthParticle.y - jTouched.y)/pdist([jthParticle.center; jTouched.center],'euclidean'));     % theta is the angle of impact axis against horizontal
    distance = jthParticle.radius + jTouched.radius;                                                        %distance new distance between center of particles
    jthPaticle.y = jTouched.y + distance*sin(theta);
    jthParticle.x = jTouched.x + LR*distance*cos(theta);
    jthPaticle.center=[jthPaticle.x,jthParticle.y];
end