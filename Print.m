function [] = Print(P,N,ave);
    %DRAW PARTICLES IN RED
    for i=1:N                                                       %Print to screen
        viscircles(P(i).center,P(i).r);
    end
    %DRAW TOP ROW IN BLUE
    for i=1:N                                                              
        if P(i).mD > 0
            viscircles(P(i).center,P(i).r,'EdgeColor','b'); 
        end
    end
    %DRAW PIVOT POINTS AND MOMENT ARMS
    hold on
    for i=1:N
        if P(i).top
            plot(P(i).pivPoint(1),P(i).pivPoint(2),'k.', 'MarkerSize',20);
        end
    end
    for i=1:N                                                              %draw lines indicating lever arms 
        if P(i).top;
            if (P(i).piv ~= 0)
                lineX = [P(i).x; P(i).pivPoint(1)];
                lineY = [P(i).y; P(i).pivPoint(2)];
                line(lineX,lineY,'Color','k');
            end
        end
    end
    %DRAW AVERAGE HEIGHT
    x = linspace(0,160,100);
    y = linspace(ave,ave,100);
    plot(x,y,'--k','LineWidth', 1);
    %DRAW ANTI-PIVOT POINTS IN BLUE
    %for i=1:N
    %    if P(i).top
    %        %viscircles(P(i).antiPivPoint,0.5, 'EdgeColor', 'b');          %Removed
    %    end
    %end
title('Modeled Particle Bed for Mean Diameter 0.8mm', 'FontSize', 20, 'FontName', 'Times')
%axes('FontSize', 14, 'FontName', 'Times');
xlabel('distance(mm)','FontSize',20,...
       'FontName','Times');
ylabel('height(mm)','FontSize',20,...
       'FontName','Times');

end