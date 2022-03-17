"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[6042],{6535:(t,i,r)=>{r.d(i,{WU:()=>u,jH:()=>d});var n=r(5368);var e=r(2035);var a,o=r(8613);function s(t,i){var r=(0,o.V)(t,i);if(!r)return t+"";var n=r[0],e=r[1];return e<0?"0."+new Array(-e).join("0")+n:n.length>e+1?n.slice(0,e+1)+"."+n.slice(e+1):n+new Array(e-n.length+2).join("0")}const c={"%":(t,i)=>(100*t).toFixed(i),b:t=>Math.round(t).toString(2),c:t=>t+"",d:o.Z,e:(t,i)=>t.toExponential(i),f:(t,i)=>t.toFixed(i),g:(t,i)=>t.toPrecision(i),o:t=>Math.round(t).toString(8),p:(t,i)=>s(100*t,i),r:s,s:function(t,i){var r=(0,o.V)(t,i);if(!r)return t+"";var n=r[0],e=r[1],s=e-(a=3*Math.max(-8,Math.min(8,Math.floor(e/3))))+1,c=n.length;return s===c?n:s>c?n+new Array(s-c+1).join("0"):s>0?n.slice(0,s)+"."+n.slice(s):"0."+new Array(1-s).join("0")+(0,o.V)(t,Math.max(0,i+s-1))[0]},X:t=>Math.round(t).toString(16).toUpperCase(),x:t=>Math.round(t).toString(16)};function h(t){return t}var l,u,d,f=Array.prototype.map,m=["y","z","a","f","p","n","µ","m","","k","M","G","T","P","E","Z","Y"];function g(t){var i,r,o=void 0===t.grouping||void 0===t.thousands?h:(i=f.call(t.grouping,Number),r=t.thousands+"",function(t,n){for(var e=t.length,a=[],o=0,s=i[0],c=0;e>0&&s>0&&(c+s+1>n&&(s=Math.max(1,n-c)),a.push(t.substring(e-=s,e+s)),!((c+=s+1)>n));)s=i[o=(o+1)%i.length];return a.reverse().join(r)}),s=void 0===t.currency?"":t.currency[0]+"",l=void 0===t.currency?"":t.currency[1]+"",u=void 0===t.decimal?".":t.decimal+"",d=void 0===t.numerals?h:function(t){return function(i){return i.replace(/[0-9]/g,(function(i){return t[+i]}))}}(f.call(t.numerals,String)),g=void 0===t.percent?"%":t.percent+"",v=void 0===t.minus?"−":t.minus+"",p=void 0===t.nan?"NaN":t.nan+"";function M(t){var i=(t=(0,e.Z)(t)).fill,r=t.align,n=t.sign,h=t.symbol,f=t.zero,M=t.width,y=t.comma,b=t.precision,x=t.trim,w=t.type;"n"===w?(y=!0,w="g"):c[w]||(void 0===b&&(b=12),x=!0,w="g"),(f||"0"===i&&"="===r)&&(f=!0,i="0",r="=");var Z="$"===h?s:"#"===h&&/[boxX]/.test(w)?"0"+w.toLowerCase():"",k="$"===h?l:/[%p]/.test(w)?g:"",S=c[w],j=/[defgprs%]/.test(w);function z(t){var e,s,c,h=Z,l=k;if("c"===w)l=S(t)+l,t="";else{var g=(t=+t)<0||1/t<0;if(t=isNaN(t)?p:S(Math.abs(t),b),x&&(t=function(t){t:for(var i,r=t.length,n=1,e=-1;n<r;++n)switch(t[n]){case".":e=i=n;break;case"0":0===e&&(e=n),i=n;break;default:if(!+t[n])break t;e>0&&(e=0)}return e>0?t.slice(0,e)+t.slice(i+1):t}(t)),g&&0==+t&&"+"!==n&&(g=!1),h=(g?"("===n?n:v:"-"===n||"("===n?"":n)+h,l=("s"===w?m[8+a/3]:"")+l+(g&&"("===n?")":""),j)for(e=-1,s=t.length;++e<s;)if(48>(c=t.charCodeAt(e))||c>57){l=(46===c?u+t.slice(e+1):t.slice(e))+l,t=t.slice(0,e);break}}y&&!f&&(t=o(t,1/0));var z=h.length+t.length+l.length,A=z<M?new Array(M-z+1).join(i):"";switch(y&&f&&(t=o(A+t,A.length?M-l.length:1/0),A=""),r){case"<":t=h+t+l+A;break;case"=":t=h+A+t+l;break;case"^":t=A.slice(0,z=A.length>>1)+h+t+l+A.slice(z);break;default:t=A+h+t+l}return d(t)}return b=void 0===b?6:/[gprs]/.test(w)?Math.max(1,Math.min(21,b)):Math.max(0,Math.min(20,b)),z.toString=function(){return t+""},z}return{format:M,formatPrefix:function(t,i){var r=M(((t=(0,e.Z)(t)).type="f",t)),a=3*Math.max(-8,Math.min(8,Math.floor((0,n.Z)(i)/3))),o=Math.pow(10,-a),s=m[8+a/3];return function(t){return r(o*t)+s}}}}l=g({thousands:",",grouping:[3],currency:["$",""]}),u=l.format,d=l.formatPrefix},5368:(t,i,r)=>{r.d(i,{Z:()=>e});var n=r(8613);function e(t){return(t=(0,n.V)(Math.abs(t)))?t[1]:NaN}},8613:(t,i,r)=>{function n(t){return Math.abs(t=Math.round(t))>=1e21?t.toLocaleString("en").replace(/,/g,""):t.toString(10)}function e(t,i){if((r=(t=i?t.toExponential(i-1):t.toExponential()).indexOf("e"))<0)return null;var r,n=t.slice(0,r);return[n.length>1?n[0]+n.slice(2):n,+t.slice(r+1)]}r.d(i,{V:()=>e,Z:()=>n})},2035:(t,i,r)=>{r.d(i,{Z:()=>e});var n=/^(?:(.)?([<>=^]))?([+\-( ])?([$#])?(0)?(\d+)?(,)?(\.\d+)?(~)?([a-z%])?$/i;function e(t){if(!(i=n.exec(t)))throw new Error("invalid format: "+t);var i;return new a({fill:i[1],align:i[2],sign:i[3],symbol:i[4],zero:i[5],width:i[6],comma:i[7],precision:i[8]&&i[8].slice(1),trim:i[9],type:i[10]})}function a(t){this.fill=void 0===t.fill?" ":t.fill+"",this.align=void 0===t.align?">":t.align+"",this.sign=void 0===t.sign?"-":t.sign+"",this.symbol=void 0===t.symbol?"":t.symbol+"",this.zero=!!t.zero,this.width=void 0===t.width?void 0:+t.width,this.comma=!!t.comma,this.precision=void 0===t.precision?void 0:+t.precision,this.trim=!!t.trim,this.type=void 0===t.type?"":t.type+""}e.prototype=a.prototype,a.prototype.toString=function(){return this.fill+this.align+this.sign+this.symbol+(this.zero?"0":"")+(void 0===this.width?"":Math.max(1,0|this.width))+(this.comma?",":"")+(void 0===this.precision?"":"."+Math.max(0,0|this.precision))+(this.trim?"~":"")+this.type}},6909:(t,i,r)=>{r.d(i,{Z:()=>e});var n=r(5368);function e(t){return Math.max(0,-(0,n.Z)(Math.abs(t)))}},7017:(t,i,r)=>{r.d(i,{Z:()=>e});var n=r(5368);function e(t,i){return Math.max(0,3*Math.max(-8,Math.min(8,Math.floor((0,n.Z)(i)/3)))-(0,n.Z)(Math.abs(t)))}},3482:(t,i,r)=>{r.d(i,{Z:()=>e});var n=r(5368);function e(t,i){return t=Math.abs(t),i=Math.abs(i)-t,Math.max(0,(0,n.Z)(i)-(0,n.Z)(t))+1}}}]);