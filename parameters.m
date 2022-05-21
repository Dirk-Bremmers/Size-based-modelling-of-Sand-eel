clear all
close all
clf


%set parameters
%constants
param.A=15; %growth constant  (g^0.25 / time)
param.a= 0.4; %mortality constant (used in u=a*A*w^-0.25
%param.k %rerpoduction energy budget (A*param.infinity^-0.25)



param.n=75; %amount of grids cells
param.inf= 40; %M_infinity 
param.mat=57; %grid of maturation
param.off= 0.001;  %weight of new recruits


param.w=logspace(log10(param.off),log10(param.inf),param.n);
param.dw = gradient(param.w);
param.psi_mat=zeros(1,param.n);
param.psi_mat(param.mat:end)=1;

param.Fr=0.25; %fishing rate
param.E=0.5; %reproductive efficiency
param.Rmax= 3e8;  %carrying capacity recruits

%----------initial conditions-------%
N0=zeros(1,param.n);
N0(1)=1e6;

%---------call ode45------%
[t,y] = ode23(@growth_function, [0:30], N0, [], param); 

%--------------plots---------%

figure(1)
contourf(t,param.w,real(log10(y))',0:0.25:10);
[t,s]=title('Population dynamics of sand eel in different weight classes','fishing pressure between 3 and 40 gram')
xlabel('Time (y)')
ylabel('Log10 weight (g)')
colorbar
a=colorbar;
ylabel(a,'Log10 indv','FontSize',12,'Rotation',90);
set(gca,'yscale','log')

mu=param.a*param.A*param.w.^-0.25;
figure(2)
plot(real(log10(param.w)),mu)
title('Natural mortality of sand eel in different weight classes')
xlabel('Log10 weight (g) ')
ylabel('*Natural mortality rate')
legend('Mortality rate')





 