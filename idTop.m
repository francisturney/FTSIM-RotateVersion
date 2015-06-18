function P = idTop(P,N)                         %IDENTIFY TOP LAYER OF PARTICLES BY ASSIGNING P(I).TOP TO TRUE OR FALSE
  for i=1:N                                               %reset top
        if P(i).top == true;    
            k=0;                              % Counter for touching above positioned particles
            for j=1:N
                if i == j
                    continue
                end
                if (pdist([P(i).center; P(j).center],'euclidean') <= (P(i).r + P(j).r + 1)) && (P(i).y < P(j).y) %If the P(i) touches and is below P(j) then P(i) is not on top
                        P(i).top = false;
                end
                if P(i).y <= (P(i).r + 1)
                   P(i).top = false;
                end
                if (P(i).x < 10) || (P(i).x > 170)              %If P(i) is too close to the edge of range then it is not on top
                    P(i).top = false;
                end
            end
        end
  end
end
    
