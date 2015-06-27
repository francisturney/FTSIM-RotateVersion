function NormalizeMomentArms(particleArray,nParticles)
   for i=1:nParticles
        if particleArray(i).isCFM
            particleArray(i).mG = particleArray(i).mG/particleArray(i).r;
            particleArray(i).mD = particleArray(i).mD/particleArray(i).r;
        end
   end 
end

