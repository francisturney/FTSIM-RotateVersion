function touching = touching(P,i,init,prevInit)             %IS P(I) TOUCHING ANY PARTICLE OTHER THANK P(MAX)AND P(PREVMIN)
    touching = 0;
    for j=(i-1):-1:1                                        %Check particles starting with last
          if ((j == init) || (j == 0)) || (j == prevInit)   %if expceptions
                continue                               
          end
              if pdist([P(i).center; P(j).center],'euclidean') <= (P(i).r + P(j).r) %If distance between particles is less than the
                  touching = j;                                                     %the sum of radii
                  return
              end         
    end
end
           