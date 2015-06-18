function averageHeight = averageHeight(P,N) %CALCULATE AVERAGE HEIGHT OF SURFACE
    averageHeight = 0;
    n = 0;
    for i=1:N
        if P(i).top
            n = n+1;
            averageHeight = averageHeight + P(i).y + P(i).r;
        end
    end
    averageHeight = averageHeight/n;
end