function P = floorSet(P,i,init,c)                       %Set the particle on floor
    x = 0;                                              %assin a dummy x that will be assigned to P(i).x later on
    if c == 1
        x = (P(init).x + sqrt((P(init).r + P(i).r).^2 - (P(i).r - P(init).y).^2)); %intersection of y = r and circle
    else
        x = (P(init).x - sqrt((P(init).r + P(i).r).^2 - (P(i).r - P(init).y).^2)); %intersection of y = r and circle 
    end
    P(i).x = x;
    P(i).y = P(i).r;
    P(i).center = [P(i).x,P(i).y];
end