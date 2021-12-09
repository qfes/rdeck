(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[596],{6295:(t,i,n)=>{"use strict";n.d(i,{Z:()=>s});class s{constructor(t=257){this.gridSize=t;const i=t-1;if(i&i-1)throw new Error(`Expected grid size to be 2^n+1, got ${t}.`);this.numTriangles=i*i*2-2,this.numParentTriangles=this.numTriangles-i*i,this.indices=new Uint32Array(this.gridSize*this.gridSize),this.coords=new Uint16Array(4*this.numTriangles);for(let t=0;t<this.numTriangles;t++){let n=t+2,s=0,r=0,e=0,h=0,o=0,a=0;for(1&n?e=h=o=i:s=r=a=i;(n>>=1)>1;){const t=s+e>>1,i=r+h>>1;1&n?(e=s,h=r,s=o,r=a):(s=e,r=h,e=o,h=a),o=t,a=i}const u=4*t;this.coords[u+0]=s,this.coords[u+1]=r,this.coords[u+2]=e,this.coords[u+3]=h}}createTile(t){return new r(t,this)}}class r{constructor(t,i){const n=i.gridSize;if(t.length!==n*n)throw new Error(`Expected terrain data of length ${n*n} (${n} x ${n}), got ${t.length}.`);this.terrain=t,this.martini=i,this.errors=new Float32Array(t.length),this.update()}update(){const{numTriangles:t,numParentTriangles:i,coords:n,gridSize:s}=this.martini,{terrain:r,errors:e}=this;for(let h=t-1;h>=0;h--){const t=4*h,o=n[t+0],a=n[t+1],u=n[t+2],c=n[t+3],f=o+u>>1,l=a+c>>1,d=f+l-a,x=l+o-f,y=(r[a*s+o]+r[c*s+u])/2,g=l*s+f,m=Math.abs(y-r[g]);if(e[g]=Math.max(e[g],m),h<i){const t=(a+x>>1)*s+(o+d>>1),i=(c+x>>1)*s+(u+d>>1);e[g]=Math.max(e[g],e[t],e[i])}}}getMesh(t=0){const{gridSize:i,indices:n}=this.martini,{errors:s}=this;let r=0,e=0;const h=i-1;function o(h,a,u,c,f,l){const d=h+u>>1,x=a+c>>1;Math.abs(h-f)+Math.abs(a-l)>1&&s[x*i+d]>t?(o(f,l,h,a,d,x),o(u,c,f,l,d,x)):(n[a*i+h]=n[a*i+h]||++r,n[c*i+u]=n[c*i+u]||++r,n[l*i+f]=n[l*i+f]||++r,e++)}n.fill(0),o(0,0,h,h,h,0),o(h,h,0,0,0,h);const a=new Uint16Array(2*r),u=new Uint32Array(3*e);let c=0;function f(r,e,h,o,l,d){const x=r+h>>1,y=e+o>>1;if(Math.abs(r-l)+Math.abs(e-d)>1&&s[y*i+x]>t)f(l,d,r,e,x,y),f(h,o,l,d,x,y);else{const t=n[e*i+r]-1,s=n[o*i+h]-1,f=n[d*i+l]-1;a[2*t]=r,a[2*t+1]=e,a[2*s]=h,a[2*s+1]=o,a[2*f]=l,a[2*f+1]=d,u[c++]=t,u[c++]=s,u[c++]=f}}return f(0,0,h,h,h,0),f(h,h,0,0,0,h),{vertices:a,triangles:u}}}},4280:t=>{"use strict";function i(t,i){this.x=t,this.y=i}t.exports=i,i.prototype={clone:function(){return new i(this.x,this.y)},add:function(t){return this.clone()._add(t)},sub:function(t){return this.clone()._sub(t)},multByPoint:function(t){return this.clone()._multByPoint(t)},divByPoint:function(t){return this.clone()._divByPoint(t)},mult:function(t){return this.clone()._mult(t)},div:function(t){return this.clone()._div(t)},rotate:function(t){return this.clone()._rotate(t)},rotateAround:function(t,i){return this.clone()._rotateAround(t,i)},matMult:function(t){return this.clone()._matMult(t)},unit:function(){return this.clone()._unit()},perp:function(){return this.clone()._perp()},round:function(){return this.clone()._round()},mag:function(){return Math.sqrt(this.x*this.x+this.y*this.y)},equals:function(t){return this.x===t.x&&this.y===t.y},dist:function(t){return Math.sqrt(this.distSqr(t))},distSqr:function(t){var i=t.x-this.x,n=t.y-this.y;return i*i+n*n},angle:function(){return Math.atan2(this.y,this.x)},angleTo:function(t){return Math.atan2(this.y-t.y,this.x-t.x)},angleWith:function(t){return this.angleWithSep(t.x,t.y)},angleWithSep:function(t,i){return Math.atan2(this.x*i-this.y*t,this.x*t+this.y*i)},_matMult:function(t){var i=t[0]*this.x+t[1]*this.y,n=t[2]*this.x+t[3]*this.y;return this.x=i,this.y=n,this},_add:function(t){return this.x+=t.x,this.y+=t.y,this},_sub:function(t){return this.x-=t.x,this.y-=t.y,this},_mult:function(t){return this.x*=t,this.y*=t,this},_div:function(t){return this.x/=t,this.y/=t,this},_multByPoint:function(t){return this.x*=t.x,this.y*=t.y,this},_divByPoint:function(t){return this.x/=t.x,this.y/=t.y,this},_unit:function(){return this._div(this.mag()),this},_perp:function(){var t=this.y;return this.y=this.x,this.x=-t,this},_rotate:function(t){var i=Math.cos(t),n=Math.sin(t),s=i*this.x-n*this.y,r=n*this.x+i*this.y;return this.x=s,this.y=r,this},_rotateAround:function(t,i){var n=Math.cos(t),s=Math.sin(t),r=i.x+n*(this.x-i.x)-s*(this.y-i.y),e=i.y+s*(this.x-i.x)+n*(this.y-i.y);return this.x=r,this.y=e,this},_round:function(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this}},i.convert=function(t){return t instanceof i?t:Array.isArray(t)?new i(t[0],t[1]):t}},7532:t=>{"use strict";t.exports=n,t.exports.default=n;var i=1e20;function n(t,i,n,s,r,e){this.fontSize=t||24,this.buffer=void 0===i?3:i,this.cutoff=s||.25,this.fontFamily=r||"sans-serif",this.fontWeight=e||"normal",this.radius=n||8;var h=this.size=this.fontSize+2*this.buffer,o=h+2*this.buffer;this.canvas=document.createElement("canvas"),this.canvas.width=this.canvas.height=h,this.ctx=this.canvas.getContext("2d"),this.ctx.font=this.fontWeight+" "+this.fontSize+"px "+this.fontFamily,this.ctx.textAlign="left",this.ctx.fillStyle="black",this.gridOuter=new Float64Array(o*o),this.gridInner=new Float64Array(o*o),this.f=new Float64Array(o),this.z=new Float64Array(o+1),this.v=new Uint16Array(o),this.useMetrics=void 0!==this.ctx.measureText("A").actualBoundingBoxLeft,this.middle=Math.round(h/2*(navigator.userAgent.indexOf("Gecko/")>=0?1.2:1))}function s(t,i,n,s,e,h){for(var o=0;o<i;o++)r(t,o,i,n,s,e,h);for(var a=0;a<n;a++)r(t,a*i,1,i,s,e,h)}function r(t,n,s,r,e,h,o){var a,u,c,f;for(h[0]=0,o[0]=-i,o[1]=i,a=0;a<r;a++)e[a]=t[n+a*s];for(a=1,u=0,c=0;a<r;a++){do{f=h[u],c=(e[a]-e[f]+a*a-f*f)/(a-f)/2}while(c<=o[u]&&--u>-1);h[++u]=a,o[u]=c,o[u+1]=i}for(a=0,u=0;a<r;a++){for(;o[u+1]<a;)u++;f=h[u],t[n+a*s]=e[f]+(a-f)*(a-f)}}n.prototype._draw=function(t,n){var r,e,h,o,a,u,c,f,l,d=this.ctx.measureText(t),x=d.width,y=2*this.buffer;n&&this.useMetrics?(a=Math.floor(d.actualBoundingBoxAscent),f=this.buffer+Math.ceil(d.actualBoundingBoxAscent),u=this.buffer,c=this.buffer,r=(e=Math.min(this.size,Math.ceil(d.actualBoundingBoxRight-d.actualBoundingBoxLeft)))+y,h=(o=Math.min(this.size-u,Math.ceil(d.actualBoundingBoxAscent+d.actualBoundingBoxDescent)))+y,this.ctx.textBaseline="alphabetic"):(r=e=this.size,h=o=this.size,a=19*this.fontSize/24,u=c=0,f=this.middle,this.ctx.textBaseline="middle"),e&&o&&(this.ctx.clearRect(c,u,e,o),this.ctx.fillText(t,this.buffer,f),l=this.ctx.getImageData(c,u,e,o));var g=new Uint8ClampedArray(r*h);return function(t,n,s,r,e,h,o){h.fill(i,0,n*s),o.fill(0,0,n*s);for(var a=(n-r)/2,u=0;u<e;u++)for(var c=0;c<r;c++){var f=(u+a)*n+c+a,l=t.data[4*(u*r+c)+3]/255;if(1===l)h[f]=0,o[f]=i;else if(0===l)h[f]=i,o[f]=0;else{var d=Math.max(0,.5-l),x=Math.max(0,l-.5);h[f]=d*d,o[f]=x*x}}}(l,r,h,e,o,this.gridOuter,this.gridInner),s(this.gridOuter,r,h,this.f,this.v,this.z),s(this.gridInner,r,h,this.f,this.v,this.z),function(t,i,n,s,r,e,h){for(var o=0;o<i*n;o++){var a=Math.sqrt(s[o])-Math.sqrt(r[o]);t[o]=Math.round(255-255*(a/e+h))}}(g,r,h,this.gridOuter,this.gridInner,this.radius,this.cutoff),{data:g,metrics:{width:e,height:o,sdfWidth:r,sdfHeight:h,top:a,left:0,advance:x}}},n.prototype.draw=function(t){return this._draw(t,!1).data},n.prototype.drawWithMetrics=function(t){return this._draw(t,!0)}}}]);