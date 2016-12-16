function iLOAD=getILoad(v,s,iL,y,g,Dv,Di)


vVector=Dv*v;
i_PQ=zeros(3,1);
i_I=zeros(3,1);
i_y=zeros(3,1);
for ii=1:length(vVector)
    i_PQ(ii)=fPQ(vVector(ii),s(ii));
    i_I(ii)=fI(vVector(ii),iL(ii));
    i_y(ii)=fY(vVector(ii),y(ii));
end

iLOAD=[  Di*i_PQ, Di *i_I,   Di* i_y]*g.';
% iLOAD=[  Di*conj( s./(Dv*v)), Di * iL,   Di* diag(y)* Dv*v]*g.';

end