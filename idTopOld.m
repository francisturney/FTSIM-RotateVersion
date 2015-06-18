function P = idTopOld(P,N)                         %IDENTIFY TOP LAYER OF PARTICLES BY ASSIGNING P(I).TOP TO TRUE OR FALSE
   for i=1:N                                               %reset top
        P(i).top = false; 
    end
    for i=50:120
        top = false;
        for y = 55:-1:0 
            for j=1:N
                if (pdist([[i,y]; P(j).center],'euclidean') <= (P(j).r + 2))
                   P(j).top = true;
                   top = true;
                end
            end
            if top
                break;
            end
        end
    end
end