(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[535],{9685:(t,a,n)=>{"use strict";n.d(a,{Ib:()=>r,WT:()=>u});var r=1e-6,u="undefined"!=typeof Float32Array?Float32Array:Array;Math.random;Math.PI;Math.hypot||(Math.hypot=function(){for(var t=0,a=arguments.length;a--;)t+=arguments[a]*arguments[a];return Math.sqrt(t)})},5600:(t,a,n)=>{"use strict";n.d(a,{Ue:()=>u,p4:()=>h,U_:()=>M,GH:()=>s,Jp:()=>e,Iu:()=>o,U1:()=>i,bA:()=>c,en:()=>b});var r=n(9685);function u(){var t=new r.WT(9);return r.WT!=Float32Array&&(t[1]=0,t[2]=0,t[3]=0,t[5]=0,t[6]=0,t[7]=0),t[0]=1,t[4]=1,t[8]=1,t}function h(t,a){if(t===a){var n=a[1],r=a[2],u=a[5];t[1]=a[3],t[2]=a[6],t[3]=n,t[5]=a[7],t[6]=r,t[7]=u}else t[0]=a[0],t[1]=a[3],t[2]=a[6],t[3]=a[1],t[4]=a[4],t[5]=a[7],t[6]=a[2],t[7]=a[5],t[8]=a[8];return t}function M(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=a[4],s=a[5],e=a[6],o=a[7],i=a[8],c=i*M-s*o,b=-i*h+s*e,f=o*h-M*e,v=n*c+r*b+u*f;return v?(v=1/v,t[0]=c*v,t[1]=(-i*r+u*o)*v,t[2]=(s*r-u*M)*v,t[3]=b*v,t[4]=(i*n-u*e)*v,t[5]=(-s*n+u*h)*v,t[6]=f*v,t[7]=(-o*n+r*e)*v,t[8]=(M*n-r*h)*v,t):null}function s(t){var a=t[0],n=t[1],r=t[2],u=t[3],h=t[4],M=t[5],s=t[6],e=t[7],o=t[8];return a*(o*h-M*e)+n*(-o*u+M*s)+r*(e*u-h*s)}function e(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3],s=a[4],e=a[5],o=a[6],i=a[7],c=a[8],b=n[0],f=n[1],v=n[2],I=n[3],l=n[4],m=n[5],y=n[6],x=n[7],p=n[8];return t[0]=b*r+f*M+v*o,t[1]=b*u+f*s+v*i,t[2]=b*h+f*e+v*c,t[3]=I*r+l*M+m*o,t[4]=I*u+l*s+m*i,t[5]=I*h+l*e+m*c,t[6]=y*r+x*M+p*o,t[7]=y*u+x*s+p*i,t[8]=y*h+x*e+p*c,t}function o(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3],s=a[4],e=a[5],o=a[6],i=a[7],c=a[8],b=n[0],f=n[1];return t[0]=r,t[1]=u,t[2]=h,t[3]=M,t[4]=s,t[5]=e,t[6]=b*r+f*M+o,t[7]=b*u+f*s+i,t[8]=b*h+f*e+c,t}function i(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3],s=a[4],e=a[5],o=a[6],i=a[7],c=a[8],b=Math.sin(n),f=Math.cos(n);return t[0]=f*r+b*M,t[1]=f*u+b*s,t[2]=f*h+b*e,t[3]=f*M-b*r,t[4]=f*s-b*u,t[5]=f*e-b*h,t[6]=o,t[7]=i,t[8]=c,t}function c(t,a,n){var r=n[0],u=n[1];return t[0]=r*a[0],t[1]=r*a[1],t[2]=r*a[2],t[3]=u*a[3],t[4]=u*a[4],t[5]=u*a[5],t[6]=a[6],t[7]=a[7],t[8]=a[8],t}function b(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=n+n,s=r+r,e=u+u,o=n*M,i=r*M,c=r*s,b=u*M,f=u*s,v=u*e,I=h*M,l=h*s,m=h*e;return t[0]=1-c-v,t[3]=i-m,t[6]=b+l,t[1]=i+m,t[4]=1-o-v,t[7]=f-I,t[2]=b-l,t[5]=f+I,t[8]=1-o-c,t}},5975:(t,a,n)=>{"use strict";n.d(a,{p4:()=>u,U_:()=>h,GH:()=>M,Jp:()=>s,Iu:()=>e,bA:()=>o,U1:()=>i,lM:()=>c,uD:()=>b,jI:()=>f,Q$:()=>v,en:()=>I,oy:()=>l,G3:()=>m,M5:()=>y,zB:()=>x,fS:()=>p});var r=n(9685);function u(t,a){if(t===a){var n=a[1],r=a[2],u=a[3],h=a[6],M=a[7],s=a[11];t[1]=a[4],t[2]=a[8],t[3]=a[12],t[4]=n,t[6]=a[9],t[7]=a[13],t[8]=r,t[9]=h,t[11]=a[14],t[12]=u,t[13]=M,t[14]=s}else t[0]=a[0],t[1]=a[4],t[2]=a[8],t[3]=a[12],t[4]=a[1],t[5]=a[5],t[6]=a[9],t[7]=a[13],t[8]=a[2],t[9]=a[6],t[10]=a[10],t[11]=a[14],t[12]=a[3],t[13]=a[7],t[14]=a[11],t[15]=a[15];return t}function h(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=a[4],s=a[5],e=a[6],o=a[7],i=a[8],c=a[9],b=a[10],f=a[11],v=a[12],I=a[13],l=a[14],m=a[15],y=n*s-r*M,x=n*e-u*M,p=n*o-h*M,A=r*e-u*s,k=r*o-h*s,d=u*o-h*e,F=i*I-c*v,T=i*l-b*v,W=i*m-f*v,w=c*l-b*I,U=c*m-f*I,C=b*m-f*l,q=y*C-x*U+p*w+A*W-k*T+d*F;return q?(q=1/q,t[0]=(s*C-e*U+o*w)*q,t[1]=(u*U-r*C-h*w)*q,t[2]=(I*d-l*k+m*A)*q,t[3]=(b*k-c*d-f*A)*q,t[4]=(e*W-M*C-o*T)*q,t[5]=(n*C-u*W+h*T)*q,t[6]=(l*p-v*d-m*x)*q,t[7]=(i*d-b*p+f*x)*q,t[8]=(M*U-s*W+o*F)*q,t[9]=(r*W-n*U-h*F)*q,t[10]=(v*k-I*p+m*y)*q,t[11]=(c*p-i*k-f*y)*q,t[12]=(s*T-M*w-e*F)*q,t[13]=(n*w-r*T+u*F)*q,t[14]=(I*x-v*A-l*y)*q,t[15]=(i*A-c*x+b*y)*q,t):null}function M(t){var a=t[0],n=t[1],r=t[2],u=t[3],h=t[4],M=t[5],s=t[6],e=t[7],o=t[8],i=t[9],c=t[10],b=t[11],f=t[12],v=t[13],I=t[14],l=t[15];return(a*M-n*h)*(c*l-b*I)-(a*s-r*h)*(i*l-b*v)+(a*e-u*h)*(i*I-c*v)+(n*s-r*M)*(o*l-b*f)-(n*e-u*M)*(o*I-c*f)+(r*e-u*s)*(o*v-i*f)}function s(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3],s=a[4],e=a[5],o=a[6],i=a[7],c=a[8],b=a[9],f=a[10],v=a[11],I=a[12],l=a[13],m=a[14],y=a[15],x=n[0],p=n[1],A=n[2],k=n[3];return t[0]=x*r+p*s+A*c+k*I,t[1]=x*u+p*e+A*b+k*l,t[2]=x*h+p*o+A*f+k*m,t[3]=x*M+p*i+A*v+k*y,x=n[4],p=n[5],A=n[6],k=n[7],t[4]=x*r+p*s+A*c+k*I,t[5]=x*u+p*e+A*b+k*l,t[6]=x*h+p*o+A*f+k*m,t[7]=x*M+p*i+A*v+k*y,x=n[8],p=n[9],A=n[10],k=n[11],t[8]=x*r+p*s+A*c+k*I,t[9]=x*u+p*e+A*b+k*l,t[10]=x*h+p*o+A*f+k*m,t[11]=x*M+p*i+A*v+k*y,x=n[12],p=n[13],A=n[14],k=n[15],t[12]=x*r+p*s+A*c+k*I,t[13]=x*u+p*e+A*b+k*l,t[14]=x*h+p*o+A*f+k*m,t[15]=x*M+p*i+A*v+k*y,t}function e(t,a,n){var r,u,h,M,s,e,o,i,c,b,f,v,I=n[0],l=n[1],m=n[2];return a===t?(t[12]=a[0]*I+a[4]*l+a[8]*m+a[12],t[13]=a[1]*I+a[5]*l+a[9]*m+a[13],t[14]=a[2]*I+a[6]*l+a[10]*m+a[14],t[15]=a[3]*I+a[7]*l+a[11]*m+a[15]):(r=a[0],u=a[1],h=a[2],M=a[3],s=a[4],e=a[5],o=a[6],i=a[7],c=a[8],b=a[9],f=a[10],v=a[11],t[0]=r,t[1]=u,t[2]=h,t[3]=M,t[4]=s,t[5]=e,t[6]=o,t[7]=i,t[8]=c,t[9]=b,t[10]=f,t[11]=v,t[12]=r*I+s*l+c*m+a[12],t[13]=u*I+e*l+b*m+a[13],t[14]=h*I+o*l+f*m+a[14],t[15]=M*I+i*l+v*m+a[15]),t}function o(t,a,n){var r=n[0],u=n[1],h=n[2];return t[0]=a[0]*r,t[1]=a[1]*r,t[2]=a[2]*r,t[3]=a[3]*r,t[4]=a[4]*u,t[5]=a[5]*u,t[6]=a[6]*u,t[7]=a[7]*u,t[8]=a[8]*h,t[9]=a[9]*h,t[10]=a[10]*h,t[11]=a[11]*h,t[12]=a[12],t[13]=a[13],t[14]=a[14],t[15]=a[15],t}function i(t,a,n,u){var h,M,s,e,o,i,c,b,f,v,I,l,m,y,x,p,A,k,d,F,T,W,w,U,C=u[0],q=u[1],K=u[2],H=Math.hypot(C,q,K);return H<r.Ib?null:(C*=H=1/H,q*=H,K*=H,h=Math.sin(n),s=1-(M=Math.cos(n)),e=a[0],o=a[1],i=a[2],c=a[3],b=a[4],f=a[5],v=a[6],I=a[7],l=a[8],m=a[9],y=a[10],x=a[11],p=C*C*s+M,A=q*C*s+K*h,k=K*C*s-q*h,d=C*q*s-K*h,F=q*q*s+M,T=K*q*s+C*h,W=C*K*s+q*h,w=q*K*s-C*h,U=K*K*s+M,t[0]=e*p+b*A+l*k,t[1]=o*p+f*A+m*k,t[2]=i*p+v*A+y*k,t[3]=c*p+I*A+x*k,t[4]=e*d+b*F+l*T,t[5]=o*d+f*F+m*T,t[6]=i*d+v*F+y*T,t[7]=c*d+I*F+x*T,t[8]=e*W+b*w+l*U,t[9]=o*W+f*w+m*U,t[10]=i*W+v*w+y*U,t[11]=c*W+I*w+x*U,a!==t&&(t[12]=a[12],t[13]=a[13],t[14]=a[14],t[15]=a[15]),t)}function c(t,a,n){var r=Math.sin(n),u=Math.cos(n),h=a[4],M=a[5],s=a[6],e=a[7],o=a[8],i=a[9],c=a[10],b=a[11];return a!==t&&(t[0]=a[0],t[1]=a[1],t[2]=a[2],t[3]=a[3],t[12]=a[12],t[13]=a[13],t[14]=a[14],t[15]=a[15]),t[4]=h*u+o*r,t[5]=M*u+i*r,t[6]=s*u+c*r,t[7]=e*u+b*r,t[8]=o*u-h*r,t[9]=i*u-M*r,t[10]=c*u-s*r,t[11]=b*u-e*r,t}function b(t,a,n){var r=Math.sin(n),u=Math.cos(n),h=a[0],M=a[1],s=a[2],e=a[3],o=a[8],i=a[9],c=a[10],b=a[11];return a!==t&&(t[4]=a[4],t[5]=a[5],t[6]=a[6],t[7]=a[7],t[12]=a[12],t[13]=a[13],t[14]=a[14],t[15]=a[15]),t[0]=h*u-o*r,t[1]=M*u-i*r,t[2]=s*u-c*r,t[3]=e*u-b*r,t[8]=h*r+o*u,t[9]=M*r+i*u,t[10]=s*r+c*u,t[11]=e*r+b*u,t}function f(t,a,n){var r=Math.sin(n),u=Math.cos(n),h=a[0],M=a[1],s=a[2],e=a[3],o=a[4],i=a[5],c=a[6],b=a[7];return a!==t&&(t[8]=a[8],t[9]=a[9],t[10]=a[10],t[11]=a[11],t[12]=a[12],t[13]=a[13],t[14]=a[14],t[15]=a[15]),t[0]=h*u+o*r,t[1]=M*u+i*r,t[2]=s*u+c*r,t[3]=e*u+b*r,t[4]=o*u-h*r,t[5]=i*u-M*r,t[6]=c*u-s*r,t[7]=b*u-e*r,t}function v(t,a){var n=a[0],r=a[1],u=a[2],h=a[4],M=a[5],s=a[6],e=a[8],o=a[9],i=a[10];return t[0]=Math.hypot(n,r,u),t[1]=Math.hypot(h,M,s),t[2]=Math.hypot(e,o,i),t}function I(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=n+n,s=r+r,e=u+u,o=n*M,i=r*M,c=r*s,b=u*M,f=u*s,v=u*e,I=h*M,l=h*s,m=h*e;return t[0]=1-c-v,t[1]=i+m,t[2]=b-l,t[3]=0,t[4]=i-m,t[5]=1-o-v,t[6]=f+I,t[7]=0,t[8]=b+l,t[9]=f-I,t[10]=1-o-c,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,t}function l(t,a,n,r,u,h,M){var s=1/(n-a),e=1/(u-r),o=1/(h-M);return t[0]=2*h*s,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=2*h*e,t[6]=0,t[7]=0,t[8]=(n+a)*s,t[9]=(u+r)*e,t[10]=(M+h)*o,t[11]=-1,t[12]=0,t[13]=0,t[14]=M*h*2*o,t[15]=0,t}function m(t,a,n,r,u){var h,M=1/Math.tan(a/2);return t[0]=M/n,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=M,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[11]=-1,t[12]=0,t[13]=0,t[15]=0,null!=u&&u!==1/0?(h=1/(r-u),t[10]=(u+r)*h,t[14]=2*u*r*h):(t[10]=-1,t[14]=-2*r),t}function y(t,a,n,r,u,h,M){var s=1/(a-n),e=1/(r-u),o=1/(h-M);return t[0]=-2*s,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=-2*e,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=2*o,t[11]=0,t[12]=(a+n)*s,t[13]=(u+r)*e,t[14]=(M+h)*o,t[15]=1,t}function x(t,a,n,u){var h,M,s,e,o,i,c,b,f,v,I=a[0],l=a[1],m=a[2],y=u[0],x=u[1],p=u[2],A=n[0],k=n[1],d=n[2];return Math.abs(I-A)<r.Ib&&Math.abs(l-k)<r.Ib&&Math.abs(m-d)<r.Ib?function(t){return t[0]=1,t[1]=0,t[2]=0,t[3]=0,t[4]=0,t[5]=1,t[6]=0,t[7]=0,t[8]=0,t[9]=0,t[10]=1,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,t}(t):(c=I-A,b=l-k,f=m-d,h=x*(f*=v=1/Math.hypot(c,b,f))-p*(b*=v),M=p*(c*=v)-y*f,s=y*b-x*c,(v=Math.hypot(h,M,s))?(h*=v=1/v,M*=v,s*=v):(h=0,M=0,s=0),e=b*s-f*M,o=f*h-c*s,i=c*M-b*h,(v=Math.hypot(e,o,i))?(e*=v=1/v,o*=v,i*=v):(e=0,o=0,i=0),t[0]=h,t[1]=e,t[2]=c,t[3]=0,t[4]=M,t[5]=o,t[6]=b,t[7]=0,t[8]=s,t[9]=i,t[10]=f,t[11]=0,t[12]=-(h*I+M*l+s*m),t[13]=-(e*I+o*l+i*m),t[14]=-(c*I+b*l+f*m),t[15]=1,t)}function p(t,a){var n=t[0],u=t[1],h=t[2],M=t[3],s=t[4],e=t[5],o=t[6],i=t[7],c=t[8],b=t[9],f=t[10],v=t[11],I=t[12],l=t[13],m=t[14],y=t[15],x=a[0],p=a[1],A=a[2],k=a[3],d=a[4],F=a[5],T=a[6],W=a[7],w=a[8],U=a[9],C=a[10],q=a[11],K=a[12],H=a[13],E=a[14],G=a[15];return Math.abs(n-x)<=r.Ib*Math.max(1,Math.abs(n),Math.abs(x))&&Math.abs(u-p)<=r.Ib*Math.max(1,Math.abs(u),Math.abs(p))&&Math.abs(h-A)<=r.Ib*Math.max(1,Math.abs(h),Math.abs(A))&&Math.abs(M-k)<=r.Ib*Math.max(1,Math.abs(M),Math.abs(k))&&Math.abs(s-d)<=r.Ib*Math.max(1,Math.abs(s),Math.abs(d))&&Math.abs(e-F)<=r.Ib*Math.max(1,Math.abs(e),Math.abs(F))&&Math.abs(o-T)<=r.Ib*Math.max(1,Math.abs(o),Math.abs(T))&&Math.abs(i-W)<=r.Ib*Math.max(1,Math.abs(i),Math.abs(W))&&Math.abs(c-w)<=r.Ib*Math.max(1,Math.abs(c),Math.abs(w))&&Math.abs(b-U)<=r.Ib*Math.max(1,Math.abs(b),Math.abs(U))&&Math.abs(f-C)<=r.Ib*Math.max(1,Math.abs(f),Math.abs(C))&&Math.abs(v-q)<=r.Ib*Math.max(1,Math.abs(v),Math.abs(q))&&Math.abs(I-K)<=r.Ib*Math.max(1,Math.abs(I),Math.abs(K))&&Math.abs(l-H)<=r.Ib*Math.max(1,Math.abs(l),Math.abs(H))&&Math.abs(m-E)<=r.Ib*Math.max(1,Math.abs(m),Math.abs(E))&&Math.abs(y-G)<=r.Ib*Math.max(1,Math.abs(y),Math.abs(G))}},2945:(t,a,n)=>{"use strict";n.d(a,{yR:()=>e,yY:()=>o,Jp:()=>i,lM:()=>c,uD:()=>b,jI:()=>f,ZY:()=>v,ZA:()=>I,U_:()=>l,Kx:()=>m,bz:()=>y,IH:()=>T,bA:()=>W,AK:()=>w,t7:()=>U,kE:()=>C,we:()=>q,b0:()=>H});var r=n(9685),u=n(5600),h=n(7160),M=n(8333);function s(){var t=new r.WT(4);return r.WT!=Float32Array&&(t[0]=0,t[1]=0,t[2]=0),t[3]=1,t}function e(t){return t[0]=0,t[1]=0,t[2]=0,t[3]=1,t}function o(t,a,n){n*=.5;var r=Math.sin(n);return t[0]=r*a[0],t[1]=r*a[1],t[2]=r*a[2],t[3]=Math.cos(n),t}function i(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3],s=n[0],e=n[1],o=n[2],i=n[3];return t[0]=r*i+M*s+u*o-h*e,t[1]=u*i+M*e+h*s-r*o,t[2]=h*i+M*o+r*e-u*s,t[3]=M*i-r*s-u*e-h*o,t}function c(t,a,n){n*=.5;var r=a[0],u=a[1],h=a[2],M=a[3],s=Math.sin(n),e=Math.cos(n);return t[0]=r*e+M*s,t[1]=u*e+h*s,t[2]=h*e-u*s,t[3]=M*e-r*s,t}function b(t,a,n){n*=.5;var r=a[0],u=a[1],h=a[2],M=a[3],s=Math.sin(n),e=Math.cos(n);return t[0]=r*e-h*s,t[1]=u*e+M*s,t[2]=h*e+r*s,t[3]=M*e-u*s,t}function f(t,a,n){n*=.5;var r=a[0],u=a[1],h=a[2],M=a[3],s=Math.sin(n),e=Math.cos(n);return t[0]=r*e+u*s,t[1]=u*e-r*s,t[2]=h*e+M*s,t[3]=M*e-h*s,t}function v(t,a){var n=a[0],r=a[1],u=a[2];return t[0]=n,t[1]=r,t[2]=u,t[3]=Math.sqrt(Math.abs(1-n*n-r*r-u*u)),t}function I(t,a,n,u){var h,M,s,e,o,i=a[0],c=a[1],b=a[2],f=a[3],v=n[0],I=n[1],l=n[2],m=n[3];return(M=i*v+c*I+b*l+f*m)<0&&(M=-M,v=-v,I=-I,l=-l,m=-m),1-M>r.Ib?(h=Math.acos(M),s=Math.sin(h),e=Math.sin((1-u)*h)/s,o=Math.sin(u*h)/s):(e=1-u,o=u),t[0]=e*i+o*v,t[1]=e*c+o*I,t[2]=e*b+o*l,t[3]=e*f+o*m,t}function l(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=n*n+r*r+u*u+h*h,s=M?1/M:0;return t[0]=-n*s,t[1]=-r*s,t[2]=-u*s,t[3]=h*s,t}function m(t,a){return t[0]=-a[0],t[1]=-a[1],t[2]=-a[2],t[3]=a[3],t}function y(t,a){var n,r=a[0]+a[4]+a[8];if(r>0)n=Math.sqrt(r+1),t[3]=.5*n,n=.5/n,t[0]=(a[5]-a[7])*n,t[1]=(a[6]-a[2])*n,t[2]=(a[1]-a[3])*n;else{var u=0;a[4]>a[0]&&(u=1),a[8]>a[3*u+u]&&(u=2);var h=(u+1)%3,M=(u+2)%3;n=Math.sqrt(a[3*u+u]-a[3*h+h]-a[3*M+M]+1),t[u]=.5*n,n=.5/n,t[3]=(a[3*h+M]-a[3*M+h])*n,t[h]=(a[3*h+u]+a[3*u+h])*n,t[M]=(a[3*M+u]+a[3*u+M])*n}return t}M.d9,M.al,M.JG,M.t8;var x,p,A,k,d,F,T=M.IH,W=M.bA,w=M.AK,U=M.t7,C=M.kE,q=M.we,K=M.Fv,H=(M.I6,M.fS,x=h.Ue(),p=h.al(1,0,0),A=h.al(0,1,0),function(t,a,n){var r=h.AK(a,n);return r<-.999999?(h.kC(x,p,a),h.Zh(x)<1e-6&&h.kC(x,A,a),h.Fv(x,x),o(t,x,Math.PI),t):r>.999999?(t[0]=0,t[1]=0,t[2]=0,t[3]=1,t):(h.kC(x,a,n),t[0]=x[0],t[1]=x[1],t[2]=x[2],t[3]=1+r,K(t,t))});k=s(),d=s(),F=u.Ue()},1437:(t,a,n)=>{"use strict";n.d(a,{IH:()=>u,tk:()=>h,t7:()=>M,c:()=>s,iu:()=>e,kK:()=>o,fF:()=>i});var r=n(9685);function u(t,a,n){return t[0]=a[0]+n[0],t[1]=a[1]+n[1],t}function h(t,a){return t[0]=-a[0],t[1]=-a[1],t}function M(t,a,n,r){var u=a[0],h=a[1];return t[0]=u+r*(n[0]-u),t[1]=h+r*(n[1]-h),t}function s(t,a,n){var r=a[0],u=a[1];return t[0]=n[0]*r+n[2]*u,t[1]=n[1]*r+n[3]*u,t}function e(t,a,n){var r=a[0],u=a[1];return t[0]=n[0]*r+n[2]*u+n[4],t[1]=n[1]*r+n[3]*u+n[5],t}function o(t,a,n){var r=a[0],u=a[1];return t[0]=n[0]*r+n[3]*u+n[6],t[1]=n[1]*r+n[4]*u+n[7],t}function i(t,a,n){var r=a[0],u=a[1];return t[0]=n[0]*r+n[4]*u+n[12],t[1]=n[1]*r+n[5]*u+n[13],t}var c,b;c=new r.WT(2),r.WT!=Float32Array&&(c[0]=0,c[1]=0),b=c},7160:(t,a,n)=>{"use strict";n.d(a,{Ue:()=>u,kE:()=>h,al:()=>M,IH:()=>s,tk:()=>e,Fv:()=>o,AK:()=>i,kC:()=>c,fF:()=>b,kK:()=>f,VC:()=>v,lM:()=>I,uD:()=>l,jI:()=>m,EU:()=>y,lu:()=>p,dC:()=>A,Zh:()=>k});var r=n(9685);function u(){var t=new r.WT(3);return r.WT!=Float32Array&&(t[0]=0,t[1]=0,t[2]=0),t}function h(t){var a=t[0],n=t[1],r=t[2];return Math.hypot(a,n,r)}function M(t,a,n){var u=new r.WT(3);return u[0]=t,u[1]=a,u[2]=n,u}function s(t,a,n){return t[0]=a[0]+n[0],t[1]=a[1]+n[1],t[2]=a[2]+n[2],t}function e(t,a){return t[0]=-a[0],t[1]=-a[1],t[2]=-a[2],t}function o(t,a){var n=a[0],r=a[1],u=a[2],h=n*n+r*r+u*u;return h>0&&(h=1/Math.sqrt(h)),t[0]=a[0]*h,t[1]=a[1]*h,t[2]=a[2]*h,t}function i(t,a){return t[0]*a[0]+t[1]*a[1]+t[2]*a[2]}function c(t,a,n){var r=a[0],u=a[1],h=a[2],M=n[0],s=n[1],e=n[2];return t[0]=u*e-h*s,t[1]=h*M-r*e,t[2]=r*s-u*M,t}function b(t,a,n){var r=a[0],u=a[1],h=a[2],M=n[3]*r+n[7]*u+n[11]*h+n[15];return M=M||1,t[0]=(n[0]*r+n[4]*u+n[8]*h+n[12])/M,t[1]=(n[1]*r+n[5]*u+n[9]*h+n[13])/M,t[2]=(n[2]*r+n[6]*u+n[10]*h+n[14])/M,t}function f(t,a,n){var r=a[0],u=a[1],h=a[2];return t[0]=r*n[0]+u*n[3]+h*n[6],t[1]=r*n[1]+u*n[4]+h*n[7],t[2]=r*n[2]+u*n[5]+h*n[8],t}function v(t,a,n){var r=n[0],u=n[1],h=n[2],M=n[3],s=a[0],e=a[1],o=a[2],i=u*o-h*e,c=h*s-r*o,b=r*e-u*s,f=u*b-h*c,v=h*i-r*b,I=r*c-u*i,l=2*M;return i*=l,c*=l,b*=l,f*=2,v*=2,I*=2,t[0]=s+i+f,t[1]=e+c+v,t[2]=o+b+I,t}function I(t,a,n,r){var u=[],h=[];return u[0]=a[0]-n[0],u[1]=a[1]-n[1],u[2]=a[2]-n[2],h[0]=u[0],h[1]=u[1]*Math.cos(r)-u[2]*Math.sin(r),h[2]=u[1]*Math.sin(r)+u[2]*Math.cos(r),t[0]=h[0]+n[0],t[1]=h[1]+n[1],t[2]=h[2]+n[2],t}function l(t,a,n,r){var u=[],h=[];return u[0]=a[0]-n[0],u[1]=a[1]-n[1],u[2]=a[2]-n[2],h[0]=u[2]*Math.sin(r)+u[0]*Math.cos(r),h[1]=u[1],h[2]=u[2]*Math.cos(r)-u[0]*Math.sin(r),t[0]=h[0]+n[0],t[1]=h[1]+n[1],t[2]=h[2]+n[2],t}function m(t,a,n,r){var u=[],h=[];return u[0]=a[0]-n[0],u[1]=a[1]-n[1],u[2]=a[2]-n[2],h[0]=u[0]*Math.cos(r)-u[1]*Math.sin(r),h[1]=u[0]*Math.sin(r)+u[1]*Math.cos(r),h[2]=u[2],t[0]=h[0]+n[0],t[1]=h[1]+n[1],t[2]=h[2]+n[2],t}function y(t,a){var n=t[0],r=t[1],u=t[2],h=a[0],M=a[1],s=a[2],e=Math.sqrt(n*n+r*r+u*u)*Math.sqrt(h*h+M*M+s*s),o=e&&i(t,a)/e;return Math.acos(Math.min(Math.max(o,-1),1))}var x,p=function(t,a,n){return t[0]=a[0]-n[0],t[1]=a[1]-n[1],t[2]=a[2]-n[2],t},A=function(t,a,n){return t[0]=a[0]*n[0],t[1]=a[1]*n[1],t[2]=a[2]*n[2],t},k=h;x=u()},8333:(t,a,n)=>{"use strict";n.d(a,{d9:()=>u,al:()=>h,JG:()=>M,t8:()=>s,IH:()=>e,bA:()=>o,kE:()=>i,we:()=>c,Fv:()=>b,AK:()=>f,t7:()=>v,fF:()=>I,VC:()=>l,I6:()=>m,fS:()=>y});var r=n(9685);function u(t){var a=new r.WT(4);return a[0]=t[0],a[1]=t[1],a[2]=t[2],a[3]=t[3],a}function h(t,a,n,u){var h=new r.WT(4);return h[0]=t,h[1]=a,h[2]=n,h[3]=u,h}function M(t,a){return t[0]=a[0],t[1]=a[1],t[2]=a[2],t[3]=a[3],t}function s(t,a,n,r,u){return t[0]=a,t[1]=n,t[2]=r,t[3]=u,t}function e(t,a,n){return t[0]=a[0]+n[0],t[1]=a[1]+n[1],t[2]=a[2]+n[2],t[3]=a[3]+n[3],t}function o(t,a,n){return t[0]=a[0]*n,t[1]=a[1]*n,t[2]=a[2]*n,t[3]=a[3]*n,t}function i(t){var a=t[0],n=t[1],r=t[2],u=t[3];return Math.hypot(a,n,r,u)}function c(t){var a=t[0],n=t[1],r=t[2],u=t[3];return a*a+n*n+r*r+u*u}function b(t,a){var n=a[0],r=a[1],u=a[2],h=a[3],M=n*n+r*r+u*u+h*h;return M>0&&(M=1/Math.sqrt(M)),t[0]=n*M,t[1]=r*M,t[2]=u*M,t[3]=h*M,t}function f(t,a){return t[0]*a[0]+t[1]*a[1]+t[2]*a[2]+t[3]*a[3]}function v(t,a,n,r){var u=a[0],h=a[1],M=a[2],s=a[3];return t[0]=u+r*(n[0]-u),t[1]=h+r*(n[1]-h),t[2]=M+r*(n[2]-M),t[3]=s+r*(n[3]-s),t}function I(t,a,n){var r=a[0],u=a[1],h=a[2],M=a[3];return t[0]=n[0]*r+n[4]*u+n[8]*h+n[12]*M,t[1]=n[1]*r+n[5]*u+n[9]*h+n[13]*M,t[2]=n[2]*r+n[6]*u+n[10]*h+n[14]*M,t[3]=n[3]*r+n[7]*u+n[11]*h+n[15]*M,t}function l(t,a,n){var r=a[0],u=a[1],h=a[2],M=n[0],s=n[1],e=n[2],o=n[3],i=o*r+s*h-e*u,c=o*u+e*r-M*h,b=o*h+M*u-s*r,f=-M*r-s*u-e*h;return t[0]=i*o+f*-M+c*-e-b*-s,t[1]=c*o+f*-s+b*-M-i*-e,t[2]=b*o+f*-e+i*-s-c*-M,t[3]=a[3],t}function m(t,a){return t[0]===a[0]&&t[1]===a[1]&&t[2]===a[2]&&t[3]===a[3]}function y(t,a){var n=t[0],u=t[1],h=t[2],M=t[3],s=a[0],e=a[1],o=a[2],i=a[3];return Math.abs(n-s)<=r.Ib*Math.max(1,Math.abs(n),Math.abs(s))&&Math.abs(u-e)<=r.Ib*Math.max(1,Math.abs(u),Math.abs(e))&&Math.abs(h-o)<=r.Ib*Math.max(1,Math.abs(h),Math.abs(o))&&Math.abs(M-i)<=r.Ib*Math.max(1,Math.abs(M),Math.abs(i))}var x,p;x=new r.WT(4),r.WT!=Float32Array&&(x[0]=0,x[1]=0,x[2]=0,x[3]=0),p=x}}]);