"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[639],{1106:e=>{function n(e,n,i){i=i||2;var u,v,f,p,a,l,s,c=n&&n.length,Z=c?n[0]*i:e.length,d=t(e,0,Z,i,!0),g=[];if(!d||d.next===d.prev)return g;if(c&&(d=function(e,n,x,i){var u,v,f,p=[];for(u=0,v=n.length;u<v;u++)(f=t(e,n[u]*i,u<v-1?n[u+1]*i:e.length,i,!1))===f.next&&(f.steiner=!0),p.push(h(f));for(p.sort(y),u=0;u<p.length;u++)x=r(x=o(p[u],x),x.next);return x}(e,n,d,i)),e.length>80*i){u=f=e[0],v=p=e[1];for(var w=i;w<Z;w+=i)(a=e[w])<u&&(u=a),(l=e[w+1])<v&&(v=l),a>f&&(f=a),l>p&&(p=l);s=0!==(s=Math.max(f-u,p-v))?1/s:0}return x(d,g,i,u,v,s),g}function t(e,n,t,r,x){var i,u;if(x===C(e,n,t,r)>0)for(i=n;i<t;i+=r)u=z(i,e[i],e[i+1],u);else for(i=t-r;i>=n;i-=r)u=z(i,e[i],e[i+1],u);return u&&Z(u,u.next)&&(k(u),u=u.next),u}function r(e,n){if(!e)return e;n||(n=e);var t,r=e;do{if(t=!1,r.steiner||!Z(r,r.next)&&0!==c(r.prev,r,r.next))r=r.next;else{if(k(r),(r=n=r.prev)===r.next)break;t=!0}}while(t||r!==n);return n}function x(e,n,t,y,o,p,h){if(e){!h&&p&&function(e,n,t,r){var x=e;do{null===x.z&&(x.z=a(x.x,x.y,n,t,r)),x.prevZ=x.prev,x.nextZ=x.next,x=x.next}while(x!==e);x.prevZ.nextZ=null,x.prevZ=null,function(e){var n,t,r,x,i,u,v,f,y=1;do{for(t=e,e=null,i=null,u=0;t;){for(u++,r=t,v=0,n=0;n<y&&(v++,r=r.nextZ);n++);for(f=y;v>0||f>0&&r;)0!==v&&(0===f||!r||t.z<=r.z)?(x=t,t=t.nextZ,v--):(x=r,r=r.nextZ,f--),i?i.nextZ=x:e=x,x.prevZ=i,i=x;t=r}i.nextZ=null,y*=2}while(u>1)}(x)}(e,y,o,p);for(var l,s,c=e;e.prev!==e.next;)if(l=e.prev,s=e.next,p?u(e,y,o,p):i(e))n.push(l.i/t),n.push(e.i/t),n.push(s.i/t),k(e),e=s.next,c=s.next;else if((e=s)===c){h?1===h?x(e=v(r(e),n,t),n,t,y,o,p,2):2===h&&f(e,n,t,y,o,p):x(r(e),n,t,y,o,p,1);break}}}function i(e){var n=e.prev,t=e,r=e.next;if(c(n,t,r)>=0)return!1;for(var x=e.next.next;x!==e.prev;){if(l(n.x,n.y,t.x,t.y,r.x,r.y,x.x,x.y)&&c(x.prev,x,x.next)>=0)return!1;x=x.next}return!0}function u(e,n,t,r){var x=e.prev,i=e,u=e.next;if(c(x,i,u)>=0)return!1;for(var v=x.x<i.x?x.x<u.x?x.x:u.x:i.x<u.x?i.x:u.x,f=x.y<i.y?x.y<u.y?x.y:u.y:i.y<u.y?i.y:u.y,y=x.x>i.x?x.x>u.x?x.x:u.x:i.x>u.x?i.x:u.x,o=x.y>i.y?x.y>u.y?x.y:u.y:i.y>u.y?i.y:u.y,p=a(v,f,n,t,r),h=a(y,o,n,t,r),s=e.prevZ,Z=e.nextZ;s&&s.z>=p&&Z&&Z.z<=h;){if(s!==e.prev&&s!==e.next&&l(x.x,x.y,i.x,i.y,u.x,u.y,s.x,s.y)&&c(s.prev,s,s.next)>=0)return!1;if(s=s.prevZ,Z!==e.prev&&Z!==e.next&&l(x.x,x.y,i.x,i.y,u.x,u.y,Z.x,Z.y)&&c(Z.prev,Z,Z.next)>=0)return!1;Z=Z.nextZ}for(;s&&s.z>=p;){if(s!==e.prev&&s!==e.next&&l(x.x,x.y,i.x,i.y,u.x,u.y,s.x,s.y)&&c(s.prev,s,s.next)>=0)return!1;s=s.prevZ}for(;Z&&Z.z<=h;){if(Z!==e.prev&&Z!==e.next&&l(x.x,x.y,i.x,i.y,u.x,u.y,Z.x,Z.y)&&c(Z.prev,Z,Z.next)>=0)return!1;Z=Z.nextZ}return!0}function v(e,n,t){var x=e;do{var i=x.prev,u=x.next.next;!Z(i,u)&&d(i,x,x.next,u)&&M(i,u)&&M(u,i)&&(n.push(i.i/t),n.push(x.i/t),n.push(u.i/t),k(x),k(x.next),x=e=u),x=x.next}while(x!==e);return r(x)}function f(e,n,t,i,u,v){var f=e;do{for(var y=f.next.next;y!==f.prev;){if(f.i!==y.i&&s(f,y)){var o=b(f,y);return f=r(f,f.next),o=r(o,o.next),x(f,n,t,i,u,v),void x(o,n,t,i,u,v)}y=y.next}f=f.next}while(f!==e)}function y(e,n){return e.x-n.x}function o(e,n){var t=function(e,n){var t,r=n,x=e.x,i=e.y,u=-1/0;do{if(i<=r.y&&i>=r.next.y&&r.next.y!==r.y){var v=r.x+(i-r.y)*(r.next.x-r.x)/(r.next.y-r.y);if(v<=x&&v>u){if(u=v,v===x){if(i===r.y)return r;if(i===r.next.y)return r.next}t=r.x<r.next.x?r:r.next}}r=r.next}while(r!==n);if(!t)return null;if(x===u)return t;var f,y=t,o=t.x,a=t.y,h=1/0;r=t;do{x>=r.x&&r.x>=o&&x!==r.x&&l(i<a?x:u,i,o,a,i<a?u:x,i,r.x,r.y)&&(f=Math.abs(i-r.y)/(x-r.x),M(r,e)&&(f<h||f===h&&(r.x>t.x||r.x===t.x&&p(t,r)))&&(t=r,h=f)),r=r.next}while(r!==y);return t}(e,n);if(!t)return n;var x=b(t,e),i=r(t,t.next);return r(x,x.next),n===t?i:n}function p(e,n){return c(e.prev,e,n.prev)<0&&c(n.next,e,e.next)<0}function a(e,n,t,r,x){return(e=1431655765&((e=858993459&((e=252645135&((e=16711935&((e=32767*(e-t)*x)|e<<8))|e<<4))|e<<2))|e<<1))|(n=1431655765&((n=858993459&((n=252645135&((n=16711935&((n=32767*(n-r)*x)|n<<8))|n<<4))|n<<2))|n<<1))<<1}function h(e){var n=e,t=e;do{(n.x<t.x||n.x===t.x&&n.y<t.y)&&(t=n),n=n.next}while(n!==e);return t}function l(e,n,t,r,x,i,u,v){return(x-u)*(n-v)-(e-u)*(i-v)>=0&&(e-u)*(r-v)-(t-u)*(n-v)>=0&&(t-u)*(i-v)-(x-u)*(r-v)>=0}function s(e,n){return e.next.i!==n.i&&e.prev.i!==n.i&&!function(e,n){var t=e;do{if(t.i!==e.i&&t.next.i!==e.i&&t.i!==n.i&&t.next.i!==n.i&&d(t,t.next,e,n))return!0;t=t.next}while(t!==e);return!1}(e,n)&&(M(e,n)&&M(n,e)&&function(e,n){var t=e,r=!1,x=(e.x+n.x)/2,i=(e.y+n.y)/2;do{t.y>i!=t.next.y>i&&t.next.y!==t.y&&x<(t.next.x-t.x)*(i-t.y)/(t.next.y-t.y)+t.x&&(r=!r),t=t.next}while(t!==e);return r}(e,n)&&(c(e.prev,e,n.prev)||c(e,n.prev,n))||Z(e,n)&&c(e.prev,e,e.next)>0&&c(n.prev,n,n.next)>0)}function c(e,n,t){return(n.y-e.y)*(t.x-n.x)-(n.x-e.x)*(t.y-n.y)}function Z(e,n){return e.x===n.x&&e.y===n.y}function d(e,n,t,r){var x=w(c(e,n,t)),i=w(c(e,n,r)),u=w(c(t,r,e)),v=w(c(t,r,n));return x!==i&&u!==v||(!(0!==x||!g(e,t,n))||(!(0!==i||!g(e,r,n))||(!(0!==u||!g(t,e,r))||!(0!==v||!g(t,n,r)))))}function g(e,n,t){return n.x<=Math.max(e.x,t.x)&&n.x>=Math.min(e.x,t.x)&&n.y<=Math.max(e.y,t.y)&&n.y>=Math.min(e.y,t.y)}function w(e){return e>0?1:e<0?-1:0}function M(e,n){return c(e.prev,e,e.next)<0?c(e,n,e.next)>=0&&c(e,e.prev,n)>=0:c(e,n,e.prev)<0||c(e,e.next,n)<0}function b(e,n){var t=new m(e.i,e.x,e.y),r=new m(n.i,n.x,n.y),x=e.next,i=n.prev;return e.next=n,n.prev=e,t.next=x,x.prev=t,r.next=t,t.prev=r,i.next=r,r.prev=i,r}function z(e,n,t,r){var x=new m(e,n,t);return r?(x.next=r.next,x.prev=r,r.next.prev=x,r.next=x):(x.prev=x,x.next=x),x}function k(e){e.next.prev=e.prev,e.prev.next=e.next,e.prevZ&&(e.prevZ.nextZ=e.nextZ),e.nextZ&&(e.nextZ.prevZ=e.prevZ)}function m(e,n,t){this.i=e,this.x=n,this.y=t,this.prev=null,this.next=null,this.z=null,this.prevZ=null,this.nextZ=null,this.steiner=!1}function C(e,n,t,r){for(var x=0,i=n,u=t-r;i<t;i+=r)x+=(e[u]-e[i])*(e[i+1]+e[u+1]),u=i;return x}e.exports=n,e.exports.default=n,n.deviation=function(e,n,t,r){var x=n&&n.length,i=x?n[0]*t:e.length,u=Math.abs(C(e,0,i,t));if(x)for(var v=0,f=n.length;v<f;v++){var y=n[v]*t,o=v<f-1?n[v+1]*t:e.length;u-=Math.abs(C(e,y,o,t))}var p=0;for(v=0;v<r.length;v+=3){var a=r[v]*t,h=r[v+1]*t,l=r[v+2]*t;p+=Math.abs((e[a]-e[l])*(e[h+1]-e[a+1])-(e[a]-e[h])*(e[l+1]-e[a+1]))}return 0===u&&0===p?0:Math.abs((p-u)/u)},n.flatten=function(e){for(var n=e[0][0].length,t={vertices:[],holes:[],dimensions:n},r=0,x=0;x<e.length;x++){for(var i=0;i<e[x].length;i++)for(var u=0;u<n;u++)t.vertices.push(e[x][i][u]);x>0&&(r+=e[x-1].length,t.holes.push(r))}return t}}}]);