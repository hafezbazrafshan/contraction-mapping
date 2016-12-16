clear all;
cd('Results'); 
zbusResults=load('IEEE123ZBusResults'); 
sweepResults=load('IEEE123SWeepResults');
cd('..'); 

allNodesActualLabelsWithRegs=zbusResults.allNodesActualLabelsWithRegs;
N=zbusResults.N;

x0=2;
y0=2;
width=16;
height=5;
figure1=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(figure1, 'Name', 'Voltages');
phase_names = ['a' 'b' 'c'];

for phase=1:3
		
    subplot(3,1,phase)
    plot(1:length(allNodesActualLabelsWithRegs), zbusResults.resultsVmag(:,phase), 'bo',1:length(allNodesActualLabelsWithRegs), sweepResults.resultsVmag(:,phase), 'r+','markerSize',12);
    xlim([0 N+5]);
    ylim([0.9 1.2]);
    grid on;
		set(gca,'XTick', [10:10:length(allNodesActualLabelsWithRegs)-15, length(allNodesActualLabelsWithRegs)-4],'YTick', [0.95:0.05:1.05] );
    set(gca,'XTickLabel', [allNodesActualLabelsWithRegs(10:10:end-15) ;allNodesActualLabelsWithRegs(end-4)]);
    set(gca,'XMinorTick','on')
	legendTEXT=legend('FB-Sweep', 'Z-BUS ');
    set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','horizontal'); 
set(legend,'location','NorthEast');
set(gca,'box','on');
    set(gca,'fontSize',14); 
set(0,'defaulttextinterpreter','latex')
    ylabel(sprintf('Phase %c ',phase_names(phase)), 'FontWeight','bold');

    if phase==3
        xlabel('Nodes');
    end
end


if exist('Figures')~=7
    mkdir Figures;
end
cd('Figures'); 
print -dpdf IEEE123magnitudes.pdf
print -depsc2 IEEE123magnitudes
cd('..');


x0=2;
y0=2;
width=16;
height=5;
figure2=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(figure1, 'Name', 'Phases');
phase_names = ['a' 'b' 'c'];

for phase=1:3
		
    subplot(3,1,phase)
    plot(1:length(allNodesActualLabelsWithRegs), zbusResults.resultsVPhase(:,phase), 'bo', 1:length(allNodesActualLabelsWithRegs), sweepResults.resultsVPhase(:,phase), 'r+','markerSize',12);
    xlim([0 N+5])
    if phase==1
    ylim([-10 10]);
    elseif phase==2
    ylim([-130 -110]); 
    else
    ylim([110 130]);
    end
    grid on;
		set(gca,'XTick', [10:10:length(allNodesActualLabelsWithRegs)-15, length(allNodesActualLabelsWithRegs)-4] );
    set(gca,'XTickLabel', [allNodesActualLabelsWithRegs(10:10:end-15) ;allNodesActualLabelsWithRegs(end-4)]);
    set(gca,'XMinorTick','on')
    	legendTEXT=legend('FB-Sweep', 'Z-BUS ');
    set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','horizontal'); 
set(legend,'location','NorthEast');
set(gca,'box','on');
set(gca,'fontSize',14); 
set(0,'defaulttextinterpreter','latex')

    ylabel(sprintf('Phase %c ',phase_names(phase)), 'FontWeight','bold');
    
    if phase==3
        xlabel('Nodes');
    end
end

cd('Figures'); 
print -dpdf IEEE123phases.pdf
print -depsc2 IEEE123phases
cd('..');