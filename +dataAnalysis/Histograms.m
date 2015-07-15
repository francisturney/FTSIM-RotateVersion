%DATA ANALYSIS 
%extract data from P into variable mG, mD and uft
N = 500;             %Psudeo Size for whatever matrix we are working with
% for i=1:N
%     if Ptot(i).CFM
%         Ptot(i).mG = Ptot(i).mG/Ptot(i).r;
%         Ptot(i).mD = Ptot(i).mD/Ptot(i).r;
%     end
% end    
mG=[];
mD=[];
topNumber=0;
uft=0;
radii = [];
radiusTot = [];
for i=1:N
    radiusTot(i) = Ptot(i).r;  
    if Ptot(i).CFM          
        if ~isreal(Ptot(i).uft) || (Ptot(i).uft >7)                             %Elimintae outliers
            continue
        end
        topNumber = topNumber+1;                            %indicies for new array for histogram
        %mG(topNumber) = Ptot(i).mG;                        
        %mD(topNumber) = Ptot(i).mD;                       
        uft(topNumber) = Ptot(i).uft;
        radii(topNumber) = Ptot(i).r; 
    end
end
hist(uft,50)
title('Histogram of u_{*_{ft}} for D_{R} = (2-6)')
xlabel('Fluid Threshold Shear Velocity (m/s)')
ylabel('Frequency out of aproximatly 1000')
min(uft)
% edges = logspace(-1,0,101);
% centerBins = geomean([edges(1:end-1);edges(2:end)])
% xbins = 0:0.1:3.5
% [M,X] = hist(uft, centerBins)
% bar(X(2:end),M(2:end))