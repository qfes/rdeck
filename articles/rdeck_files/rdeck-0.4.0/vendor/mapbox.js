"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[1596],{9296:t=>{t.exports=e,t.exports.default=e;var i=1e20;function e(t,i,e,s,a,r){this.fontSize=t||24,this.buffer=void 0===i?3:i,this.cutoff=s||.25,this.fontFamily=a||"sans-serif",this.fontWeight=r||"normal",this.radius=e||8;var h=this.size=this.fontSize+2*this.buffer,n=h+2*this.buffer;this.canvas=document.createElement("canvas"),this.canvas.width=this.canvas.height=h,this.ctx=this.canvas.getContext("2d"),this.ctx.font=this.fontWeight+" "+this.fontSize+"px "+this.fontFamily,this.ctx.textAlign="left",this.ctx.fillStyle="black",this.gridOuter=new Float64Array(n*n),this.gridInner=new Float64Array(n*n),this.f=new Float64Array(n),this.z=new Float64Array(n+1),this.v=new Uint16Array(n),this.useMetrics=void 0!==this.ctx.measureText("A").actualBoundingBoxLeft,this.middle=Math.round(h/2*(navigator.userAgent.indexOf("Gecko/")>=0?1.2:1))}function s(t,i,e,s,r,h){for(var n=0;n<i;n++)a(t,n,i,e,s,r,h);for(var f=0;f<e;f++)a(t,f*i,1,i,s,r,h)}function a(t,e,s,a,r,h,n){var f,o,c,u;for(h[0]=0,n[0]=-i,n[1]=i,f=0;f<a;f++)r[f]=t[e+f*s];for(f=1,o=0,c=0;f<a;f++){do{u=h[o],c=(r[f]-r[u]+f*f-u*u)/(f-u)/2}while(c<=n[o]&&--o>-1);h[++o]=f,n[o]=c,n[o+1]=i}for(f=0,o=0;f<a;f++){for(;n[o+1]<f;)o++;u=h[o],t[e+f*s]=r[u]+(f-u)*(f-u)}}e.prototype._draw=function(t,e){var a,r,h,n,f,o,c,u,d,l=this.ctx.measureText(t),x=l.width,g=2*this.buffer;e&&this.useMetrics?(f=Math.floor(l.actualBoundingBoxAscent),u=this.buffer+Math.ceil(l.actualBoundingBoxAscent),o=this.buffer,c=this.buffer,a=(r=Math.min(this.size,Math.ceil(l.actualBoundingBoxRight-l.actualBoundingBoxLeft)))+g,h=(n=Math.min(this.size-o,Math.ceil(l.actualBoundingBoxAscent+l.actualBoundingBoxDescent)))+g,this.ctx.textBaseline="alphabetic"):(a=r=this.size,h=n=this.size,f=19*this.fontSize/24,o=c=0,u=this.middle,this.ctx.textBaseline="middle"),r&&n&&(this.ctx.clearRect(c,o,r,n),this.ctx.fillText(t,this.buffer,u),d=this.ctx.getImageData(c,o,r,n));var v=new Uint8ClampedArray(a*h);return function(t,e,s,a,r,h,n){h.fill(i,0,e*s),n.fill(0,0,e*s);for(var f=(e-a)/2,o=0;o<r;o++)for(var c=0;c<a;c++){var u=(o+f)*e+c+f,d=t.data[4*(o*a+c)+3]/255;if(1===d)h[u]=0,n[u]=i;else if(0===d)h[u]=i,n[u]=0;else{var l=Math.max(0,.5-d),x=Math.max(0,d-.5);h[u]=l*l,n[u]=x*x}}}(d,a,h,r,n,this.gridOuter,this.gridInner),s(this.gridOuter,a,h,this.f,this.v,this.z),s(this.gridInner,a,h,this.f,this.v,this.z),function(t,i,e,s,a,r,h){for(var n=0;n<i*e;n++){var f=Math.sqrt(s[n])-Math.sqrt(a[n]);t[n]=Math.round(255-255*(f/r+h))}}(v,a,h,this.gridOuter,this.gridInner,this.radius,this.cutoff),{data:v,metrics:{width:r,height:n,sdfWidth:a,sdfHeight:h,top:f,left:0,advance:x}}},e.prototype.draw=function(t){return this._draw(t,!1).data},e.prototype.drawWithMetrics=function(t){return this._draw(t,!0)}}}]);