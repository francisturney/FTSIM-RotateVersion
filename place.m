function P = place(P,i,final,init)  %Places P(i) in between P(final) and P(init) through the intersection of two circles
     r1 = P(init).r + P(i).r;       %radius of circle one                               
     r2 = P(final).r + P(i).r;      %radius of circle two 
     
     %SUBSTITUTE VARIABLES
     a = ((r2.^2 - r1.^2) - (P(final).x.^2 - P(init).x.^2) - (P(final).y.^2 - P(init).y.^2))/(P(init).x - P(final).x);
     b = (P(init).y - P(final).y)/(P(init).x - P(final).x);
     c1 = b.^2 + 1;
     c2 = -(2*P(init).y + a*b - 2*b*P(init).x);
     c3 = P(init).x.^2 - a*P(init).x + P(init).y.^2 + (1/4)*a.^2 - r1.^2;
     %SOLVE
     f = [c1 c2 c3];
     roots(f);
     P(i).y = max(roots(f));
     P(i).x = (1/2)*(a-2*b*P(i).y); 
     P(i).center = [P(i).x,P(i).y];        
end