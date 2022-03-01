/*! For license information please see jss.js.LICENSE.txt */
"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[836],{4013:(e,t,n)=>{n.d(t,{RB:()=>D,Ue:()=>ve,JH:()=>c,_$:()=>me,HZ:()=>ge,EK:()=>f});var r=n(7462),i=n(3827),s=n(3144),o=n(1721),a=n(7326),u=n(3366),h={}.constructor;function l(e){if(null==e||"object"!=typeof e)return e;if(Array.isArray(e))return e.map(l);if(e.constructor!==h)return e;var t={};for(var n in e)t[n]=l(e[n]);return t}function c(e,t,n){void 0===e&&(e="unnamed");var r=n.jss,i=l(t),s=r.plugins.onCreateRule(e,i,n);return s||(e[0],null)}var d=function(e,t){for(var n="",r=0;r<e.length&&"!important"!==e[r];r++)n&&(n+=t),n+=e[r];return n},f=function(e,t){if(void 0===t&&(t=!1),!Array.isArray(e))return e;var n="";if(Array.isArray(e[0]))for(var r=0;r<e.length&&"!important"!==e[r];r++)n&&(n+=", "),n+=d(e[r]," ");else n=d(e,", ");return t||"!important"!==e[e.length-1]||(n+=" !important"),n};function p(e){return e&&!1===e.format?{linebreak:"",space:""}:{linebreak:"\n",space:" "}}function y(e,t){for(var n="",r=0;r<t;r++)n+="  ";return n+e}function v(e,t,n){void 0===n&&(n={});var r="";if(!t)return r;var i=n.indent,s=void 0===i?0:i,o=t.fallbacks;!1===n.format&&(s=-1/0);var a=p(n),u=a.linebreak,h=a.space;if(e&&s++,o)if(Array.isArray(o))for(var l=0;l<o.length;l++){var c=o[l];for(var d in c){var v=c[d];null!=v&&(r&&(r+=u),r+=y(d+":"+h+f(v)+";",s))}}else for(var g in o){var m=o[g];null!=m&&(r&&(r+=u),r+=y(g+":"+h+f(m)+";",s))}for(var R in t){var k=t[R];null!=k&&"fallbacks"!==R&&(r&&(r+=u),r+=y(R+":"+h+f(k)+";",s))}return(r||n.allowEmpty)&&e?(r&&(r=""+u+r+u),y(""+e+h+"{"+r,--s)+y("}",s)):r}var g=/([[\].#*$><+~=|^:(),"'`\s])/g,m="undefined"!=typeof CSS&&CSS.escape,R=function(e){return m?m(e):e.replace(g,"\\$1")},k=function(){function e(e,t,n){this.type="style",this.isProcessed=!1;var r=n.sheet,i=n.Renderer;this.key=e,this.options=n,this.style=t,r?this.renderer=r.renderer:i&&(this.renderer=new i)}return e.prototype.prop=function(e,t,n){if(void 0===t)return this.style[e];var r=!!n&&n.force;if(!r&&this.style[e]===t)return this;var i=t;n&&!1===n.process||(i=this.options.jss.plugins.onChangeValue(t,e,this));var s=null==i||!1===i,o=e in this.style;if(s&&!o&&!r)return this;var a=s&&o;if(a?delete this.style[e]:this.style[e]=i,this.renderable&&this.renderer)return a?this.renderer.removeProperty(this.renderable,e):this.renderer.setProperty(this.renderable,e,i),this;var u=this.options.sheet;return u&&u.attached,this},e}(),x=function(e){function t(t,n,r){var i;i=e.call(this,t,n,r)||this;var s=r.selector,o=r.scoped,u=r.sheet,h=r.generateId;return s?i.selectorText=s:!1!==o&&(i.id=h((0,a.Z)((0,a.Z)(i)),u),i.selectorText="."+R(i.id)),i}(0,o.Z)(t,e);var n=t.prototype;return n.applyTo=function(e){var t=this.renderer;if(t){var n=this.toJSON();for(var r in n)t.setProperty(e,r,n[r])}return this},n.toJSON=function(){var e={};for(var t in this.style){var n=this.style[t];"object"!=typeof n?e[t]=n:Array.isArray(n)&&(e[t]=f(n))}return e},n.toString=function(e){var t=this.options.sheet,n=!!t&&t.options.link?(0,r.Z)({},e,{allowEmpty:!0}):e;return v(this.selectorText,this.style,n)},(0,s.Z)(t,[{key:"selector",set:function(e){if(e!==this.selectorText){this.selectorText=e;var t=this.renderer,n=this.renderable;if(n&&t)t.setSelector(n,e)||t.replaceRule(n,this)}},get:function(){return this.selectorText}}]),t}(k),S={onCreateRule:function(e,t,n){return"@"===e[0]||n.parent&&"keyframes"===n.parent.type?null:new x(e,t,n)}},P={indent:1,children:!0},b=/@([\w-]+)/,w=function(){function e(e,t,n){this.type="conditional",this.isProcessed=!1,this.key=e;var i=e.match(b);for(var s in this.at=i?i[1]:"unknown",this.query=n.name||"@"+this.at,this.options=n,this.rules=new D((0,r.Z)({},n,{parent:this})),t)this.rules.add(s,t[s]);this.rules.process()}var t=e.prototype;return t.getRule=function(e){return this.rules.get(e)},t.indexOf=function(e){return this.rules.indexOf(e)},t.addRule=function(e,t,n){var r=this.rules.add(e,t,n);return r?(this.options.jss.plugins.onProcessRule(r),r):null},t.replaceRule=function(e,t,n){var r=this.rules.replace(e,t,n);return r&&this.options.jss.plugins.onProcessRule(r),r},t.toString=function(e){void 0===e&&(e=P);var t=p(e).linebreak;if(null==e.indent&&(e.indent=P.indent),null==e.children&&(e.children=P.children),!1===e.children)return this.query+" {}";var n=this.rules.toString(e);return n?this.query+" {"+t+n+t+"}":""},e}(),C=/@media|@supports\s+/,A={onCreateRule:function(e,t,n){return C.test(e)?new w(e,t,n):null}},I={indent:1,children:!0},O=/@keyframes\s+([\w-]+)/,j=function(){function e(e,t,n){this.type="keyframes",this.at="@keyframes",this.isProcessed=!1;var i=e.match(O);i&&i[1]?this.name=i[1]:this.name="noname",this.key=this.type+"-"+this.name,this.options=n;var s=n.scoped,o=n.sheet,a=n.generateId;for(var u in this.id=!1===s?this.name:R(a(this,o)),this.rules=new D((0,r.Z)({},n,{parent:this})),t)this.rules.add(u,t[u],(0,r.Z)({},n,{parent:this}));this.rules.process()}return e.prototype.toString=function(e){void 0===e&&(e=I);var t=p(e).linebreak;if(null==e.indent&&(e.indent=I.indent),null==e.children&&(e.children=I.children),!1===e.children)return this.at+" "+this.id+" {}";var n=this.rules.toString(e);return n&&(n=""+t+n+t),this.at+" "+this.id+" {"+n+"}"},e}(),Z=/@keyframes\s+/,q=/\$([\w-]+)/g,T=function(e,t){return"string"==typeof e?e.replace(q,(function(e,n){return n in t?t[n]:e})):e},N=function(e,t,n){var r=e[t],i=T(r,n);i!==r&&(e[t]=i)},M={onCreateRule:function(e,t,n){return"string"==typeof e&&Z.test(e)?new j(e,t,n):null},onProcessStyle:function(e,t,n){return"style"===t.type&&n?("animation-name"in e&&N(e,"animation-name",n.keyframes),"animation"in e&&N(e,"animation",n.keyframes),e):e},onChangeValue:function(e,t,n){var r=n.options.sheet;if(!r)return e;switch(t){case"animation":case"animation-name":return T(e,r.keyframes);default:return e}}},V=function(e){function t(){return e.apply(this,arguments)||this}return(0,o.Z)(t,e),t.prototype.toString=function(e){var t=this.options.sheet,n=!!t&&t.options.link?(0,r.Z)({},e,{allowEmpty:!0}):e;return v(this.key,this.style,n)},t}(k),E={onCreateRule:function(e,t,n){return n.parent&&"keyframes"===n.parent.type?new V(e,t,n):null}},G=function(){function e(e,t,n){this.type="font-face",this.at="@font-face",this.isProcessed=!1,this.key=e,this.style=t,this.options=n}return e.prototype.toString=function(e){var t=p(e).linebreak;if(Array.isArray(this.style)){for(var n="",r=0;r<this.style.length;r++)n+=v(this.at,this.style[r]),this.style[r+1]&&(n+=t);return n}return v(this.at,this.style,e)},e}(),U=/@font-face/,B={onCreateRule:function(e,t,n){return U.test(e)?new G(e,t,n):null}},$=function(){function e(e,t,n){this.type="viewport",this.at="@viewport",this.isProcessed=!1,this.key=e,this.style=t,this.options=n}return e.prototype.toString=function(e){return v(this.key,this.style,e)},e}(),J={onCreateRule:function(e,t,n){return"@viewport"===e||"@-ms-viewport"===e?new $(e,t,n):null}},H=function(){function e(e,t,n){this.type="simple",this.isProcessed=!1,this.key=e,this.value=t,this.options=n}return e.prototype.toString=function(e){if(Array.isArray(this.value)){for(var t="",n=0;n<this.value.length;n++)t+=this.key+" "+this.value[n]+";",this.value[n+1]&&(t+="\n");return t}return this.key+" "+this.value+";"},e}(),F={"@charset":!0,"@import":!0,"@namespace":!0},K=[S,A,M,E,B,J,{onCreateRule:function(e,t,n){return e in F?new H(e,t,n):null}}],_={process:!0},z={force:!0,process:!0},D=function(){function e(e){this.map={},this.raw={},this.index=[],this.counter=0,this.options=e,this.classes=e.classes,this.keyframes=e.keyframes}var t=e.prototype;return t.add=function(e,t,n){var i=this.options,s=i.parent,o=i.sheet,a=i.jss,u=i.Renderer,h=i.generateId,l=i.scoped,d=(0,r.Z)({classes:this.classes,parent:s,sheet:o,jss:a,Renderer:u,generateId:h,scoped:l,name:e,keyframes:this.keyframes,selector:void 0},n),f=e;e in this.raw&&(f=e+"-d"+this.counter++),this.raw[f]=t,f in this.classes&&(d.selector="."+R(this.classes[f]));var p=c(f,t,d);if(!p)return null;this.register(p);var y=void 0===d.index?this.index.length:d.index;return this.index.splice(y,0,p),p},t.replace=function(e,t,n){var i=this.get(e),s=this.index.indexOf(i);i&&this.remove(i);var o=n;return-1!==s&&(o=(0,r.Z)({},n,{index:s})),this.add(e,t,o)},t.get=function(e){return this.map[e]},t.remove=function(e){this.unregister(e),delete this.raw[e.key],this.index.splice(this.index.indexOf(e),1)},t.indexOf=function(e){return this.index.indexOf(e)},t.process=function(){var e=this.options.jss.plugins;this.index.slice(0).forEach(e.onProcessRule,e)},t.register=function(e){this.map[e.key]=e,e instanceof x?(this.map[e.selector]=e,e.id&&(this.classes[e.key]=e.id)):e instanceof j&&this.keyframes&&(this.keyframes[e.name]=e.id)},t.unregister=function(e){delete this.map[e.key],e instanceof x?(delete this.map[e.selector],delete this.classes[e.key]):e instanceof j&&delete this.keyframes[e.name]},t.update=function(){var e,t,n;if("string"==typeof(arguments.length<=0?void 0:arguments[0])?(e=arguments.length<=0?void 0:arguments[0],t=arguments.length<=1?void 0:arguments[1],n=arguments.length<=2?void 0:arguments[2]):(t=arguments.length<=0?void 0:arguments[0],n=arguments.length<=1?void 0:arguments[1],e=null),e)this.updateOne(this.get(e),t,n);else for(var r=0;r<this.index.length;r++)this.updateOne(this.index[r],t,n)},t.updateOne=function(t,n,r){void 0===r&&(r=_);var i=this.options,s=i.jss.plugins,o=i.sheet;if(t.rules instanceof e)t.rules.update(n,r);else{var a=t.style;if(s.onUpdate(n,t,o,r),r.process&&a&&a!==t.style){for(var u in s.onProcessStyle(t.style,t,o),t.style){var h=t.style[u];h!==a[u]&&t.prop(u,h,z)}for(var l in a){var c=t.style[l],d=a[l];null==c&&c!==d&&t.prop(l,null,z)}}}},t.toString=function(e){for(var t="",n=this.options.sheet,r=!!n&&n.options.link,i=p(e).linebreak,s=0;s<this.index.length;s++){var o=this.index[s].toString(e);(o||r)&&(t&&(t+=i),t+=o)}return t},e}(),L=function(){function e(e,t){for(var n in this.attached=!1,this.deployed=!1,this.classes={},this.keyframes={},this.options=(0,r.Z)({},t,{sheet:this,parent:this,classes:this.classes,keyframes:this.keyframes}),t.Renderer&&(this.renderer=new t.Renderer(this)),this.rules=new D(this.options),e)this.rules.add(n,e[n]);this.rules.process()}var t=e.prototype;return t.attach=function(){return this.attached||(this.renderer&&this.renderer.attach(),this.attached=!0,this.deployed||this.deploy()),this},t.detach=function(){return this.attached?(this.renderer&&this.renderer.detach(),this.attached=!1,this):this},t.addRule=function(e,t,n){var r=this.queue;this.attached&&!r&&(this.queue=[]);var i=this.rules.add(e,t,n);return i?(this.options.jss.plugins.onProcessRule(i),this.attached?this.deployed?(r?r.push(i):(this.insertRule(i),this.queue&&(this.queue.forEach(this.insertRule,this),this.queue=void 0)),i):i:(this.deployed=!1,i)):null},t.replaceRule=function(e,t,n){var r=this.rules.get(e);if(!r)return this.addRule(e,t,n);var i=this.rules.replace(e,t,n);return i&&this.options.jss.plugins.onProcessRule(i),this.attached?this.deployed?(this.renderer&&(i?r.renderable&&this.renderer.replaceRule(r.renderable,i):this.renderer.deleteRule(r)),i):i:(this.deployed=!1,i)},t.insertRule=function(e){this.renderer&&this.renderer.insertRule(e)},t.addRules=function(e,t){var n=[];for(var r in e){var i=this.addRule(r,e[r],t);i&&n.push(i)}return n},t.getRule=function(e){return this.rules.get(e)},t.deleteRule=function(e){var t="object"==typeof e?e:this.rules.get(e);return!(!t||this.attached&&!t.renderable)&&(this.rules.remove(t),!(this.attached&&t.renderable&&this.renderer)||this.renderer.deleteRule(t.renderable))},t.indexOf=function(e){return this.rules.indexOf(e)},t.deploy=function(){return this.renderer&&this.renderer.deploy(),this.deployed=!0,this},t.update=function(){var e;return(e=this.rules).update.apply(e,arguments),this},t.updateOne=function(e,t,n){return this.rules.updateOne(e,t,n),this},t.toString=function(e){return this.rules.toString(e)},e}(),Q=function(){function e(){this.plugins={internal:[],external:[]},this.registry={}}var t=e.prototype;return t.onCreateRule=function(e,t,n){for(var r=0;r<this.registry.onCreateRule.length;r++){var i=this.registry.onCreateRule[r](e,t,n);if(i)return i}return null},t.onProcessRule=function(e){if(!e.isProcessed){for(var t=e.options.sheet,n=0;n<this.registry.onProcessRule.length;n++)this.registry.onProcessRule[n](e,t);e.style&&this.onProcessStyle(e.style,e,t),e.isProcessed=!0}},t.onProcessStyle=function(e,t,n){for(var r=0;r<this.registry.onProcessStyle.length;r++)t.style=this.registry.onProcessStyle[r](t.style,t,n)},t.onProcessSheet=function(e){for(var t=0;t<this.registry.onProcessSheet.length;t++)this.registry.onProcessSheet[t](e)},t.onUpdate=function(e,t,n,r){for(var i=0;i<this.registry.onUpdate.length;i++)this.registry.onUpdate[i](e,t,n,r)},t.onChangeValue=function(e,t,n){for(var r=e,i=0;i<this.registry.onChangeValue.length;i++)r=this.registry.onChangeValue[i](r,t,n);return r},t.use=function(e,t){void 0===t&&(t={queue:"external"});var n=this.plugins[t.queue];-1===n.indexOf(e)&&(n.push(e),this.registry=[].concat(this.plugins.external,this.plugins.internal).reduce((function(e,t){for(var n in t)n in e&&e[n].push(t[n]);return e}),{onCreateRule:[],onProcessRule:[],onProcessStyle:[],onProcessSheet:[],onChangeValue:[],onUpdate:[]}))},e}(),W=function(){function e(){this.registry=[]}var t=e.prototype;return t.add=function(e){var t=this.registry,n=e.options.index;if(-1===t.indexOf(e))if(0===t.length||n>=this.index)t.push(e);else for(var r=0;r<t.length;r++)if(t[r].options.index>n)return void t.splice(r,0,e)},t.reset=function(){this.registry=[]},t.remove=function(e){var t=this.registry.indexOf(e);this.registry.splice(t,1)},t.toString=function(e){for(var t=void 0===e?{}:e,n=t.attached,r=(0,u.Z)(t,["attached"]),i=p(r).linebreak,s="",o=0;o<this.registry.length;o++){var a=this.registry[o];null!=n&&a.attached!==n||(s&&(s+=i),s+=a.toString(r))}return s},(0,s.Z)(e,[{key:"index",get:function(){return 0===this.registry.length?0:this.registry[this.registry.length-1].options.index}}]),e}(),X=new W,Y="undefined"!=typeof globalThis?globalThis:"undefined"!=typeof window&&window.Math===Math?window:"undefined"!=typeof self&&self.Math===Math?self:Function("return this")(),ee="2f1acc6c3a606b082e5eef5e54414ffb";null==Y[ee]&&(Y[ee]=0);var te=Y[ee]++,ne=function(e){void 0===e&&(e={});var t=0;return function(n,r){t+=1;var i="",s="";return r&&(r.options.classNamePrefix&&(s=r.options.classNamePrefix),null!=r.options.jss.id&&(i=String(r.options.jss.id))),e.minify?""+(s||"c")+te+i+t:s+n.key+"-"+te+(i?"-"+i:"")+"-"+t}},re=function(e){var t;return function(){return t||(t=e()),t}},ie=function(e,t){try{return e.attributeStyleMap?e.attributeStyleMap.get(t):e.style.getPropertyValue(t)}catch(e){return""}},se=function(e,t,n){try{var r=n;if(Array.isArray(n)&&(r=f(n,!0),"!important"===n[n.length-1]))return e.style.setProperty(t,r,"important"),!0;e.attributeStyleMap?e.attributeStyleMap.set(t,r):e.style.setProperty(t,r)}catch(e){return!1}return!0},oe=function(e,t){try{e.attributeStyleMap?e.attributeStyleMap.delete(t):e.style.removeProperty(t)}catch(e){}},ae=function(e,t){return e.selectorText=t,e.selectorText===t},ue=re((function(){return document.querySelector("head")}));function he(e){var t=X.registry;if(t.length>0){var n=function(e,t){for(var n=0;n<e.length;n++){var r=e[n];if(r.attached&&r.options.index>t.index&&r.options.insertionPoint===t.insertionPoint)return r}return null}(t,e);if(n&&n.renderer)return{parent:n.renderer.element.parentNode,node:n.renderer.element};if(n=function(e,t){for(var n=e.length-1;n>=0;n--){var r=e[n];if(r.attached&&r.options.insertionPoint===t.insertionPoint)return r}return null}(t,e),n&&n.renderer)return{parent:n.renderer.element.parentNode,node:n.renderer.element.nextSibling}}var r=e.insertionPoint;if(r&&"string"==typeof r){var i=function(e){for(var t=ue(),n=0;n<t.childNodes.length;n++){var r=t.childNodes[n];if(8===r.nodeType&&r.nodeValue.trim()===e)return r}return null}(r);if(i)return{parent:i.parentNode,node:i.nextSibling}}return!1}var le=re((function(){var e=document.querySelector('meta[property="csp-nonce"]');return e?e.getAttribute("content"):null})),ce=function(e,t,n){try{"insertRule"in e?e.insertRule(t,n):"appendRule"in e&&e.appendRule(t)}catch(e){return!1}return e.cssRules[n]},de=function(e,t){var n=e.cssRules.length;return void 0===t||t>n?n:t},fe=function(){function e(e){this.getPropertyValue=ie,this.setProperty=se,this.removeProperty=oe,this.setSelector=ae,this.hasInsertedRules=!1,this.cssRules=[],e&&X.add(e),this.sheet=e;var t,n=this.sheet?this.sheet.options:{},r=n.media,i=n.meta,s=n.element;this.element=s||((t=document.createElement("style")).textContent="\n",t),this.element.setAttribute("data-jss",""),r&&this.element.setAttribute("media",r),i&&this.element.setAttribute("data-meta",i);var o=le();o&&this.element.setAttribute("nonce",o)}var t=e.prototype;return t.attach=function(){if(!this.element.parentNode&&this.sheet){!function(e,t){var n=t.insertionPoint,r=he(t);if(!1!==r&&r.parent)r.parent.insertBefore(e,r.node);else if(n&&"number"==typeof n.nodeType){var i=n,s=i.parentNode;s&&s.insertBefore(e,i.nextSibling)}else ue().appendChild(e)}(this.element,this.sheet.options);var e=Boolean(this.sheet&&this.sheet.deployed);this.hasInsertedRules&&e&&(this.hasInsertedRules=!1,this.deploy())}},t.detach=function(){if(this.sheet){var e=this.element.parentNode;e&&e.removeChild(this.element),this.sheet.options.link&&(this.cssRules=[],this.element.textContent="\n")}},t.deploy=function(){var e=this.sheet;e&&(e.options.link?this.insertRules(e.rules):this.element.textContent="\n"+e.toString()+"\n")},t.insertRules=function(e,t){for(var n=0;n<e.index.length;n++)this.insertRule(e.index[n],n,t)},t.insertRule=function(e,t,n){if(void 0===n&&(n=this.element.sheet),e.rules){var r=e,i=n;if("conditional"===e.type||"keyframes"===e.type){var s=de(n,t);if(!1===(i=ce(n,r.toString({children:!1}),s)))return!1;this.refCssRule(e,s,i)}return this.insertRules(r.rules,i),i}var o=e.toString();if(!o)return!1;var a=de(n,t),u=ce(n,o,a);return!1!==u&&(this.hasInsertedRules=!0,this.refCssRule(e,a,u),u)},t.refCssRule=function(e,t,n){e.renderable=n,e.options.parent instanceof L&&this.cssRules.splice(t,0,n)},t.deleteRule=function(e){var t=this.element.sheet,n=this.indexOf(e);return-1!==n&&(t.deleteRule(n),this.cssRules.splice(n,1),!0)},t.indexOf=function(e){return this.cssRules.indexOf(e)},t.replaceRule=function(e,t){var n=this.indexOf(e);return-1!==n&&(this.element.sheet.deleteRule(n),this.cssRules.splice(n,1),this.insertRule(t,n))},t.getRules=function(){return this.element.sheet.cssRules},e}(),pe=0,ye=function(){function e(e){this.id=pe++,this.version="10.9.0",this.plugins=new Q,this.options={id:{minify:!1},createGenerateId:ne,Renderer:i.Z?fe:null,plugins:[]},this.generateId=ne({minify:!1});for(var t=0;t<K.length;t++)this.plugins.use(K[t],{queue:"internal"});this.setup(e)}var t=e.prototype;return t.setup=function(e){return void 0===e&&(e={}),e.createGenerateId&&(this.options.createGenerateId=e.createGenerateId),e.id&&(this.options.id=(0,r.Z)({},this.options.id,e.id)),(e.createGenerateId||e.id)&&(this.generateId=this.options.createGenerateId(this.options.id)),null!=e.insertionPoint&&(this.options.insertionPoint=e.insertionPoint),"Renderer"in e&&(this.options.Renderer=e.Renderer),e.plugins&&this.use.apply(this,e.plugins),this},t.createStyleSheet=function(e,t){void 0===t&&(t={});var n=t.index;"number"!=typeof n&&(n=0===X.index?0:X.index+1);var i=new L(e,(0,r.Z)({},t,{jss:this,generateId:t.generateId||this.generateId,insertionPoint:this.options.insertionPoint,Renderer:this.options.Renderer,index:n}));return this.plugins.onProcessSheet(i),i},t.removeStyleSheet=function(e){return e.detach(),X.remove(e),this},t.createRule=function(e,t,n){if(void 0===t&&(t={}),void 0===n&&(n={}),"object"==typeof e)return this.createRule(void 0,e,t);var i=(0,r.Z)({},n,{name:e,jss:this,Renderer:this.options.Renderer});i.generateId||(i.generateId=this.generateId),i.classes||(i.classes={}),i.keyframes||(i.keyframes={});var s=c(e,t,i);return s&&this.plugins.onProcessRule(s),s},t.use=function(){for(var e=this,t=arguments.length,n=new Array(t),r=0;r<t;r++)n[r]=arguments[r];return n.forEach((function(t){e.plugins.use(t)})),this},e}(),ve=function(e){return new ye(e)},ge="object"==typeof CSS&&null!=CSS&&"number"in CSS;function me(e){var t=null;for(var n in e){var r=e[n],i=typeof r;if("function"===i)t||(t={}),t[n]=r;else if("object"===i&&null!==r&&!Array.isArray(r)){var s=me(r);s&&(t||(t={}),t[n]=s)}}return t}ve()}}]);