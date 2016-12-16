clear all;
clc;
close all;
cd('Case Studies'); 
IEEE13=load('IEEE13YBUSdata'); 
IEEE37=load('IEEE37YBUSdata'); 
IEEE123=load('IEEE123YBUSdata'); 
cd('..'); 

[ validRangeIEEE13, alphaTheoryVecIEEE13 ] = calculateRegions( IEEE13 ); 
[ validRangeIEEE37, alphaTheoryVecIEEE37 ] = calculateRegions( IEEE37); 
[ validRangeIEEE123, alphaTheoryVecIEEE123 ] = calculateRegions( IEEE123); 
validRange=union(union(validRangeIEEE13,validRangeIEEE37),validRangeIEEE123);
alphaTheoryRange=union(union(alphaTheoryVecIEEE13,alphaTheoryVecIEEE37),alphaTheoryVecIEEE123);


x0=2;
y0=2;
width=7;
height=5;
alphaTheoryFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(alphaTheoryFigure, 'Name', 'alphaTheory');
hold on;
h1=plot(validRangeIEEE13,alphaTheoryVecIEEE13,'bo','lineWidth',2);
hold on
h2=plot(validRangeIEEE37,alphaTheoryVecIEEE37,'rv','lineWidth',2);
hold on
h3=plot(validRangeIEEE123,alphaTheoryVecIEEE123,'gs','lineWidth',2);
hold on

Rdist=0.01;
currentAxes=get(alphaTheoryFigure,'CurrentAxes');
set(currentAxes,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',0:10*Rdist:validRange(end));
set(currentAxes, 'YTick', 0:0.1:1); 
ylim([0 1])
set(currentAxes,'fontSize',14); 
grid on; 
xlabel('$R$','FontName','Times New Roman'); 
ylabel('Upper Bound of $\alpha$', 'FontName', 'Times New Roman'); 
set(gca,'FontName','Times New Roman');
legendTEXT=legend([h1, h2, h3], 'IEEE-13', 'IEEE-37', 'IEEE-123');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','NorthWest');
set(gca,'box','on');

if exist('Figures')~=7
    mkdir 'Figures';e
end
cd('Figures');
print -dpdf contractionModulus.pdf
print -depsc2 contractionModulus
cd('..'); 

% %% Running IEEE13
% 
% alphaNumericVecIEEE13=zeros(size(validRangeIEEE13));
% successVecIEEE13=zeros(size(validRangeIEEE13)); 
% for ii=1:length(validRangeIEEE13)
%     R=validRangeIEEE13(ii);
% [ alphaNumericVecIEEE13(ii), successVecIEEE13(ii) ] = ZBUSR(IEEE13  , R);
% end
% 
% 
% %% Running IEEE37
% alphaNumericVecIEEE37=zeros(size(validRangeIEEE37));
% successVecIEEE37=zeros(size(validRangeIEEE37)); 
% for ii=1:length(validRangeIEEE37)
%     R=validRangeIEEE37(ii);
% [ alphaNumericVecIEEE37(ii), successVecIEEE37(ii) ] = ZBUSR(IEEE37  , R);
% end
% 
% 
% %% Running IEEE123
% alphaNumericVecIEEE123=zeros(size(validRangeIEEE123));
% successVecIEEE123=zeros(size(validRangeIEEE123)); 
% for ii=1:length(validRangeIEEE123)
%     R=validRangeIEEE123(ii);
% [ alphaNumericVecIEEE123(ii), successVecIEEE123(ii) ] = ZBUSR(IEEE123  , R);
% end
% 
% 
% 
% alphaNumericRange=union(union(alphaNumericVecIEEE13, alphaNumericVecIEEE37), alphaNumericVecIEEE123); 
% 
% 
% h4=plot(validRangeIEEE13, alphaNumericVecIEEE13,'b--', 'lineWidth',2); 
% hold on
% h5=plot(validRangeIEEE37, alphaNumericVecIEEE37, 'r--', 'lineWidth',2); 
% hold on
% h6=plot(validRangeIEEE123, alphaNumericVecIEEE123, 'g--', 'lineWidth',2) ;
% 
% 
% 
% 
% 
% 
% 
% 
% % ylabel('Acceptable region of $R$'); 
% legendTEXT=legend([h1, h2, h3, h4, h5, h6], 'IEEE-13', 'IEEE-37', 'IEEE-123', 'Nmeric IEEE-13', 'Numeric IEEE-37', 'Numeric IEEE-123');
% set(legendTEXT,'interpreter','Latex'); 
% set(legendTEXT,'fontSize',14); 
% set(legendTEXT,'fontname','Times New Roman');
% set(legendTEXT,'fontWeight','Bold');
% set(legend,'orientation','Vertical'); 
% set(legend,'location','East');
% set(gca,'box','on');
% 
% print('-dpdf', 'alphaDiffNetworks'); 
