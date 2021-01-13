!function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t():"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?exports.rdeck=t():e.rdeck=t()}(self,(function(){return(()=>{var e={8858:(e,t,r)=>{"use strict";r.r(t),r.d(t,{VERSION:()=>ue,binding:()=>se});var n={};r.r(n),r.d(n,{AGGREGATION_OPERATION:()=>l.KM,ArcLayer:()=>i.zv,BitmapLayer:()=>i.hz,CPUGridLayer:()=>l.ab,ColumnLayer:()=>i.eJ,ContourLayer:()=>l.YY,GPUGridLayer:()=>l.ML,GeoJsonLayer:()=>i.UW,GreatCircleLayer:()=>s.GJ,GridCellLayer:()=>i.cJ,GridLayer:()=>l.mU,H3ClusterLayer:()=>s.cH,H3HexagonLayer:()=>s.bW,HeatmapLayer:()=>l.zP,HexagonLayer:()=>l.dX,IconLayer:()=>i.eE,LineLayer:()=>i.Ie,MVTLayer:()=>s.i3,PathLayer:()=>i.nr,PointCloudLayer:()=>i.U5,PolygonLayer:()=>i.dW,S2Layer:()=>s.jJ,ScatterplotLayer:()=>i.pU,ScenegraphLayer:()=>u.S,ScreenGridLayer:()=>l.p3,SimpleMeshLayer:()=>u.L,SolidPolygonLayer:()=>i.PJ,TerrainLayer:()=>s.tr,TextLayer:()=>i.AB,Tile3DLayer:()=>s.cY,TileLayer:()=>s.Im,TripsLayer:()=>s.Fw,_AggregationLayer:()=>l.Di,_BinSorter:()=>l.l0,_CPUAggregator:()=>l.oA,_GPUGridAggregator:()=>l.Wc,_MultiIconLayer:()=>i.vb});r(3948);var a=r(7294),o=r(3935),c=r(6042),i=(r(8559),r(7616)),l=r(6681),s=r(4527),u=r(1864);const p=[0,0,0,255];function m([e,t,r,n=255]){return"rgba(".concat(e,", ").concat(t,", ").concat(r,", ").concat(n/255,")")}function d(e,t){var r,n;return Array.isArray(e)?t||4!==e.length?((t=null!=(r=t)?r:[])[0]=e[0],t[1]=e[1],t[2]=e[2],t[3]=3===e.length?e[3]:255,t):e:"string"==typeof e?(function(e,t){if(7===e.length){const r=parseInt(e.substring(1),16);t[0]=Math.floor(r/65536),t[1]=Math.floor(r/256%256),t[2]=r%256,t[3]=255}else if(9===e.length){const r=parseInt(e.substring(1),16);t[0]=Math.floor(r/16777216),t[1]=Math.floor(r/65536%256),t[2]=Math.floor(r/256%256),t[3]=r%256}}(e,t=null!=(n=t)?n:[]),t):p}var f=r(1960),y=r(5128),h=r(3446),g=r(6297),b=r(7603),E=r(6602);function v(e){return null!==e&&"object"==typeof e&&"accessor"===e.type}function w(e,t){const r=function({col:e,dataType:t},r){if("highlightColor"===r)switch(t){case"table":return function(e){return({index:t,layer:r})=>d(r.props.data.frame[e][t])}(e);case"object":return function(e){return({object:t})=>d(t[e])}(e);case"geojson":return function(e){return({object:t})=>d(t.properties[e])}(e);default:throw TypeError("".concat(t," not supported"))}if(r.endsWith("Color"))switch(t){case"table":return function(e){return(t,{index:r,data:n,target:a})=>d(n.frame[e][r],a)}(e);case"object":return function(e){return(t,{target:r})=>d(t[e],r)}(e);case"geojson":return function(e){return(t,{target:r})=>d(t.properties[e],r)}(e);default:throw TypeError("".concat(t," not supported"))}switch(t){case"table":return function(e){return(t,{index:r,data:n})=>n.frame[e][r]}(e);case"object":return function(e){return t=>t[e]}(e);case"geojson":return function(e){return t=>t.properties[e]}(e);default:throw TypeError("".concat(t," not supported"))}}(e,t);return{...e,getData:r}}function L(e){return v(e)&&"scale"in e}function k(e,t){"palette"in e&&(e.range=e.palette.map((e=>d(e))),e.unknown=d(e.unknown));const r=function(e){switch(e.scale){case"linear":return(0,f.Z)().domain(e.domain).range(e.range).unknown(e.unknown).clamp(!0);case"power":return(0,y.ZP)().exponent(e.exponent).domain(e.domain).range(e.range).unknown(e.unknown).clamp(!0);case"log":return(0,h.Z)().base(e.base).domain(e.domain).range(e.range).unknown(e.unknown).clamp(!0);case"threshold":case"quantile":return(0,g.Z)().domain(e.domain).range(e.range).unknown(e.unknown);case"category":return(0,b.Z)().domain(e.domain).range(e.range).unknown(e.unknown);case"quantize":return(0,E.Z)().domain(e.domain).range(e.range).unknown(e.unknown);default:throw TypeError("scale ".concat(e.scale," not supported"))}}(e),n="highlightColor"===t?function({col:e,dataType:t},r){switch(t){case"table":return function(e,t){return({index:r,layer:n})=>{var a;return t(null!=(a=n.props.data.frame[e][r])?a:void 0)}}(e,r);case"object":return function(e,t){return({object:r})=>{var n;return t(null!=(n=r[e])?n:void 0)}}(e,r);case"geojson":return function(e,t){return({object:r})=>{var n;return t(null!=(n=r.properties[e])?n:void 0)}}(e,r);default:throw TypeError("".concat(t," not supported"))}}(e,r):function({col:e,dataType:t},r){switch(t){case"table":return function(e,t){return(r,{index:n,data:a})=>{var o;return t(null!=(o=a.frame[e][n])?o:void 0)}}(e,r);case"object":return function(e,t){return r=>{var n;return t(null!=(n=r[e])?n:void 0)}}(e,r);case"geojson":return function(e,t){return r=>{var n;return t(null!=(n=r.properties[e])?n:void 0)}}(e,r);default:throw TypeError("".concat(t," not supported"))}}(e,r);return{...e,name:t,getData:n,scaleData:r}}function T(e="normal"){switch(e){case"additive":return{3042:!0,blendFunc:[770,772],blendEquation:32774};case"subtractive":return{3042:!0,blendFunc:[1,775,770,772],blendEquation:[32778,32774]};case"normal":default:return{3042:!0,blendFunc:[770,771,1,771],blendEquation:[32774,32774]}}}r(5827),r(5306);function j(e){const t=function(e){return Object.entries(e.geometry).filter((([,e])=>/MULTI/.test(e))).map((([e,t])=>({name:e,type:t})))}(e);return 0===t.length?e:t.reduce(x,e)}function x(e,{name:t,type:r}){const n=e.frame,a=Object.fromEntries(Object.entries(n).map((([e])=>[e,[]]))),o=Object.keys(e.frame).filter((e=>e!==t)),c=n[t],i=function(e){switch(e){case"MULTIPOINT":return M;case"MULTILINESTRING":return O;case"MULTIPOLYGON":return N;default:throw TypeError("".concat(e," not supported"))}}(r),l=(e,t)=>a[e].push(n[e][t]);for(let r=0;r<e.length;r++)if(i(c[r])){a[t].push(...c[r]);for(let e=0;e<c[r].length;e++)for(const e of o)l(e,r)}else{l(t,r);for(const e of o)l(e,r)}return{geometry:{...e.geometry,[t]:r.replace("MULTI","")},length:a[t].length,frame:a}}function M(e){return Array.isArray(e[0])}function O(e){return Array.isArray(e[0][0])}function N(e){return Array.isArray(e[0][0][0])}class S{constructor({type:e,...t}){this.type=void 0,this.props=void 0,this.scales=void 0;const r=Object.entries(t),n=function(e){const t=e.filter(A).map((([e,t])=>[e,d(t)])),r=e.find((([e])=>"colorRange"===e));r&&t.push([r[0],r[1].map((e=>d(e)))]);return t}(r),a=function(e){return e.filter((([,e])=>v(e))).map((([e,t])=>[e,L(t)?k(t,e):w(t,e)]))}(r);var o,c,i;if(this.type=e,this.props=Object.fromEntries([...r,...n,...a.map((([e,t])=>[e,t.getData])),...P(r),["updateTriggers",C(a)],["parameters",(o=t.parameters,c=t.blendingMode,{...o,...T(c)})]]),this.scales=a.filter((([,e])=>L(e))).map((([,e])=>e)),null!==(i=t.data)&&"object"==typeof i&&"frame"in i&&(this.props.data=j(t.data)),"TextLayer"===e&&"fonts"in document){const e=t;document.fonts.load("16px ".concat(e.fontFamily))}}static create(e){return new S(e)}renderLayer(e){if("TripsLayer"===this.type&&void 0!==e){const t=this.props,{loopLength:r,animationSpeed:n}=t,a=r/n,o=e/1e3%a/a;t.currentTime=o*r}return new n[this.type](this.props)}renderLegend(){const e=this.scales.filter((e=>e.legend));return{id:this.props.id,name:this.props.name,scales:e}}}function A([e,t]){return e.endsWith("Color")&&(Array.isArray(t)||"string"==typeof t)}function C(e){const t=e=>{const{getData:t,scaleData:r,palette:n,...a}=e;return a},r=e.map((([e,r])=>[e,t(r)]));return Object.fromEntries(r)}function P(e){return e.filter((([e])=>"getColorWeight"===e||"getElevationWeight"===e)).filter((([,e])=>null!==e&&"function"!=typeof e&&!v(e))).map((([e,t])=>[e,e=>t]))}var _=r(7391),I=r(7590);const D="_3rdxBLth1N2ey-DR8zZS3k",G="_3a-qtBZofjlel3EyiZrLe0",Z="_3L9Gh0vaiKQ5lmrBXb1Ppa",z="_4LWuEkar5BaPjDJypGFMM",U="_1SNUXvO9jR7Km5I-4zWVkl",H=({info:e})=>{if(null==e)return null;const{index:t,layer:r,x:n,y:o}=e,{name:c,tooltip:i}=r.props,l=function(e){switch(e){case"table":return(e,{index:t,data:r})=>{const n=Object.entries(r.frame).map((([e,r])=>[e,r[t]]));return Object.fromEntries(n)};case"object":return e=>e;case"geojson":return e=>{var t;return null!=(t=e.properties)?t:{}};default:throw TypeError("".concat(e," not supported"))}}(i.dataType)(e.object,{index:t,data:r.props.data}),s=!0===i.cols?Object.keys(l):i.cols;return a.createElement("div",{className:D,style:{transform:"translate(".concat(n,"px, ").concat(o,"px)")}},a.createElement("div",{className:G},c),a.createElement("table",{className:Z},a.createElement("tbody",null,s.map((e=>{var t;return a.createElement("tr",{key:e},a.createElement("td",{className:z},e),a.createElement("td",{className:U},String(null!=(t=l[e])?t:null)))})))))},R=(0,a.memo)(H);function W(){return(W=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var n in r)Object.prototype.hasOwnProperty.call(r,n)&&(e[n]=r[n])}return e}).apply(this,arguments)}function q({props:e,layers:t}){const r=(0,a.useRef)(null),[n,o]=Y(),{mapboxApiAccessToken:i,mapStyle:l,mapOptions:s,controller:u,parameters:p,blendingMode:m,...d}=e,f={...p,...T(m)},[y,h]=(0,a.useState)((()=>t.map((e=>e.renderLayer())))),g=0!==t.filter((e=>"TripsLayer"===e.type)).length;return B(g,(e=>h(t.map((t=>t.renderLayer(e)))))),a.createElement(a.Fragment,null,a.createElement(_.Z,W({ref:r},d,{parameters:f,layers:y,onHover:o}),a.createElement(I.Z,{id:"map",controller:u,repeat:!0},l&&a.createElement(c.Z3,W({reuseMaps:!0},{mapboxApiAccessToken:i,mapStyle:l,mapOptions:s})))),a.createElement(R,{info:n}))}const Y=()=>{const[e,t]=(0,a.useState)(null);return[e,(0,a.useCallback)((e=>{if(!e.picked||!e.layer.props.tooltip)return t(null);t(e)}),[])]},B=(e,t)=>{const r=(0,a.useRef)(0),n=(0,a.useRef)(Date.now()),o=()=>{t(Date.now()-n.current),r.current=window.requestAnimationFrame(o)};(0,a.useEffect)((()=>{if(e)return r.current=window.requestAnimationFrame(o),()=>window.cancelAnimationFrame(r.current)}),[e])};function F(e){return e.clientHeight>0&&e.clientHeight>0?e:e.parentElement?F(e.parentElement):null}function Q(e){const t=F(e);if(e===t||null==t)return[e.clientWidth,e.clientHeight];const{width:r,height:n}=getComputedStyle(e),a=document.createElement("div");Object.assign(a.style,{width:r,height:n,display:"hidden"}),t.appendChild(a);const o=[a.clientWidth,a.clientHeight];return t.removeChild(a),o}const J={legend:"_19x6CEViDqIUJgmzMHUO_L",kepler:"kepler",light:"light",layer:"_1O5QPr7CiTBczYArgl3S--","layer-name":"_1_q1TQIZ88zoNRCuCezvNi",layerName:"_1_q1TQIZ88zoNRCuCezvNi",scale:"ePCUM6mslf2Y-i0jhVFMh","scale-name":"_3YhhTqYy3O5ALWcQDpz_EK",scaleName:"_3YhhTqYy3O5ALWcQDpz_EK","scale-by":"lMTfZcYbDODR5PTtyG7HK",scaleBy:"lMTfZcYbDODR5PTtyG7HK","color-scale":"_1mPi0Qw9KZYGIt5csk3PZh",colorScale:"_1mPi0Qw9KZYGIt5csk3PZh",tick:"UU3enfH0Fz4EvQztbQYag",line:"_8tiBQbbvJsBZ-JMiVr_n9"};function K(){return(K=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var n in r)Object.prototype.hasOwnProperty.call(r,n)&&(e[n]=r[n])}return e}).apply(this,arguments)}const V=16;function X({layers:e}){return 0===e.length?null:a.createElement("div",{className:J.legend},e.map((e=>a.createElement($,K({key:e.id},e)))))}function $({name:e,scales:t}){return 0===t.length?null:a.createElement("div",{className:J.layer},a.createElement("div",{className:J.layerName},e),t.map((e=>a.createElement(ee,K({key:e.name},e)))))}function ee(e){const t=e.name.replace(/^get/,"").replace(/([A-Z])/g," $1").toLowerCase();const r="palette"in e;const n=function(e){return"linear"===e.scale||"power"===e.scale||"log"===e.scale}(e),o=function(e){return"threshold"===e.scale||"quantile"===e.scale||"quantize"===e.scale}(e);return a.createElement("div",{className:J.scale},a.createElement("div",{className:J.scaleName},t),a.createElement("span",{className:J.scaleBy},"by "),a.createElement("span",{className:J.fieldName},e.col),r&&n&&a.createElement(te,e),r&&o&&a.createElement(re,e),r&&"category"===e.scale&&a.createElement(ne,e))}const te=({ticks:e,scaleData:t})=>{const r=e.map(((e,t)=>t)).slice(1,-1),n=V*(e.length-1),o=n+10+1;return a.createElement("svg",{className:J.colorScale,height:o,shapeRendering:"crispEdges"},a.createElement("svg",{y:5},a.createElement("image",{width:20,height:n,href:oe(t),preserveAspectRatio:"none"}),r.map((e=>a.createElement("line",{key:e,className:J.line,x2:20,y1:V*e,y2:V*e})))),a.createElement(ae,K({ticks:e},{y:-2})))},re=({ticks:e,range:t})=>{const r=t.map(m),n=V*(e.length-1)+10+1;return a.createElement("svg",{className:J.colorScale,height:n,shapeRendering:"crispEdges"},a.createElement("svg",{y:5},r.map(((e,t)=>a.createElement("rect",{key:t,width:20,height:V,y:t*V,fill:e})))),a.createElement(ae,K({ticks:e},{y:-2})))};function ne({ticks:e,range:t}){const r=t.map(m),n=V*e.length;return a.createElement("svg",{className:J.colorScale,height:n},a.createElement("svg",null,r.map(((e,t)=>a.createElement("rect",{key:t,width:20,height:14,y:1+t*V,fill:e})))),a.createElement(ae,{ticks:e}))}function ae({ticks:e,x:t=28,y:r=0}){return a.createElement("svg",{x:t,y:r},e.map(((e,t)=>a.createElement("text",{key:t,className:J.tick,y:V*t,dy:10},String(e)))))}function oe(e,t=200){const r=e.range().length,n=[...Array(r).keys()].map((e=>e/(r-1))),a=e.copy().range(n).invert,o=document.createElement("canvas"),c=o.getContext("2d");o.width=1,o.height=t;for(let r=0;r<t;r++)c.fillStyle=m(e(a(r/t))),c.fillRect(0,r,1,1);return o.toDataURL()}const ce="rdeck";function ie({props:e,layers:t,theme:r="kepler",width:n,height:o}){const{initialBounds:i,initialViewState:l,...s}=e,u=function(e,t,r,n){return(0,a.useMemo)((()=>{if(!Array.isArray(r))return n;const[a,o,i,l]=r,s=[[Math.max(-180,a),Math.max(o,-85.051129)],[Math.min(180,i),Math.min(l,85.051129)]],u=new c.DW({width:e,height:t}),{longitude:p,latitude:m,zoom:d}=u.fitBounds(s);return{...n,longitude:p,latitude:m,zoom:d}}),[r,n,e,t])}(n,o,i,l),p=t.map(S.create),m="".concat(ce," ").concat(r);return a.createElement("div",{className:m},a.createElement(q,{props:{...s,initialViewState:u},layers:p}),a.createElement(X,{layers:p.map((e=>e.renderLegend())).reverse()}))}const le={name:"rdeck",type:"output",factory(e,t,r){function n({props:n,layers:c,theme:i}){o.render(a.createElement(ie,{props:n,layers:c,theme:i,width:t,height:r}),e)}return 0!==t&&0!==r||([t,r]=Q(e)),{renderValue({props:t,layers:r,theme:a}){n({props:t,layers:r,theme:a}),HTMLWidgets.shinyMode&&(Shiny.addCustomMessageHandler("".concat(e.id,":layer"),(e=>{r=function(e,t){const r=e.find((e=>e.id===t.id));if(!r)return[...e,t];return e.map((e=>{var n;return e!==r?e:{...t,data:null!=(n=t.data)?n:r.data}}))}(r,e),n({props:t,layers:r,theme:a})})),Shiny.addCustomMessageHandler("".concat(e.id,":deck"),(e=>{t={...t,...e.props},a=e.theme,n({props:t,layers:r,theme:a})})))},resize(e,t){}}}};HTMLWidgets.widget(le);const se=le,ue="0.3.0"},6561:()=>{},9559:()=>{},5533:()=>{}},t={};function r(n){if(t[n])return t[n].exports;var a=t[n]={exports:{}};return e[n].call(a.exports,a,a.exports,r),a.exports}return r.m=e,r.x=e=>{},r.n=e=>{var t=e&&e.__esModule?()=>e.default:()=>e;return r.d(t,{a:t}),t},r.d=(e,t)=>{for(var n in t)r.o(t,n)&&!r.o(e,n)&&Object.defineProperty(e,n,{enumerable:!0,get:t[n]})},r.g=function(){if("object"==typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"==typeof window)return window}}(),r.o=(e,t)=>Object.prototype.hasOwnProperty.call(e,t),r.r=e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},(()=>{var e={472:0},t=[[8858,950,514,291,340,637]],n=e=>{},a=(a,o)=>{for(var c,i,[l,s,u,p]=o,m=0,d=[];m<l.length;m++)i=l[m],r.o(e,i)&&e[i]&&d.push(e[i][0]),e[i]=0;for(c in s)r.o(s,c)&&(r.m[c]=s[c]);for(u&&u(r),a&&a(o);d.length;)d.shift()();return p&&t.push.apply(t,p),n()},o=self.webpackChunkrdeck=self.webpackChunkrdeck||[];function c(){for(var n,a=0;a<t.length;a++){for(var o=t[a],c=!0,i=1;i<o.length;i++){var l=o[i];0!==e[l]&&(c=!1)}c&&(t.splice(a--,1),n=r(r.s=o[0]))}return 0===t.length&&(r.x(),r.x=e=>{}),n}o.forEach(a.bind(null,0)),o.push=a.bind(null,o.push.bind(o));var i=r.x;r.x=()=>(r.x=i||(e=>{}),(n=c)())})(),r.x()})()}));