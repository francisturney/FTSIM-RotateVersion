% Main With Class
% Main with the particle class utilized
import bedGeometry.*        % Package of functions controlling bed Geometry
import dataAnalysis.*       % Package of functions for data analysis and calculation
import particle
tic
clear

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

% User Imputs
    nParticles = 50;  % Number of particles per bed formation
    mRepetitions = 1; % Number of times a bed is created and data colected
                      % Total number of particles created is mIterations times nParticles
                      % Total number canidates for movement will vary
% Set Up          
    particleArray(nParticles) = particle; % Preallocate memory for particle array
    
for i=1:(mRepetitions)
    fprintf('On iteration number %f\n',i);
    %try
    
    % Initialize Bed
        
        for j=1:nParticles
            particleArray(j) = particle;
            setParticle(particleArray,j);
            fprintf('On particle %i\n',j)                               %print progress          
        end
    Print(particleArray, nParticles, 10);
        
    pause;
    % INDENTIFY TOP ROW OF PARTICLES
    particleArray=idTopOld(particleArray,nParticles);

    % CALCULATE AVERAGE HEIGHT
    ave = averageHeight(particleArray,nParticles);

    % ASSIGN PIVOT PARTICLES 
    particleArray = assnPivot(particleArray,nParticles);

    % CALCULATE MOMENT ARMS AND ASSIGN PIVOT POINTS
    particleArray = momentArms(particleArray,nParticles);

    % ASSIGN ANTI-PIVOT PARTICLES & CREATE ANTI-PIVOT POINT                   
    particleArray = assnAntiPivot(particleArray,nParticles);

    % Identify top particles that are canidates for movement
    particleArray = idTop(particleArray,nParticles);

    % SOLVE FOR uft FLUID THRESHOLD SHEAR VELOICTY*
    particleArray = solveUft(particleArray,nParticles,ave);

    % NORMALIZE MOMENT ARMS
    particleArray = NormalizeMomentArms(particleArray,nParticles);

%FINISH ITERATION AND ASSIMILATE P INTO PTOT (which contains all the particles created)    
        if i==1
            Ptot = particleArray;
        else
            Ptot = [Ptot,particleArray];
        end
    %catch
       % continue
    %end
end
toc
elapsedTime = toc/60;                                           %give run time in seconds and minutes
fprintf('or %d minutes\n',elapsedTime)
%MODEL STOP
