function NormalizeMomentArms(particleArray,nParticles)
   for i=1:nParticles
        if particleArray(i).isCFM
            particleArray(i).gravityMomentArm = particleArray(i).gravityMomentArm/particleArray(i).r;
            particleArray(i).dragMomentArm = particleArray(i).dragMomentArm/particleArray(i).r;
        end
   end 
end

