function reverse = reversed(P,i,init,c)               %HAS THE PARTICLE REVESED ITS ROLL 
       reverse = false;                               %Particle i is on which side of particle Max 
       switch  whichSide(P,i,init) 
            case 1                                    %if P(i) is right of P(Max)
                if c == -1                            %but was left
                    reverse = true;                   %TERMINATE find position
                end
            case -1                                   %if P(i) is left of P(Max)
                if c == 1                             %but was right
                    reverse = true;                   %TERMINATE find position
                end    
       end
end