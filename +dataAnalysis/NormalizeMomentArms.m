function P = NormalizeMomentArms(P,N)
   for i=1:N
        if P(i).top
            P(i).mG = P(i).mG/P(i).r;
            P(i).mD = P(i).mD/P(i).r;
        end
   end 
end

