function P = allign(P,i,j,c)                %ALIGN particles on surface in case of overlap
    th = asin((P(i).y - P(j).y)/pdist([P(i).center; P(j).center],'euclidean')); %th = theta angle of impact axis against horizontal
    dist2 = P(i).r + P(j).r;                                                  %dist2 new distance between center of particles
    P(i).y = P(j).y + dist2*sin(th);
    P(i).x = P(j).x + c*dist2*cos(th);
    P(i).center=[P(i).x,P(i).y];
end