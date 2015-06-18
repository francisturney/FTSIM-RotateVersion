function c = whichSide(P,i,j) %which side of P(j) is P(i) on (left/right) (c=-1,c=1)
    c = -1;
    if (P(i).x > P(j).x) 
        c = 1;
    else
        c = -1;
    end
end 