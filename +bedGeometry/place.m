function [] = place(particleArray,j)  % Places jth particle in between the particle it's touching and the particle its landing on.
                                      % Uses the fact that the center of jth particle is at the intersection of two circes, one centered at the
                                      % touching particle and one centered at the landing particle, both with radii of the their respective
                                      % particles plus the radius of the jth particle
                                      
import bedGeometry.*                  % Package of functions controlling bed Geometry
     
     P = particleArray;                         % Simplify notation for complex calculation
     jthParticle = particleArray(j);            % ...
     init = particleArray(j).touch;             % ...
     final = particleArray(j).land;             % ...
     r1 = P(init).radius + P(j).radius;         % radius of circle one                               
     r2 = P(final).r + P(j).radius;             % radius of circle two 
     
     %SUBSTITUTE VARIABLES
     a = ((r2.^2 - r1.^2) - (P(final).x.^2 - P(init).x.^2) - (P(final).y.^2 - P(init).y.^2))/(P(init).x - P(final).x);
     b = (P(init).y - P(final).y)/(P(init).x - P(final).x);
     c1 = b.^2 + 1;
     c2 = -(2*P(init).y + a*b - 2*b*P(init).x);
     c3 = P(init).x.^2 - a*P(init).x + P(init).y.^2 + (1/4)*a.^2 - r1.^2;
     %SOLVE
     f = [c1 c2 c3];
     roots(f);
     jthParticle.y = max(roots(f));
     jthParticle.x = (1/2)*(a-2*b*P(j).y); 
     jthParticle.center = [jthParticle.x,jthParticle.y];        
end