"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[899],{3485:(t,e,s)=>{s.d(e,{Z:()=>r});var i=s(3370),n=s(2363);const o=globalThis;function r(t){if(!t&&!(0,i.Z)())return"Node";if((0,n.Z)(t))return"Electron";const e="undefined"!=typeof navigator?navigator:{},s=t||e.userAgent||"";if(s.indexOf("Edge")>-1)return"Edge";const r=-1!==s.indexOf("MSIE "),a=-1!==s.indexOf("Trident/");return r||a?"IE":o.chrome?"Chrome":o.safari?"Safari":o.mozInnerScreenX?"Firefox":"Unknown"}},3370:(t,e,s)=>{s.d(e,{Z:()=>n});var i=s(2363);function n(){return!("object"==typeof process&&"[object process]"===String(process)&&!process.browser)||(0,i.Z)()}},2363:(t,e,s)=>{function i(t){if("undefined"!=typeof window&&"object"==typeof window.process&&"renderer"===window.process.type)return!0;if("undefined"!=typeof process&&"object"==typeof process.versions&&Boolean(process.versions.electron))return!0;const e="object"==typeof navigator&&"string"==typeof navigator.userAgent&&navigator.userAgent,s=t||e;return!!(s&&s.indexOf("Electron")>=0)}s.d(e,{Z:()=>i})},9109:(t,e,s)=>{s.d(e,{Z:()=>T});var i=s(4942),n=s(3370);const o="0.4.0";(0,n.Z)();class r{constructor(t){let e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},s=arguments.length>2&&void 0!==arguments[2]?arguments[2]:"sessionStorage";(0,i.Z)(this,"storage",void 0),(0,i.Z)(this,"id",void 0),(0,i.Z)(this,"config",{}),this.storage=function(t){try{const e=window[t],s="__storage_test__";return e.setItem(s,s),e.removeItem(s),e}catch(t){return null}}(s),this.id=t,this.config={},Object.assign(this.config,e),this._loadConfiguration()}getConfiguration(){return this.config}setConfiguration(t){return this.config={},this.updateConfiguration(t)}updateConfiguration(t){if(Object.assign(this.config,t),this.storage){const t=JSON.stringify(this.config);this.storage.setItem(this.id,t)}return this}_loadConfiguration(){let t={};if(this.storage){const e=this.storage.getItem(this.id);t=e?JSON.parse(e):{}}return Object.assign(this.config,t),this}}function a(t,e,s){let i=arguments.length>3&&void 0!==arguments[3]?arguments[3]:600;const n=t.src.replace(/\(/g,"%28").replace(/\)/g,"%29");t.width>i&&(s=Math.min(s,i/t.width));const o=t.width*s,r=t.height*s,a=["font-size:1px;","padding:".concat(Math.floor(r/2),"px ").concat(Math.floor(o/2),"px;"),"line-height:".concat(r,"px;"),"background:url(".concat(n,");"),"background-size:".concat(o,"px ").concat(r,"px;"),"color:transparent;"].join("");return["".concat(e," %c+"),a]}let c;function l(t){return"string"==typeof t?c[t.toUpperCase()]||c.WHITE:t}function h(t,e){if(!t)throw new Error(e||"Assertion failed")}!function(t){t[t.BLACK=30]="BLACK",t[t.RED=31]="RED",t[t.GREEN=32]="GREEN",t[t.YELLOW=33]="YELLOW",t[t.BLUE=34]="BLUE",t[t.MAGENTA=35]="MAGENTA",t[t.CYAN=36]="CYAN",t[t.WHITE=37]="WHITE",t[t.BRIGHT_BLACK=90]="BRIGHT_BLACK",t[t.BRIGHT_RED=91]="BRIGHT_RED",t[t.BRIGHT_GREEN=92]="BRIGHT_GREEN",t[t.BRIGHT_YELLOW=93]="BRIGHT_YELLOW",t[t.BRIGHT_BLUE=94]="BRIGHT_BLUE",t[t.BRIGHT_MAGENTA=95]="BRIGHT_MAGENTA",t[t.BRIGHT_CYAN=96]="BRIGHT_CYAN",t[t.BRIGHT_WHITE=97]="BRIGHT_WHITE"}(c||(c={}));const g={self:"undefined"!=typeof self&&self,window:"undefined"!=typeof window&&window,global:void 0!==s.g&&s.g,document:"undefined"!=typeof document&&document,process:"object"==typeof process&&process},u=(globalThis,g.window||g.self||g.global),d=g.process||{};console;function m(){let t;var e,s;if(n.Z&&"performance"in u)t=null==u||null===(e=u.performance)||void 0===e||null===(s=e.now)||void 0===s?void 0:s.call(e);else if("hrtime"in d){var i;const e=null==d||null===(i=d.hrtime)||void 0===i?void 0:i.call(d);t=1e3*e[0]+e[1]/1e6}else t=Date.now();return t}const f={debug:n.Z&&console.debug||console.log,log:console.log,info:console.info,warn:console.warn,error:console.error},p={enabled:!0,level:0};function _(){}const v={},b={once:!0};class T{constructor(){let{id:t}=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{id:""};(0,i.Z)(this,"id",void 0),(0,i.Z)(this,"VERSION",o),(0,i.Z)(this,"_startTs",m()),(0,i.Z)(this,"_deltaTs",m()),(0,i.Z)(this,"_storage",void 0),(0,i.Z)(this,"userData",{}),(0,i.Z)(this,"LOG_THROTTLE_TIMEOUT",0),this.id=t,this._storage=new r("__probe-".concat(this.id,"__"),p),this.userData={},this.timeStamp("".concat(this.id," started")),function(t){let e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:["constructor"];const s=Object.getPrototypeOf(t),i=Object.getOwnPropertyNames(s);for(const s of i)"function"==typeof t[s]&&(e.find((t=>s===t))||(t[s]=t[s].bind(t)))}(this),Object.seal(this)}set level(t){this.setLevel(t)}get level(){return this.getLevel()}isEnabled(){return this._storage.config.enabled}getLevel(){return this._storage.config.level}getTotal(){return Number((m()-this._startTs).toPrecision(10))}getDelta(){return Number((m()-this._deltaTs).toPrecision(10))}set priority(t){this.level=t}get priority(){return this.level}getPriority(){return this.level}enable(){let t=!(arguments.length>0&&void 0!==arguments[0])||arguments[0];return this._storage.updateConfiguration({enabled:t}),this}setLevel(t){return this._storage.updateConfiguration({level:t}),this}get(t){return this._storage.config[t]}set(t,e){this._storage.updateConfiguration({[t]:e})}settings(){console.table?console.table(this._storage.config):console.log(this._storage.config)}assert(t,e){h(t,e)}warn(t){return this._getLogFunction(0,t,f.warn,arguments,b)}error(t){return this._getLogFunction(0,t,f.error,arguments)}deprecated(t,e){return this.warn("`".concat(t,"` is deprecated and will be removed in a later version. Use `").concat(e,"` instead"))}removed(t,e){return this.error("`".concat(t,"` has been removed. Use `").concat(e,"` instead"))}probe(t,e){return this._getLogFunction(t,e,f.log,arguments,{time:!0,once:!0})}log(t,e){return this._getLogFunction(t,e,f.debug,arguments)}info(t,e){return this._getLogFunction(t,e,console.info,arguments)}once(t,e){for(var s=arguments.length,i=new Array(s>2?s-2:0),n=2;n<s;n++)i[n-2]=arguments[n];return this._getLogFunction(t,e,f.debug||f.info,arguments,b)}table(t,e,s){return e?this._getLogFunction(t,e,console.table||_,s&&[s],{tag:L(e)}):_}image(t){let{logLevel:e,priority:i,image:o,message:r="",scale:c=1}=t;return this._shouldLog(e||i)?n.Z?function(t){let{image:e,message:s="",scale:i=1}=t;if("string"==typeof e){const t=new Image;return t.onload=()=>{const e=a(t,s,i);console.log(...e)},t.src=e,_}const n=e.nodeName||"";if("img"===n.toLowerCase())return console.log(...a(e,s,i)),_;if("canvas"===n.toLowerCase()){const t=new Image;return t.onload=()=>console.log(...a(t,s,i)),t.src=e.toDataURL(),_}return _}({image:o,message:r,scale:c}):function(t){let{image:e,message:i="",scale:n=1}=t,o=null;try{o=s(9214)}catch(t){}if(o)return()=>o(e,{fit:"box",width:"".concat(Math.round(80*n),"%")}).then((t=>console.log(t)));return _}({image:o,message:r,scale:c}):_}time(t,e){return this._getLogFunction(t,e,console.time?console.time:console.info)}timeEnd(t,e){return this._getLogFunction(t,e,console.timeEnd?console.timeEnd:console.info)}timeStamp(t,e){return this._getLogFunction(t,e,console.timeStamp||_)}group(t,e){let s=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{collapsed:!1};const i=E({logLevel:t,message:e,opts:s}),{collapsed:n}=s;return i.method=(n?console.groupCollapsed:console.group)||console.info,this._getLogFunction(i)}groupCollapsed(t,e){let s=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};return this.group(t,e,Object.assign({},s,{collapsed:!0}))}groupEnd(t){return this._getLogFunction(t,"",console.groupEnd||_)}withGroup(t,e,s){this.group(t,e)();try{s()}finally{this.groupEnd(t)()}}trace(){console.trace&&console.trace()}_shouldLog(t){return this.isEnabled()&&this.getLevel()>=w(t)}_getLogFunction(t,e,s,i,o){if(this._shouldLog(t)){o=E({logLevel:t,message:e,args:i,opts:o}),h(s=s||o.method),o.total=this.getTotal(),o.delta=this.getDelta(),this._deltaTs=m();const r=o.tag||o.message;if(o.once){if(v[r])return _;v[r]=m()}return e=function(t,e,s){if("string"==typeof e){const a=s.time?function(t){let e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:8;const s=Math.max(e-t.length,0);return"".concat(" ".repeat(s)).concat(t)}(function(t){let e;return e=t<10?"".concat(t.toFixed(2),"ms"):t<100?"".concat(t.toFixed(1),"ms"):t<1e3?"".concat(t.toFixed(0),"ms"):"".concat((t/1e3).toFixed(2),"s"),e}(s.total)):"";e=s.time?"".concat(t,": ").concat(a,"  ").concat(e):"".concat(t,": ").concat(e),i=e,o=s.color,r=s.background,n.Z||"string"!=typeof i||(o&&(o=l(o),i="[".concat(o,"m").concat(i,"[39m")),r&&(o=l(r),i="[".concat(r+10,"m").concat(i,"[49m"))),e=i}var i,o,r;return e}(this.id,o.message,o),s.bind(console,e,...o.args)}return _}}function w(t){if(!t)return 0;let e;switch(typeof t){case"number":e=t;break;case"object":e=t.logLevel||t.priority||0;break;default:return 0}return h(Number.isFinite(e)&&e>=0),e}function E(t){const{logLevel:e,message:s}=t;t.logLevel=w(e);const i=t.args?Array.from(t.args):[];for(;i.length&&i.shift()!==s;);switch(typeof e){case"string":case"function":void 0!==s&&i.unshift(s),t.message=e;break;case"object":Object.assign(t,e)}"function"==typeof t.message&&(t.message=t.message());const n=typeof t.message;return h("string"===n||"object"===n),Object.assign(t,{args:i},t.opts)}function L(t){for(const e in t)for(const s in t[e])return s||"untitled";return"empty"}(0,i.Z)(T,"VERSION",o)},8295:(t,e,s)=>{s.d(e,{Z:()=>r});var i=s(4942);function n(){let t;if("undefined"!=typeof window&&window.performance)t=window.performance.now();else if("undefined"!=typeof process&&process.hrtime){const e=process.hrtime();t=1e3*e[0]+e[1]/1e6}else t=Date.now();return t}class o{constructor(t,e){(0,i.Z)(this,"name",void 0),(0,i.Z)(this,"type",void 0),(0,i.Z)(this,"sampleSize",1),(0,i.Z)(this,"time",void 0),(0,i.Z)(this,"count",void 0),(0,i.Z)(this,"samples",void 0),(0,i.Z)(this,"lastTiming",void 0),(0,i.Z)(this,"lastSampleTime",void 0),(0,i.Z)(this,"lastSampleCount",void 0),(0,i.Z)(this,"_count",0),(0,i.Z)(this,"_time",0),(0,i.Z)(this,"_samples",0),(0,i.Z)(this,"_startTime",0),(0,i.Z)(this,"_timerPending",!1),this.name=t,this.type=e,this.reset()}setSampleSize(t){return this.sampleSize=t,this}incrementCount(){return this.addCount(1),this}decrementCount(){return this.subtractCount(1),this}addCount(t){return this._count+=t,this._samples++,this._checkSampling(),this}subtractCount(t){return this._count-=t,this._samples++,this._checkSampling(),this}addTime(t){return this._time+=t,this.lastTiming=t,this._samples++,this._checkSampling(),this}timeStart(){return this._startTime=n(),this._timerPending=!0,this}timeEnd(){return this._timerPending?(this.addTime(n()-this._startTime),this._timerPending=!1,this._checkSampling(),this):this}getSampleAverageCount(){return this.sampleSize>0?this.lastSampleCount/this.sampleSize:0}getSampleAverageTime(){return this.sampleSize>0?this.lastSampleTime/this.sampleSize:0}getSampleHz(){return this.lastSampleTime>0?this.sampleSize/(this.lastSampleTime/1e3):0}getAverageCount(){return this.samples>0?this.count/this.samples:0}getAverageTime(){return this.samples>0?this.time/this.samples:0}getHz(){return this.time>0?this.samples/(this.time/1e3):0}reset(){return this.time=0,this.count=0,this.samples=0,this.lastTiming=0,this.lastSampleTime=0,this.lastSampleCount=0,this._count=0,this._time=0,this._samples=0,this._startTime=0,this._timerPending=!1,this}_checkSampling(){this._samples===this.sampleSize&&(this.lastSampleTime=this._time,this.lastSampleCount=this._count,this.count+=this._count,this.time+=this._time,this.samples+=this._samples,this._time=0,this._count=0,this._samples=0)}}class r{constructor(t){(0,i.Z)(this,"id",void 0),(0,i.Z)(this,"stats",{}),this.id=t.id,this.stats={},this._initializeStats(t.stats),Object.seal(this)}get(t){let e=arguments.length>1&&void 0!==arguments[1]?arguments[1]:"count";return this._getOrCreate({name:t,type:e})}get size(){return Object.keys(this.stats).length}reset(){for(const t in this.stats)this.stats[t].reset();return this}forEach(t){for(const e in this.stats)t(this.stats[e])}getTable(){const t={};return this.forEach((e=>{t[e.name]={time:e.time||0,count:e.count||0,average:e.getAverageTime()||0,hz:e.getHz()||0}})),t}_initializeStats(){(arguments.length>0&&void 0!==arguments[0]?arguments[0]:[]).forEach((t=>this._getOrCreate(t)))}_getOrCreate(t){if(!t||!t.name)return null;const{name:e,type:s}=t;return this.stats[e]||(this.stats[e]=t instanceof o?t:new o(e,s)),this.stats[e]}}}}]);