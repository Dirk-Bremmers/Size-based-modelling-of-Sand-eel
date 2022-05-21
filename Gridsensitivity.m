clear all
close all
clf


for  i=[38:1:42]

    param.A=15; 
    param.a=0.4; 
    param.n=i;               % Number of grid cells/points/size groups
    param.inf= 40;           %[g] - weight where they only reproduce (same as depth)
    param.mat=57;            %step they mature - when they begin to reproduce 
    param.off=0.001;         %[g] - weight of the smallest ones
    
    param.w=logspace(log10(param.off),log10(param.inf),param.n); %[1/g] - Grid definition
    param.dw = gradient(param.w);
    param.psi_mat=zeros(1,param.n);
    param.psi_mat(param.mat:end)=1;
    
    param.Fr=0.25;
    param.E=0.5;
    param.Rmax=3e8;
    

    N0=zeros(1,param.n);
    N0(1)=1e6;
    [t,y] = ode23(@growth_function,[0:30], N0, [], param);

    figure(1)
    plot(log10(y(end,:)),(log10(param.w)),'--.', 'Linewidth',1)
    hold on
    drawnow
end
title('Grid sensitivity 38-42')
legend('n=38','n=39','n=40','n=41','n=42','location','northwest')
xlabel('Log10(Individuals)')
ylabel('Log10(weight (g))')


for    i=[65:5:85] 

    param.A=15; 
    param.a=0.4; 
    param.n=i;               % Number of grid cells/points/size groups
    param.inf= 40;           %[g] - weight where they only reproduce (same as depth)
    param.mat=57;            %step they mature - when they begin to reproduce 
    param.off=0.001;         %[g] - weight of the smallest ones
    
    param.w=logspace(log10(param.off),log10(param.inf),param.n); %[1/g] - Grid definition
    param.dw = gradient(param.w);
    param.psi_mat=zeros(1,param.n);
    param.psi_mat(param.mat:end)=1;
    
    param.Fr=0.25;          % [unitless] Fishing pressure
    param.E=0.5;            % [unitless] Reproductive efficiency
    param.Rmax=3e8;         % [individuals] maximum recruitment
    

    N0=zeros(1,param.n);
    N0(1)=1e6;
    [t,y] = ode23(@growth_function,[0:30], N0, [], param);

    figure(2)
    plot(log10(y(end,:)),(log10(param.w)),'--.', 'Linewidth',1)
    hold on
    drawnow
end
title('Grid sensitivty 65-85')
legend('n=65','n=70','n=75','n=80','n=85')
xlabel('Log10(Individuals)')
ylabel('Log10 weight (g)')

