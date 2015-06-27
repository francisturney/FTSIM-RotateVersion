function Print(P,N,ave)
    % Draw Particles in Red
    for i=1:N                                                       %Print to screen
        viscircles(P(i).center,P(i).r);
    end
    % Draw Top Row of Particles in Blue
    for i=1:N                                                              
        if P(i).isTop == true
            viscircles(P(i).center,P(i).r,'EdgeColor','b'); 
        end
    end
    % Draw Pivot Points in Blue
    hold on
    for i=1:N
        if P(i).isCFM
            plot(P(i).pivotPoint(1),P(i).pivotPoint(2),'k.', 'MarkerSize',20);
        end
    end
    for i=1:N                                                              %draw lines indicating lever arms 
        if P(i).isCFM;
            if (P(i).pivotPoint ~= 0)
                lineX = [P(i).x; P(i).pivotPoint(1)];
                lineY = [P(i).y; P(i).pivotPoint(2)];
                line(lineX,lineY,'Color','k');
            end
        end
    end
    % Draw Average Height in Dashed Black Line
    x = linspace(0,160,100);
    y = linspace(ave,ave,100);
    plot(x,y,'--k','LineWidth', 1);
    
    % Draw Anti Pivot Points in Blue
    for i=1:N
        if P(i).isCFM
            viscircles(P(i).liftPoint,0.5, 'EdgeColor', 'b');          %Removed
        end
     end
title('Modeled Particle Bed for Mean Diameter 0.8mm', 'FontSize', 20, 'FontName', 'Times')
%axes('FontSize', 14, 'FontName', 'Times');
xlabel('distance(mm)','FontSize',20,...
       'FontName','Times');
ylabel('height(mm)','FontSize',20,...
       'FontName','Times');

end