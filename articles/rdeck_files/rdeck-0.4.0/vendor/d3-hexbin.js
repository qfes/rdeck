"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[7650],{3774:(n,r,t)=>{t.d(r,{g:()=>o});var u=Math.PI/3,e=[0,u,2*u,3*u,4*u,5*u];function a(n){return n[0]}function i(n){return n[1]}function o(){var n,r,t,o=0,c=0,h=1,f=1,l=a,s=i;function v(n){var u,e={},a=[],i=n.length;for(u=0;u<i;++u)if(!isNaN(c=+l.call(null,o=n[u],u,n))&&!isNaN(h=+s.call(null,o,u,n))){var o,c,h,f=Math.round(h/=t),v=Math.round(c=c/r-(1&f)/2),M=h-f;if(3*Math.abs(M)>1){var d=c-v,g=v+(c<v?-1:1)/2,p=f+(h<f?-1:1),k=c-g,m=h-p;d*d+M*M>k*k+m*m&&(v=g+(1&f?1:-1)/2,f=p)}var x=v+"-"+f,N=e[x];N?N.push(o):(a.push(N=e[x]=[o]),N.x=(v+(1&f)/2)*r,N.y=f*t)}return a}function M(n){var r=0,t=0;return e.map((function(u){var e=Math.sin(u)*n,a=-Math.cos(u)*n,i=e-r,o=a-t;return r=e,t=a,[i,o]}))}return v.hexagon=function(r){return"m"+M(null==r?n:+r).join("l")+"z"},v.centers=function(){for(var u=[],e=Math.round(c/t),a=Math.round(o/r),i=e*t;i<f+n;i+=t,++e)for(var l=a*r+(1&e)*r/2;l<h+r/2;l+=r)u.push([l,i]);return u},v.mesh=function(){var r=M(n).slice(0,4).join("l");return v.centers().map((function(n){return"M"+n+"m"+r})).join("")},v.x=function(n){return arguments.length?(l=n,v):l},v.y=function(n){return arguments.length?(s=n,v):s},v.radius=function(e){return arguments.length?(r=2*(n=+e)*Math.sin(u),t=1.5*n,v):n},v.size=function(n){return arguments.length?(o=c=0,h=+n[0],f=+n[1],v):[h-o,f-c]},v.extent=function(n){return arguments.length?(o=+n[0][0],c=+n[0][1],h=+n[1][0],f=+n[1][1],v):[[o,c],[h,f]]},v.radius(1)}}}]);