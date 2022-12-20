"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[134],{3391:(e,t,n)=>{n.d(t,{Q:()=>C});var s=n(1272),o=n.n(s);const i={mousedown:1,mousemove:2,mouseup:4};!function(e){const t=e.prototype.handler;e.prototype.handler=function(e){const n=this.store;e.button>0&&"pointerdown"===e.type&&(function(e,t){for(let n=0;n<e.length;n++)if(t(e[n]))return!0;return!1}(n,(t=>t.pointerId===e.pointerId))||n.push(e)),t.call(this,e)}}(o().PointerEventInput),o().MouseInput.prototype.handler=function(e){let t=i[e.type];1&t&&e.button>=0&&(this.pressed=!0),2&t&&0===e.which&&(t=4),this.pressed&&(4&t&&(this.pressed=!1),this.callback(this.manager,t,{pointers:[e],changedPointers:[e],pointerType:"mouse",srcEvent:e}))};const r=o().Manager,a=o();class p{constructor(e,t,n){this.element=e,this.callback=t,this.options={enable:!0,...n}}}const h=a?[[a.Pan,{event:"tripan",pointers:3,threshold:0,enable:!1}],[a.Rotate,{enable:!1}],[a.Pinch,{enable:!1}],[a.Swipe,{enable:!1}],[a.Pan,{threshold:0,enable:!1}],[a.Press,{enable:!1}],[a.Tap,{event:"doubletap",taps:2,enable:!1}],[a.Tap,{event:"anytap",enable:!1}],[a.Tap,{enable:!1}]]:null,l={tripan:["rotate","pinch","pan"],rotate:["pinch"],pinch:["pan"],pan:["press","doubletap","anytap","tap"],doubletap:["anytap"],anytap:["tap"]},c={doubletap:["tap"]},v={pointerdown:"pointerdown",pointermove:"pointermove",pointerup:"pointerup",touchstart:"pointerdown",touchmove:"pointermove",touchend:"pointerup",mousedown:"pointerdown",mousemove:"pointermove",mouseup:"pointerup"},u={KEY_EVENTS:["keydown","keyup"],MOUSE_EVENTS:["mousedown","mousemove","mouseup","mouseover","mouseout","mouseleave"],WHEEL_EVENTS:["wheel","mousewheel"]},d={tap:"tap",anytap:"anytap",doubletap:"doubletap",press:"press",pinch:"pinch",pinchin:"pinch",pinchout:"pinch",pinchstart:"pinch",pinchmove:"pinch",pinchend:"pinch",pinchcancel:"pinch",rotate:"rotate",rotatestart:"rotate",rotatemove:"rotate",rotateend:"rotate",rotatecancel:"rotate",tripan:"tripan",tripanstart:"tripan",tripanmove:"tripan",tripanup:"tripan",tripandown:"tripan",tripanleft:"tripan",tripanright:"tripan",tripanend:"tripan",tripancancel:"tripan",pan:"pan",panstart:"pan",panmove:"pan",panup:"pan",pandown:"pan",panleft:"pan",panright:"pan",panend:"pan",pancancel:"pan",swipe:"swipe",swipeleft:"swipe",swiperight:"swipe",swipeup:"swipe",swipedown:"swipe"},E={click:"tap",anyclick:"anytap",dblclick:"doubletap",mousedown:"pointerdown",mousemove:"pointermove",mouseup:"pointerup",mouseover:"pointerover",mouseout:"pointerout",mouseleave:"pointerleave"},m="undefined"!=typeof navigator&&navigator.userAgent?navigator.userAgent.toLowerCase():"",y="undefined"!=typeof window?window:n.g;void 0!==n.g?n.g:window,"undefined"!=typeof document&&document;let g=!1;try{const e={get passive(){return g=!0,!0}};y.addEventListener("test",null,e),y.removeEventListener("test",null)}catch(e){g=!1}const b=-1!==m.indexOf("firefox"),{WHEEL_EVENTS:f}=u,w="wheel",_=4.000244140625;class k extends p{constructor(e,t,n){super(e,t,n),this.handleEvent=e=>{if(!this.options.enable)return;let t=e.deltaY;y.WheelEvent&&(b&&e.deltaMode===y.WheelEvent.DOM_DELTA_PIXEL&&(t/=y.devicePixelRatio),e.deltaMode===y.WheelEvent.DOM_DELTA_LINE&&(t*=40)),0!==t&&t%_==0&&(t=Math.floor(t/_)),e.shiftKey&&t&&(t*=.25),this.callback({type:w,center:{x:e.clientX,y:e.clientY},delta:-t,srcEvent:e,pointerType:"mouse",target:e.target})},this.events=(this.options.events||[]).concat(f),this.events.forEach((t=>e.addEventListener(t,this.handleEvent,!!g&&{passive:!1})))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===w&&(this.options.enable=t)}}const{MOUSE_EVENTS:I}=u,T="pointermove",x="pointerover",O="pointerout",L="pointerenter",z="pointerleave";class M extends p{constructor(e,t,n){super(e,t,n),this.handleEvent=e=>{this.handleOverEvent(e),this.handleOutEvent(e),this.handleEnterEvent(e),this.handleLeaveEvent(e),this.handleMoveEvent(e)},this.pressed=!1;const{enable:s}=this.options;this.enableMoveEvent=s,this.enableLeaveEvent=s,this.enableEnterEvent=s,this.enableOutEvent=s,this.enableOverEvent=s,this.events=(this.options.events||[]).concat(I),this.events.forEach((t=>e.addEventListener(t,this.handleEvent)))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===T&&(this.enableMoveEvent=t),e===x&&(this.enableOverEvent=t),e===O&&(this.enableOutEvent=t),e===L&&(this.enableEnterEvent=t),e===z&&(this.enableLeaveEvent=t)}handleOverEvent(e){this.enableOverEvent&&"mouseover"===e.type&&this._emit(x,e)}handleOutEvent(e){this.enableOutEvent&&"mouseout"===e.type&&this._emit(O,e)}handleEnterEvent(e){this.enableEnterEvent&&"mouseenter"===e.type&&this._emit(L,e)}handleLeaveEvent(e){this.enableLeaveEvent&&"mouseleave"===e.type&&this._emit(z,e)}handleMoveEvent(e){if(this.enableMoveEvent)switch(e.type){case"mousedown":e.button>=0&&(this.pressed=!0);break;case"mousemove":0===e.which&&(this.pressed=!1),this.pressed||this._emit(T,e);break;case"mouseup":this.pressed=!1}}_emit(e,t){this.callback({type:e,center:{x:t.clientX,y:t.clientY},srcEvent:t,pointerType:"mouse",target:t.target})}}const{KEY_EVENTS:N}=u,B="keydown",P="keyup";class H extends p{constructor(e,t,n){super(e,t,n),this.handleEvent=e=>{const t=e.target||e.srcElement;"INPUT"===t.tagName&&"text"===t.type||"TEXTAREA"===t.tagName||(this.enableDownEvent&&"keydown"===e.type&&this.callback({type:B,srcEvent:e,key:e.key,target:e.target}),this.enableUpEvent&&"keyup"===e.type&&this.callback({type:P,srcEvent:e,key:e.key,target:e.target}))},this.enableDownEvent=this.options.enable,this.enableUpEvent=this.options.enable,this.events=(this.options.events||[]).concat(N),e.tabIndex=this.options.tabIndex||0,e.style.outline="none",this.events.forEach((t=>e.addEventListener(t,this.handleEvent)))}destroy(){this.events.forEach((e=>this.element.removeEventListener(e,this.handleEvent)))}enableEventType(e,t){e===B&&(this.enableDownEvent=t),e===P&&(this.enableUpEvent=t)}}const R="contextmenu";class A extends p{constructor(e,t,n){super(e,t,n),this.handleEvent=e=>{this.options.enable&&this.callback({type:R,center:{x:e.clientX,y:e.clientY},srcEvent:e,pointerType:"mouse",target:e.target})},e.addEventListener("contextmenu",this.handleEvent)}destroy(){this.element.removeEventListener("contextmenu",this.handleEvent)}enableEventType(e,t){e===R&&(this.options.enable=t)}}const D={pointerdown:1,pointermove:2,pointerup:4,mousedown:1,mousemove:2,mouseup:4};function S(e){const t=D[e.srcEvent.type];if(!t)return null;const{buttons:n,button:s,which:o}=e.srcEvent;let i=!1,r=!1,a=!1;return 4===t||2===t&&!Number.isFinite(n)?(i=1===o,r=2===o,a=3===o):2===t?(i=Boolean(1&n),r=Boolean(4&n),a=Boolean(2&n)):1===t&&(i=0===s,r=1===s,a=2===s),{leftButton:i,middleButton:r,rightButton:a}}function W(e,t){const n=e.center;if(!n)return null;const s=t.getBoundingClientRect(),o=s.width/t.offsetWidth||1,i=s.height/t.offsetHeight||1;return{center:n,offsetCenter:{x:(n.x-s.left-t.clientLeft)/o,y:(n.y-s.top-t.clientTop)/i}}}const U={srcElement:"root",priority:0};class V{constructor(e){this.handleEvent=e=>{if(this.isEmpty())return;const t=this._normalizeEvent(e);let n=e.srcEvent.target;for(;n&&n!==t.rootElement;){if(this._emit(t,n),t.handled)return;n=n.parentNode}this._emit(t,"root")},this.eventManager=e,this.handlers=[],this.handlersByElement=new Map,this._active=!1}isEmpty(){return!this._active}add(e,t,n,s=!1,o=!1){const{handlers:i,handlersByElement:r}=this;let a=U;"string"==typeof n||n&&n.addEventListener?a={...U,srcElement:n}:n&&(a={...U,...n});let p=r.get(a.srcElement);p||(p=[],r.set(a.srcElement,p));const h={type:e,handler:t,srcElement:a.srcElement,priority:a.priority};s&&(h.once=!0),o&&(h.passive=!0),i.push(h),this._active=this._active||!h.passive;let l=p.length-1;for(;l>=0&&!(p[l].priority>=h.priority);)l--;p.splice(l+1,0,h)}remove(e,t){const{handlers:n,handlersByElement:s}=this;for(let o=n.length-1;o>=0;o--){const i=n[o];if(i.type===e&&i.handler===t){n.splice(o,1);const e=s.get(i.srcElement);e.splice(e.indexOf(i),1),0===e.length&&s.delete(i.srcElement)}}this._active=n.some((e=>!e.passive))}_emit(e,t){const n=this.handlersByElement.get(t);if(n){let t=!1;const s=()=>{e.handled=!0},o=()=>{e.handled=!0,t=!0},i=[];for(let r=0;r<n.length;r++){const{type:a,handler:p,once:h}=n[r];if(p({...e,type:a,stopPropagation:s,stopImmediatePropagation:o}),h&&i.push(n[r]),t)break}for(let e=0;e<i.length;e++){const{type:t,handler:n}=i[e];this.remove(t,n)}}}_normalizeEvent(e){const t=this.eventManager.getElement();return{...e,...S(e),...W(e,t),preventDefault:()=>{e.srcEvent.preventDefault()},stopImmediatePropagation:null,stopPropagation:null,handled:!1,rootElement:t}}}const Y={events:null,recognizers:null,recognizerOptions:{},Manager:r,touchAction:"none",tabIndex:0};class C{constructor(e=null,t){this._onBasicInput=e=>{const{srcEvent:t}=e,n=v[t.type];n&&this.manager.emit(n,e)},this._onOtherEvent=e=>{this.manager.emit(e.type,e)},this.options={...Y,...t},this.events=new Map,this.setElement(e);const{events:n}=this.options;n&&this.on(n)}getElement(){return this.element}setElement(e){if(this.element&&this.destroy(),this.element=e,!e)return;const{options:t}=this,n=t.Manager;this.manager=new n(e,{touchAction:t.touchAction,recognizers:t.recognizers||h}).on("hammer.input",this._onBasicInput),t.recognizers||Object.keys(l).forEach((e=>{const t=this.manager.get(e);t&&l[e].forEach((e=>{t.recognizeWith(e)}))}));for(const e in t.recognizerOptions){const n=this.manager.get(e);if(n){const s=t.recognizerOptions[e];delete s.enable,n.set(s)}}this.wheelInput=new k(e,this._onOtherEvent,{enable:!1}),this.moveInput=new M(e,this._onOtherEvent,{enable:!1}),this.keyInput=new H(e,this._onOtherEvent,{enable:!1,tabIndex:t.tabIndex}),this.contextmenuInput=new A(e,this._onOtherEvent,{enable:!1});for(const[e,t]of this.events)t.isEmpty()||(this._toggleRecognizer(t.recognizerName,!0),this.manager.on(e,t.handleEvent))}destroy(){this.element&&(this.wheelInput.destroy(),this.moveInput.destroy(),this.keyInput.destroy(),this.contextmenuInput.destroy(),this.manager.destroy(),this.wheelInput=null,this.moveInput=null,this.keyInput=null,this.contextmenuInput=null,this.manager=null,this.element=null)}on(e,t,n){this._addEventHandler(e,t,n,!1)}once(e,t,n){this._addEventHandler(e,t,n,!0)}watch(e,t,n){this._addEventHandler(e,t,n,!1,!0)}off(e,t){this._removeEventHandler(e,t)}_toggleRecognizer(e,t){const{manager:n}=this;if(!n)return;const s=n.get(e);if(s&&s.options.enable!==t){s.set({enable:t});const o=c[e];o&&!this.options.recognizers&&o.forEach((o=>{const i=n.get(o);t?(i.requireFailure(e),s.dropRequireFailure(o)):i.dropRequireFailure(e)}))}this.wheelInput.enableEventType(e,t),this.moveInput.enableEventType(e,t),this.keyInput.enableEventType(e,t),this.contextmenuInput.enableEventType(e,t)}_addEventHandler(e,t,n,s,o){if("string"!=typeof e){n=t;for(const t in e)this._addEventHandler(t,e[t],n,s,o);return}const{manager:i,events:r}=this,a=E[e]||e;let p=r.get(a);p||(p=new V(this),r.set(a,p),p.recognizerName=d[a]||a,i&&i.on(a,p.handleEvent)),p.add(e,t,n,s,o),p.isEmpty()||this._toggleRecognizer(p.recognizerName,!0)}_removeEventHandler(e,t){if("string"!=typeof e){for(const t in e)this._removeEventHandler(t,e[t]);return}const{events:n}=this,s=E[e]||e,o=n.get(s);if(o&&(o.remove(e,t),o.isEmpty())){const{recognizerName:e}=o;let t=!1;for(const s of n.values())if(s.recognizerName===e&&!s.isEmpty()){t=!0;break}t||this._toggleRecognizer(e,!1)}}}}}]);