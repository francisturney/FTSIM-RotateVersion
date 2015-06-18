%MAIN
%**************************************************************************
%   Simulates the initiation of saltation in an Aolean setting, and
%calculates the fluid threshold shear velocity (uft) for each particle.
%                           STEP LIST  
%   Declare particle structure
%   Creates a random bed of particles
%   Identifies the top layer
%   Calculates the average height of the surface
%   Assigns pivot points
%   Calculates moment arms for Drag and Gravity forces
%   Calculates exposed area based on "anti-pivot points" 
%   Solves for uft through moment balance eqn
%**************************************************************************

%SET NUMBER OF ITERATIONS (M) FOR PARTICLE BED CREATIION AND DATA COLLECTION
    %Total number of particles created equals M times N (N = #particles in bed)
    %Total number of top particles (i.e. canidates for movement) will vary
tic
M = 1;
for i=1:(M)
    fprintf('On model run number %f\n',i);
    try

    %DECLARE PARTICLE AS OBJECT IN STRUCTURE ARRAY
    P = 0;      %P is an array of structure arrays, each particle being a struct array P(i) and P being the array of P(1) - P(N) struct arrays
    P = struct('x',0,'y',0,'r',0,'center',[],'top',false,'mD',0,'mG',0,'uft',0,...
        'pivPoint',[],'antiPivPoint',0,'piv',0,'antiPiv',0,'expArea',0);
    N = 50; %NUMBER OF PARTICLES PER BED                                                                  %number of particles

    %INITIALIZE BED
    P = initializeBed(P,N);

    %INDENTIFY TOP ROW OF PARTICLES
    P=idTopOld(P,N);

    %CALCULATE AVERAGE HEIGHT
    ave = averageHeight(P,N);

    %ASSIGN PIVOT PARTICLES 
    P = assnPivot(P,N);

    %CALCULATE MOMENT ARMS AND ASSIGN PIVOT POINTS
    P = momentArms(P,N);

    %ASSIGN ANTI-PIVOT PARTICLES & CREATE ANTI-PIVOT POINT                   
    P = assnAntiPivot(P,N);

    % Identify top particles that are canidates for movement
    P = idTop(P,N);

    %SOLVE FOR uft FLUID THRESHOLD SHEAR VELOICTY*
    P = solveUft(P,N,ave);

    %NORMALIZE MOMENT ARMS
    P = NormalizeMomentArms(P,N);

%FINISH ITERATION AND ASSIMILATE P INTO PTOT (which contains all the particles created)    
        if i==1
            Ptot = P;
        else
            Ptot = [Ptot,P];
        end
    catch
        continue
    end
end
toc
elapsedTime = toc/60;                                           %give run time in seconds and minutes
fprintf('or %d minutes\n',elapsedTime)
%MODEL STOP
