(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[134],{3041:(e,t,n)=>{"use strict";n.d(t,{Q:()=>W});var s=n(840),i=n.n(s);const o={mousedown:1,mousemove:2,mouseup:4};!function(e){const t=e.prototype.handler;e.prototype.handler=function(e){const n=this.store;e.button>0&&(function(e,t){for(let n=0;n<e.length;n++)if(t(e[n]))return!0;return!1}(n,(t=>t.pointerId===e.pointerId))||n.push(e)),t.call(this,e)}}(i().PointerEventInput),i().MouseInput.prototype.handler=function(e){let t=o[e.type];1&t&&e.button>=0&&(this.pressed=!0),2&t&&0===e.which&&(t=4),this.pressed&&(4&t&&(this.pressed=!1),this.callback(this.manager,t,{pointers:[e],changedPointers:[e],pointerType:"mouse",srcEvent:e}))};const a=i().Manager,r=i(),h=r?[[r.Pan,{event:"tripan",pointers:3,threshold:0,enable:!1}],[r.Rotate,{enable:!1}],[r.Pinch,{enable:!1}],[r.Swipe,{enable:!1}],[r.Pan,{threshold:0,enable:!1}],[r.Press,{enable:!1}],[r.Tap,{event:"doubletap",taps:2,enable:!1}],[r.Tap,{event:"anytap",enable:!1}],[r.Tap,{enable:!1}]]:null,l={tripan:["rotate","pinch","pan"],rotate:["pinch"],pinch:["pan"],pan:["press","doubletap","anytap","tap"],doubletap:["anytap"],anytap:["tap"]},p={doubletap:["tap"]},c={pointerdown:"pointerdown",pointermove:"pointermove",pointerup:"pointerup",touchstart:"pointerdown",touchmove:"pointermove",touchend:"pointerup",mousedown:"pointerdown",mousemove:"pointermove",mouseup:"pointerup"},v={KEY_EVENTS:["keydown","keyup"],MOUSE_EVENTS:["mousedown","mousemove","mouseup","mouseover","mouseout","mouseleave"],WHEEL_EVENTS:["wheel","mousewheel"]},d={tap:"tap",anytap:"anytap",doubletap:"doubletap",press:"press",pinch:"pinch",pinchin:"pinch",pinchout:"pinch",pinchstart:"pinch",pinchmove:"pinch",pinchend:"pinch",pinchcancel:"pinch",rotate:"rotate",rotatestart:"rotate",rotatemove:"rotate",rotateend:"rotate",rotatecancel:"rotate",tripan:"tripan",tripanstart:"tripan",tripanmove:"tripan",tripanup:"tripan",tripandown:"tripan",tripanleft:"tripan",tripanright:"tripan",tripanend:"tripan",tripancancel:"tripan",pan:"pan",panstart:"pan",panmove:"pan",panup:"pan",pandown:"pan",panleft:"pan",panright:"pan",panend:"pan",pancancel:"pan",swipe:"swipe",swipeleft:"swipe",swiperight:"swipe",swipeup:"swipe",swipedown:"swipe"},u={click:"tap",anyclick:"anytap",dblclick:"doubletap",mousedown:"pointerdown",mousemove:"pointermove",mouseup:"pointerup",mouseover:"pointerover",mouseout:"pointerout",mouseleave:"pointerleave"},E="undefined"!=typeof navigator&&navigator.userAgent?navigator.userAgent.toLowerCase():"",m="undefined"!=typeof window?window:n.g;void 0!==n.g?n.g:window,"undefined"!=typeof document&&document;let b=!1;try{const e={get passive(){return b=!0,!0}};m.addEventListener("test",e,e),m.removeEventListener("test",e,e)}catch(e){}const g=-1!==E.indexOf("firefox"),{WHEEL_EVENTS:y}=v,f="wheel",w=4.000244140625;class _{constructor(e,t,n={}){this.element=e,this.callback=t,this.options=Object.assign({enable:!0},n),this.events=y.concat(n.events||[]),this.handleEvent=this.handleEvent.bind(this),this.events.forEach((t=>e.addEventListener(t,this.handleEvent,!!b&&{passive:!1})))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===f&&(this.options.enable=t)}handleEvent(e){if(!this.options.enable)return;let t=e.deltaY;m.WheelEvent&&(g&&e.deltaMode===m.WheelEvent.DOM_DELTA_PIXEL&&(t/=m.devicePixelRatio),e.deltaMode===m.WheelEvent.DOM_DELTA_LINE&&(t*=40));const n={x:e.clientX,y:e.clientY};0!==t&&t%w==0&&(t=Math.floor(t/w)),e.shiftKey&&t&&(t*=.25),this._onWheel(e,-t,n)}_onWheel(e,t,n){this.callback({type:f,center:n,delta:t,srcEvent:e,pointerType:"mouse",target:e.target})}}const{MOUSE_EVENTS:k}=v,O="pointermove",I="pointerover",T="pointerout",L="pointerleave";class x{constructor(e,t,n={}){this.element=e,this.callback=t,this.pressed=!1,this.options=Object.assign({enable:!0},n),this.enableMoveEvent=this.options.enable,this.enableLeaveEvent=this.options.enable,this.enableOutEvent=this.options.enable,this.enableOverEvent=this.options.enable,this.events=k.concat(n.events||[]),this.handleEvent=this.handleEvent.bind(this),this.events.forEach((t=>e.addEventListener(t,this.handleEvent)))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===O&&(this.enableMoveEvent=t),e===I&&(this.enableOverEvent=t),e===T&&(this.enableOutEvent=t),e===L&&(this.enableLeaveEvent=t)}handleEvent(e){this.handleOverEvent(e),this.handleOutEvent(e),this.handleLeaveEvent(e),this.handleMoveEvent(e)}handleOverEvent(e){this.enableOverEvent&&"mouseover"===e.type&&this.callback({type:I,srcEvent:e,pointerType:"mouse",target:e.target})}handleOutEvent(e){this.enableOutEvent&&"mouseout"===e.type&&this.callback({type:T,srcEvent:e,pointerType:"mouse",target:e.target})}handleLeaveEvent(e){this.enableLeaveEvent&&"mouseleave"===e.type&&this.callback({type:L,srcEvent:e,pointerType:"mouse",target:e.target})}handleMoveEvent(e){if(this.enableMoveEvent)switch(e.type){case"mousedown":e.button>=0&&(this.pressed=!0);break;case"mousemove":0===e.which&&(this.pressed=!1),this.pressed||this.callback({type:O,srcEvent:e,pointerType:"mouse",target:e.target});break;case"mouseup":this.pressed=!1}}}const{KEY_EVENTS:z}=v,M="keydown",N="keyup";class B{constructor(e,t,n={}){this.element=e,this.callback=t,this.options=Object.assign({enable:!0},n),this.enableDownEvent=this.options.enable,this.enableUpEvent=this.options.enable,this.events=z.concat(n.events||[]),this.handleEvent=this.handleEvent.bind(this),e.tabIndex=n.tabIndex||0,e.style.outline="none",this.events.forEach((t=>e.addEventListener(t,this.handleEvent)))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===M&&(this.enableDownEvent=t),e===N&&(this.enableUpEvent=t)}handleEvent(e){const t=e.target||e.srcElement;"INPUT"===t.tagName&&"text"===t.type||"TEXTAREA"===t.tagName||(this.enableDownEvent&&"keydown"===e.type&&this.callback({type:M,srcEvent:e,key:e.key,target:e.target}),this.enableUpEvent&&"keyup"===e.type&&this.callback({type:N,srcEvent:e,key:e.key,target:e.target}))}}const H="contextmenu";class P{constructor(e,t,n={}){this.element=e,this.callback=t,this.options=Object.assign({enable:!0},n),this.handleEvent=this.handleEvent.bind(this),e.addEventListener("contextmenu",this.handleEvent)}destroy(){this.element.removeEventListener("contextmenu",this.handleEvent)}enableEventType(e,t){e===H&&(this.options.enable=t)}handleEvent(e){this.options.enable&&this.callback({type:H,center:{x:e.clientX,y:e.clientY},srcEvent:e,pointerType:"mouse",target:e.target})}}const j={pointerdown:1,pointermove:2,pointerup:4,mousedown:1,mousemove:2,mouseup:4};const R={srcElement:"root",priority:0};class A{constructor(e){this.eventManager=e,this.handlers=[],this.handlersByElement=new Map,this.handleEvent=this.handleEvent.bind(this),this._active=!1}isEmpty(){return!this._active}add(e,t,n,s=!1,i=!1){const{handlers:o,handlersByElement:a}=this;n&&("object"!=typeof n||n.addEventListener)&&(n={srcElement:n}),n=n?Object.assign({},R,n):R;let r=a.get(n.srcElement);r||(r=[],a.set(n.srcElement,r));const h={type:e,handler:t,srcElement:n.srcElement,priority:n.priority};s&&(h.once=!0),i&&(h.passive=!0),o.push(h),this._active=this._active||!h.passive;let l=r.length-1;for(;l>=0&&!(r[l].priority>=h.priority);)l--;r.splice(l+1,0,h)}remove(e,t){const{handlers:n,handlersByElement:s}=this;for(let i=n.length-1;i>=0;i--){const o=n[i];if(o.type===e&&o.handler===t){n.splice(i,1);const e=s.get(o.srcElement);e.splice(e.indexOf(o),1),0===e.length&&s.delete(o.srcElement)}}this._active=n.some((e=>!e.passive))}handleEvent(e){if(this.isEmpty())return;const t=this._normalizeEvent(e);let n=e.srcEvent.target;for(;n&&n!==t.rootElement;){if(this._emit(t,n),t.handled)return;n=n.parentNode}this._emit(t,"root")}_emit(e,t){const n=this.handlersByElement.get(t);if(n){let t=!1;const s=()=>{e.handled=!0},i=()=>{e.handled=!0,t=!0},o=[];for(let a=0;a<n.length;a++){const{type:r,handler:h,once:l}=n[a];if(h(Object.assign({},e,{type:r,stopPropagation:s,stopImmediatePropagation:i})),l&&o.push(n[a]),t)break}for(let e=0;e<o.length;e++){const{type:t,handler:n}=o[e];this.remove(t,n)}}}_normalizeEvent(e){const t=this.eventManager.element;return Object.assign({},e,function(e){const t=j[e.srcEvent.type];if(!t)return null;const{buttons:n,button:s,which:i}=e.srcEvent;let o=!1,a=!1,r=!1;return 4===t||2===t&&!Number.isFinite(n)?(o=1===i,a=2===i,r=3===i):2===t?(o=Boolean(1&n),a=Boolean(4&n),r=Boolean(2&n)):1===t&&(o=0===s,a=1===s,r=2===s),{leftButton:o,middleButton:a,rightButton:r}}(e),function(e,t){const{srcEvent:n}=e;if(!e.center&&!Number.isFinite(n.clientX))return null;const s=e.center||{x:n.clientX,y:n.clientY},i=t.getBoundingClientRect(),o=i.width/t.offsetWidth||1,a=i.height/t.offsetHeight||1;return{center:s,offsetCenter:{x:(s.x-i.left-t.clientLeft)/o,y:(s.y-i.top-t.clientTop)/a}}}(e,t),{handled:!1,rootElement:t})}}const S={events:null,recognizers:null,recognizerOptions:{},Manager:a,touchAction:"none",tabIndex:0};class W{constructor(e=null,t={}){this.options=Object.assign({},S,t),this.events=new Map,this._onBasicInput=this._onBasicInput.bind(this),this._onOtherEvent=this._onOtherEvent.bind(this),this.setElement(e);const{events:n}=t;n&&this.on(n)}setElement(e){if(this.element&&this.destroy(),this.element=e,!e)return;const{options:t}=this,n=t.Manager;this.manager=new n(e,{touchAction:t.touchAction,recognizers:t.recognizers||h}).on("hammer.input",this._onBasicInput),t.recognizers||Object.keys(l).forEach((e=>{const t=this.manager.get(e);t&&l[e].forEach((e=>{t.recognizeWith(e)}))}));for(const e in t.recognizerOptions){const n=this.manager.get(e);if(n){const s=t.recognizerOptions[e];delete s.enable,n.set(s)}}this.wheelInput=new _(e,this._onOtherEvent,{enable:!1}),this.moveInput=new x(e,this._onOtherEvent,{enable:!1}),this.keyInput=new B(e,this._onOtherEvent,{enable:!1,tabIndex:t.tabIndex}),this.contextmenuInput=new P(e,this._onOtherEvent,{enable:!1});for(const[e,t]of this.events)t.isEmpty()||(this._toggleRecognizer(t.recognizerName,!0),this.manager.on(e,t.handleEvent))}destroy(){this.element&&(this.wheelInput.destroy(),this.moveInput.destroy(),this.keyInput.destroy(),this.contextmenuInput.destroy(),this.manager.destroy(),this.wheelInput=null,this.moveInput=null,this.keyInput=null,this.contextmenuInput=null,this.manager=null,this.element=null)}on(e,t,n){this._addEventHandler(e,t,n,!1)}once(e,t,n){this._addEventHandler(e,t,n,!0)}watch(e,t,n){this._addEventHandler(e,t,n,!1,!0)}off(e,t){this._removeEventHandler(e,t)}_toggleRecognizer(e,t){const{manager:n}=this;if(!n)return;const s=n.get(e);if(s&&s.options.enable!==t){s.set({enable:t});const i=p[e];i&&!this.options.recognizers&&i.forEach((i=>{const o=n.get(i);t?(o.requireFailure(e),s.dropRequireFailure(i)):o.dropRequireFailure(e)}))}this.wheelInput.enableEventType(e,t),this.moveInput.enableEventType(e,t),this.keyInput.enableEventType(e,t),this.contextmenuInput.enableEventType(e,t)}_addEventHandler(e,t,n,s,i){if("string"!=typeof e){n=t;for(const t in e)this._addEventHandler(t,e[t],n,s,i);return}const{manager:o,events:a}=this,r=u[e]||e;let h=a.get(r);h||(h=new A(this),a.set(r,h),h.recognizerName=d[r]||r,o&&o.on(r,h.handleEvent)),h.add(e,t,n,s,i),h.isEmpty()||this._toggleRecognizer(h.recognizerName,!0)}_removeEventHandler(e,t){if("string"!=typeof e){for(const t in e)this._removeEventHandler(t,e[t]);return}const{events:n}=this,s=u[e]||e,i=n.get(s);if(i&&(i.remove(e,t),i.isEmpty())){const{recognizerName:e}=i;let t=!1;for(const s of n.values())if(s.recognizerName===e&&!s.isEmpty()){t=!0;break}t||this._toggleRecognizer(e,!1)}}_onBasicInput(e){const{srcEvent:t}=e,n=c[t.type];n&&this.manager.emit(n,e)}_onOtherEvent(e){this.manager.emit(e.type,e)}}}}]);