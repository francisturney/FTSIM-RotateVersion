classdef particle < handle
    properties
        % Particle Geometry and Forces
        radius                  % Radius of assumed spherical particle
        x                       % X position of particle
        y                       % Y postition of particle
        center = [0,0]          % 2D particle center loctation for Matlab functions
        accel = [0,0,-9.8]      % 3D acceleration on a particle's center of mass
        isTop = false           % True/False for member of top row of particles in bed
        dragMomentArm           % Moment arm that the drag force works on
        gravityMomentArm        % Moment arm the gravity works on
        fluidThreshold          % Fluid Threshold Shear Veloicty
        pivotPoint              % Location of pivot point (considering a left to right wind)
        
        % Indicies of adjacent particles and orientation
        touching = 0;               %particle i has landed on
        landing = 0;              %particle i will land on
        prevTouch = 0;           %init from previous loop  
        LR = 0;                  %particle oriantation coeficint: (-1) for left (1) for right

        
    end
    methods
        function particle = particle(radius, stdDeviation)              % Constructor
            if  nargin == 0
                particle.radius = 4 + 1.*randn(1,1);                       %Particle radius  
                particle.x = 20 + (120).*rand(1);                          %x coordinate of center                                         
                particle.y = 70;                                           %y coordinate of center
                particle.center = [particle.x,particle.y];   
            end
        end
        function [] = change(particleArray)
            particleArray(1).radius = 0;
        end
    
        function particle = move(particle, timeStep)
           if particle.accel ~= [0,0,0];
               
           end
        end
    end
    methods (Static)
        function text = secondCommand()
           text = 'secondCommand'; 
        end
    end
    
end
