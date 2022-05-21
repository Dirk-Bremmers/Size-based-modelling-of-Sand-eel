
%set for loop
function dydt = growth_function(t,y,param); 
N=y(1:param.n); 

%------------ loops ----------%
for i = 2:param.n
    Ja_g(i)= (param.A*param.w(i-1)^(3/4))*(1-(param.w(i-1)/param.inf)^(1/4))*N(i-1);
end

Rp = sum(param.psi_mat.*param.A*(param.inf^-0.25).*N.*param.dw);

%-------------surface boundary----------%
Ja_g(1) = (param.E*Rp)/(param.Rmax+param.E*Rp)*param.Rmax;

%--------------bottom boundary-----------%
Ja_g(param.n+1) = 0;

for i=1:param.n
    dNdt(i) = -(Ja_g(i+1)-Ja_g(i))/param.dw(i); 
end

%------mortality function-----%
mu=param.a*param.A*param.w.^-0.25;

%---fishing Pressure---%
m_fish= heaviside(param.w -3)*param.Fr;
m_fish= m_fish-heaviside(param.w -20)*param.Fr;


%----------add reactive terms -----------%
dNdt = dNdt-mu.*N'-m_fish.*N';

dydt=dNdt';
end
