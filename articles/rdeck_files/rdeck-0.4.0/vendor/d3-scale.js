"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[667],{8565:(n,t,r)=>{r.d(t,{JG:()=>g,ZP:()=>M,yR:()=>l,l4:()=>p});var e=r(8671),u=r(1639),o=r(8063),i=r(4635);var a=r(6938),c=[0,1];function l(n){return n}function f(n,t){return(t-=n=+n)?function(r){return(r-n)/t}:(r=isNaN(t)?NaN:.5,function(){return r});var r}function h(n,t,r){var e=n[0],u=n[1],o=t[0],i=t[1];return u<e?(e=f(u,e),o=r(i,o)):(e=f(e,u),o=r(o,i)),function(n){return o(e(n))}}function s(n,t,r){var u=Math.min(n.length,t.length)-1,o=new Array(u),i=new Array(u),a=-1;for(n[u]<n[0]&&(n=n.slice().reverse(),t=t.slice().reverse());++a<u;)o[a]=f(n[a],n[a+1]),i[a]=r(t[a],t[a+1]);return function(t){var r=(0,e.ZP)(n,t,1,u)-1;return i[r](o[r](t))}}function g(n,t){return t.domain(n.domain()).range(n.range()).interpolate(n.interpolate()).clamp(n.clamp()).unknown(n.unknown())}function p(){var n,t,r,e,f,g,p=c,M=c,m=u.Z,v=l;function y(){var n,t,r,u=Math.min(p.length,M.length);return v!==l&&(n=p[0],t=p[u-1],n>t&&(r=n,n=t,t=r),v=function(r){return Math.max(n,Math.min(t,r))}),e=u>2?s:h,f=g=null,d}function d(t){return null==t||isNaN(t=+t)?r:(f||(f=e(p.map(n),M,m)))(n(v(t)))}return d.invert=function(r){return v(t((g||(g=e(M,p.map(n),o.Z)))(r)))},d.domain=function(n){return arguments.length?(p=Array.from(n,a.Z),y()):p.slice()},d.range=function(n){return arguments.length?(M=Array.from(n),y()):M.slice()},d.rangeRound=function(n){return M=Array.from(n),m=i.Z,y()},d.clamp=function(n){return arguments.length?(v=!!n||l,y()):v!==l},d.interpolate=function(n){return arguments.length?(m=n,y()):m},d.unknown=function(n){return arguments.length?(r=n,d):r},function(r,e){return n=r,t=e,y()}}function M(){return p()(l,l)}},3613:(n,t,r)=>{r.d(t,{Z:()=>o});var e=r(4634),u=r(6938);function o(n){var t;function r(n){return null==n||isNaN(n=+n)?t:n}return r.invert=r,r.domain=r.range=function(t){return arguments.length?(n=Array.from(t,u.Z),r):n.slice()},r.unknown=function(n){return arguments.length?(t=n,r):t},r.copy=function(){return o(n).unknown(t)},n=arguments.length?Array.from(n,u.Z):[0,1],(0,e.Q)(r)}},4182:(n,t,r)=>{function e(n,t){switch(arguments.length){case 0:break;case 1:this.range(n);break;default:this.range(t).domain(n)}return this}r.d(t,{o:()=>e})},4634:(n,t,r)=>{r.d(t,{Z:()=>s,Q:()=>h});var e=r(3896),u=r(8565),o=r(4182),i=r(2035),a=r(7017),c=r(6535),l=r(3482),f=r(6909);function h(n){var t=n.domain;return n.ticks=function(n){var r=t();return(0,e.ZP)(r[0],r[r.length-1],null==n?10:n)},n.tickFormat=function(n,r){var u=t();return function(n,t,r,u){var o,h=(0,e.ly)(n,t,r);switch((u=(0,i.Z)(null==u?",f":u)).type){case"s":var s=Math.max(Math.abs(n),Math.abs(t));return null!=u.precision||isNaN(o=(0,a.Z)(h,s))||(u.precision=o),(0,c.jH)(u,s);case"":case"e":case"g":case"p":case"r":null!=u.precision||isNaN(o=(0,l.Z)(h,Math.max(Math.abs(n),Math.abs(t))))||(u.precision=o-("e"===u.type));break;case"f":case"%":null!=u.precision||isNaN(o=(0,f.Z)(h))||(u.precision=o-2*("%"===u.type))}return(0,c.WU)(u)}(u[0],u[u.length-1],null==n?10:n,r)},n.nice=function(r){null==r&&(r=10);var u,o,i=t(),a=0,c=i.length-1,l=i[a],f=i[c],h=10;for(f<l&&(o=l,l=f,f=o,o=a,a=c,c=o);h-- >0;){if((o=(0,e.G9)(l,f,r))===u)return i[a]=l,i[c]=f,t(i);if(o>0)l=Math.floor(l/o)*o,f=Math.ceil(f/o)*o;else{if(!(o<0))break;l=Math.ceil(l*o)/o,f=Math.floor(f*o)/o}u=o}return n},n}function s(){var n=(0,u.ZP)();return n.copy=function(){return(0,u.JG)(n,s())},o.o.apply(n,arguments),h(n)}},458:(n,t,r)=>{r.d(t,{Z:()=>M});var e=r(3896),u=r(2035),o=r(6535);var i=r(8565),a=r(4182);function c(n){return Math.log(n)}function l(n){return Math.exp(n)}function f(n){return-Math.log(-n)}function h(n){return-Math.exp(-n)}function s(n){return isFinite(n)?+("1e"+n):n<0?0:n}function g(n){return(t,r)=>-n(-t,r)}function p(n){const t=n(c,l),r=t.domain;let i,a,p=10;function M(){return i=function(n){return n===Math.E?Math.log:10===n&&Math.log10||2===n&&Math.log2||(n=Math.log(n),t=>Math.log(t)/n)}(p),a=function(n){return 10===n?s:n===Math.E?Math.exp:t=>Math.pow(n,t)}(p),r()[0]<0?(i=g(i),a=g(a),n(f,h)):n(c,l),t}return t.base=function(n){return arguments.length?(p=+n,M()):p},t.domain=function(n){return arguments.length?(r(n),M()):r()},t.ticks=n=>{const t=r();let u=t[0],o=t[t.length-1];const c=o<u;c&&([u,o]=[o,u]);let l,f,h=i(u),s=i(o);const g=null==n?10:+n;let M=[];if(!(p%1)&&s-h<g){if(h=Math.floor(h),s=Math.ceil(s),u>0){for(;h<=s;++h)for(l=1;l<p;++l)if(f=h<0?l/a(-h):l*a(h),!(f<u)){if(f>o)break;M.push(f)}}else for(;h<=s;++h)for(l=p-1;l>=1;--l)if(f=h>0?l/a(-h):l*a(h),!(f<u)){if(f>o)break;M.push(f)}2*M.length<g&&(M=(0,e.ZP)(u,o,g))}else M=(0,e.ZP)(h,s,Math.min(s-h,g)).map(a);return c?M.reverse():M},t.tickFormat=(n,r)=>{if(null==n&&(n=10),null==r&&(r=10===p?"s":","),"function"!=typeof r&&(p%1||null!=(r=(0,u.Z)(r)).precision||(r.trim=!0),r=(0,o.WU)(r)),n===1/0)return r;const e=Math.max(1,p*n/t.ticks().length);return n=>{let t=n/a(Math.round(i(n)));return t*p<p-.5&&(t*=p),t<=e?r(n):""}},t.nice=()=>r(function(n,t){var r,e=0,u=(n=n.slice()).length-1,o=n[e],i=n[u];return i<o&&(r=e,e=u,u=r,r=o,o=i,i=r),n[e]=t.floor(o),n[u]=t.ceil(i),n}(r(),{floor:n=>a(Math.floor(i(n))),ceil:n=>a(Math.ceil(i(n)))})),t}function M(){const n=p((0,i.l4)()).domain([1,10]);return n.copy=()=>(0,i.JG)(n,M()).base(n.base()),a.o.apply(n,arguments),n}},6938:(n,t,r)=>{function e(n){return+n}r.d(t,{Z:()=>e})},8973:(n,t,r)=>{r.d(t,{Z:()=>i});var e=r(909),u=r(4182);const o=Symbol("implicit");function i(){var n=new e.L,t=[],r=[],a=o;function c(e){let u=n.get(e);if(void 0===u){if(a!==o)return a;n.set(e,u=t.push(e)-1)}return r[u%r.length]}return c.domain=function(r){if(!arguments.length)return t.slice();t=[],n=new e.L;for(const e of r)n.has(e)||n.set(e,t.push(e)-1);return c},c.range=function(n){return arguments.length?(r=Array.from(n),c):r.slice()},c.unknown=function(n){return arguments.length?(a=n,c):a},c.copy=function(){return i(t,r).unknown(a)},u.o.apply(c,arguments),c}},4177:(n,t,r)=>{r.d(t,{ZP:()=>f});var e=r(4634),u=r(8565),o=r(4182);function i(n){return function(t){return t<0?-Math.pow(-t,n):Math.pow(t,n)}}function a(n){return n<0?-Math.sqrt(-n):Math.sqrt(n)}function c(n){return n<0?-n*n:n*n}function l(n){var t=n(u.yR,u.yR),r=1;function o(){return 1===r?n(u.yR,u.yR):.5===r?n(a,c):n(i(r),i(1/r))}return t.exponent=function(n){return arguments.length?(r=+n,o()):r},(0,e.Q)(t)}function f(){var n=l((0,u.l4)());return n.copy=function(){return(0,u.JG)(n,f()).exponent(n.exponent())},o.o.apply(n,arguments),n}},2625:(n,t,r)=>{r.d(t,{Z:()=>i});var e=r(8671),u=r(4634),o=r(4182);function i(){var n,t=0,r=1,a=1,c=[.5],l=[0,1];function f(t){return null!=t&&t<=t?l[(0,e.ZP)(c,t,0,a)]:n}function h(){var n=-1;for(c=new Array(a);++n<a;)c[n]=((n+1)*r-(n-a)*t)/(a+1);return f}return f.domain=function(n){return arguments.length?([t,r]=n,t=+t,r=+r,h()):[t,r]},f.range=function(n){return arguments.length?(a=(l=Array.from(n)).length-1,h()):l.slice()},f.invertExtent=function(n){var e=l.indexOf(n);return e<0?[NaN,NaN]:e<1?[t,c[0]]:e>=a?[c[a-1],r]:[c[e-1],c[e]]},f.unknown=function(t){return arguments.length?(n=t,f):f},f.thresholds=function(){return c.slice()},f.copy=function(){return i().domain([t,r]).range(l).unknown(n)},o.o.apply((0,u.Q)(f),arguments)}},5801:(n,t,r)=>{r.d(t,{Z:()=>l});var e=r(4634),u=r(8565),o=r(4182);function i(n){return function(t){return Math.sign(t)*Math.log1p(Math.abs(t/n))}}function a(n){return function(t){return Math.sign(t)*Math.expm1(Math.abs(t))*n}}function c(n){var t=1,r=n(i(t),a(t));return r.constant=function(r){return arguments.length?n(i(t=+r),a(t)):t},(0,e.Q)(r)}function l(){var n=c((0,u.l4)());return n.copy=function(){return(0,u.JG)(n,l()).constant(n.constant())},o.o.apply(n,arguments)}},602:(n,t,r)=>{r.d(t,{Z:()=>o});var e=r(8671),u=r(4182);function o(){var n,t=[.5],r=[0,1],i=1;function a(u){return null!=u&&u<=u?r[(0,e.ZP)(t,u,0,i)]:n}return a.domain=function(n){return arguments.length?(t=Array.from(n),i=Math.min(t.length,r.length-1),a):t.slice()},a.range=function(n){return arguments.length?(r=Array.from(n),i=Math.min(t.length,r.length-1),a):r.slice()},a.invertExtent=function(n){var e=r.indexOf(n);return[t[e-1],t[e]]},a.unknown=function(t){return arguments.length?(n=t,a):n},a.copy=function(){return o().domain(t).range(r).unknown(n)},u.o.apply(a,arguments)}}}]);