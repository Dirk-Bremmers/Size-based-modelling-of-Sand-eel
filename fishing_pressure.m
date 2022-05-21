clear all
close all
clf

for i = [0.25:0.1:0.75]
    
    param.A=15;             % [g^0.25/year]Growth constant
    param.a=0.4;            % [unitless] Mortality constant
    param.n=75;             % Number of grid cells/points/size groups
    param.inf= 40;          %[g] - weight where they only reproduce (same as depth)
    param.mat=57;           %step they mature - when they begin to reproduce 
    param.off=0.001;        %[g] - weight of the smallest ones
   
    param.w=logspace(log10(param.off),log10(param.inf),param.n); %[1/g] - Grid definition
    param.dw = gradient(param.w);
    param.psi_mat=zeros(1,param.n);
    param.psi_mat(param.mat:end)=1;
    
    param.Fr=i;             % [unitless] Fishing pressure
    param.E=0.5;            % [unitless] Reproductive efficiency
    param.Rmax=3e8;         % [individuals] maximum recruitment
    

    N0=zeros(1,param.n);
    N0(1)=1e6;              % [individuals] Initial population
    [t,y] = ode23(@growth_function,[0:30], N0, [], param);

    
     %summation
     yy=y(end,57:75).*param.dw(:,57:75);    
     yyy=sum(yy); %N*W--> total biomass of fished weight classes 
     L=y(end,:).*param.dw; %total biomass of everything in our basin
     LL=sum(L);
     
  %plot
    yyaxis left
    plot(param.Fr,LL,'b*','Linewidth',2)
    ylabel('Biomass log10 (g)')
    set(gca,'FontName','Times New Roman','FontSize',14)

    hold on
    drawnow
    yyaxis right
    ylabel('Biomass log10 (g)')
    plot(param.Fr,yyy,'r*','Linewidth',2)
   
    

end
    title('Total and partial biomass over increasing fishing pressure')
    xlabel('Fishing mortality')
    legend('Biomass of total population','Biomass of mature population')

