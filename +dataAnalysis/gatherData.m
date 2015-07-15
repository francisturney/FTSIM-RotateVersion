function P = gatherData(particleArray,nParticles)
    P = struct('x',0,'z',0,'r',0,'center',[],'top',false,'CFM',false,'mD',0,'mG',0,'uft',0,...
        'pivPoint',[],'liftPoint',0,'expArea',0);
    for i=1:nParticles
        P(i).x = particleArray(i).x;
        P(i).z = particleArray(i).z;
        P(i).r = particleArray(i).r;
        P(i).center = particleArray(i).center;
        P(i).top = particleArray(i).isTop;
        P(i).CFM = particleArray(i).isCFM;
        P(i).mD = particleArray(i).dragMomentArm;
        P(i).mG = particleArray(i).gravityMomentArm;
        P(i).uft = particleArray(i).uft;
        P(i).pivPoint = particleArray(i).pivotPoint;
        P(i).liftPoint = particleArray(i).liftPoint;
    end
end