"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[535],{9685:(r,n,t)=>{t.d(n,{WT:()=>a});var a="undefined"!=typeof Float32Array?Float32Array:Array;Math.random;Math.PI;Math.hypot||(Math.hypot=function(){for(var r=0,n=arguments.length;n--;)r+=arguments[n]*arguments[n];return Math.sqrt(r)})},5975:(r,n,t)=>{function a(r,n){var t=n[0],a=n[1],u=n[2],e=n[3],o=n[4],f=n[5],c=n[6],v=n[7],h=n[8],i=n[9],l=n[10],d=n[11],y=n[12],k=n[13],p=n[14],A=n[15],T=t*f-a*o,W=t*c-u*o,s=t*v-e*o,F=a*c-u*f,w=a*v-e*f,M=u*v-e*c,b=h*k-i*y,I=h*p-l*y,C=h*A-d*y,g=i*p-l*k,m=i*A-d*k,q=l*A-d*p,H=T*q-W*m+s*g+F*C-w*I+M*b;return H?(H=1/H,r[0]=(f*q-c*m+v*g)*H,r[1]=(u*m-a*q-e*g)*H,r[2]=(k*M-p*w+A*F)*H,r[3]=(l*w-i*M-d*F)*H,r[4]=(c*C-o*q-v*I)*H,r[5]=(t*q-u*C+e*I)*H,r[6]=(p*s-y*M-A*W)*H,r[7]=(h*M-l*s+d*W)*H,r[8]=(o*m-f*C+v*b)*H,r[9]=(a*C-t*m-e*b)*H,r[10]=(y*w-k*s+A*T)*H,r[11]=(i*s-h*w-d*T)*H,r[12]=(f*I-o*g-c*b)*H,r[13]=(t*g-a*I+u*b)*H,r[14]=(k*W-y*F-p*T)*H,r[15]=(h*F-i*W+l*T)*H,r):null}function u(r,n,t){var a=n[0],u=n[1],e=n[2],o=n[3],f=n[4],c=n[5],v=n[6],h=n[7],i=n[8],l=n[9],d=n[10],y=n[11],k=n[12],p=n[13],A=n[14],T=n[15],W=t[0],s=t[1],F=t[2],w=t[3];return r[0]=W*a+s*f+F*i+w*k,r[1]=W*u+s*c+F*l+w*p,r[2]=W*e+s*v+F*d+w*A,r[3]=W*o+s*h+F*y+w*T,W=t[4],s=t[5],F=t[6],w=t[7],r[4]=W*a+s*f+F*i+w*k,r[5]=W*u+s*c+F*l+w*p,r[6]=W*e+s*v+F*d+w*A,r[7]=W*o+s*h+F*y+w*T,W=t[8],s=t[9],F=t[10],w=t[11],r[8]=W*a+s*f+F*i+w*k,r[9]=W*u+s*c+F*l+w*p,r[10]=W*e+s*v+F*d+w*A,r[11]=W*o+s*h+F*y+w*T,W=t[12],s=t[13],F=t[14],w=t[15],r[12]=W*a+s*f+F*i+w*k,r[13]=W*u+s*c+F*l+w*p,r[14]=W*e+s*v+F*d+w*A,r[15]=W*o+s*h+F*y+w*T,r}function e(r,n,t){var a,u,e,o,f,c,v,h,i,l,d,y,k=t[0],p=t[1],A=t[2];return n===r?(r[12]=n[0]*k+n[4]*p+n[8]*A+n[12],r[13]=n[1]*k+n[5]*p+n[9]*A+n[13],r[14]=n[2]*k+n[6]*p+n[10]*A+n[14],r[15]=n[3]*k+n[7]*p+n[11]*A+n[15]):(a=n[0],u=n[1],e=n[2],o=n[3],f=n[4],c=n[5],v=n[6],h=n[7],i=n[8],l=n[9],d=n[10],y=n[11],r[0]=a,r[1]=u,r[2]=e,r[3]=o,r[4]=f,r[5]=c,r[6]=v,r[7]=h,r[8]=i,r[9]=l,r[10]=d,r[11]=y,r[12]=a*k+f*p+i*A+n[12],r[13]=u*k+c*p+l*A+n[13],r[14]=e*k+v*p+d*A+n[14],r[15]=o*k+h*p+y*A+n[15]),r}function o(r,n,t){var a=t[0],u=t[1],e=t[2];return r[0]=n[0]*a,r[1]=n[1]*a,r[2]=n[2]*a,r[3]=n[3]*a,r[4]=n[4]*u,r[5]=n[5]*u,r[6]=n[6]*u,r[7]=n[7]*u,r[8]=n[8]*e,r[9]=n[9]*e,r[10]=n[10]*e,r[11]=n[11]*e,r[12]=n[12],r[13]=n[13],r[14]=n[14],r[15]=n[15],r}t.d(n,{Iu:()=>e,Jp:()=>u,U_:()=>a,bA:()=>o})},1437:(r,n,t)=>{t.d(n,{IH:()=>u,tk:()=>e});var a=t(9685);function u(r,n,t){return r[0]=n[0]+t[0],r[1]=n[1]+t[1],r}function e(r,n){return r[0]=-n[0],r[1]=-n[1],r}var o,f;o=new a.WT(2),a.WT!=Float32Array&&(o[0]=0,o[1]=0),f=o},7160:(r,n,t)=>{t.d(n,{lu:()=>o});var a=t(9685);var u,e,o=function(r,n,t){return r[0]=n[0]-t[0],r[1]=n[1]-t[1],r[2]=n[2]-t[2],r};u=new a.WT(3),a.WT!=Float32Array&&(u[0]=0,u[1]=0,u[2]=0),e=u},8333:(r,n,t)=>{t.d(n,{fF:()=>u});var a=t(9685);function u(r,n,t){var a=n[0],u=n[1],e=n[2],o=n[3];return r[0]=t[0]*a+t[4]*u+t[8]*e+t[12]*o,r[1]=t[1]*a+t[5]*u+t[9]*e+t[13]*o,r[2]=t[2]*a+t[6]*u+t[10]*e+t[14]*o,r[3]=t[3]*a+t[7]*u+t[11]*e+t[15]*o,r}var e,o;e=new a.WT(4),a.WT!=Float32Array&&(e[0]=0,e[1]=0,e[2]=0,e[3]=0),o=e}}]);