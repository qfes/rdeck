"use strict";(self.webpackChunkrdeck=self.webpackChunkrdeck||[]).push([[811],{17:(t,e,o)=>{o.d(e,{D5:()=>C});var n=o(7294);const r=n.createContext(null);function s(t){return{longitude:t.center.lng,latitude:t.center.lat,zoom:t.zoom,pitch:t.pitch,bearing:t.bearing,padding:t.padding}}function i(t,e){const o=e.viewState||e;let n=!1;if("longitude"in o&&"latitude"in o){const e=t.center;t.center=new e.constructor(o.longitude,o.latitude),n=n||e!==t.center}if("zoom"in o){const e=t.zoom;t.zoom=o.zoom,n=n||e!==t.zoom}if("bearing"in o){const e=t.bearing;t.bearing=o.bearing,n=n||e!==t.bearing}if("pitch"in o){const e=t.pitch;t.pitch=o.pitch,n=n||e!==t.pitch}return o.padding&&!t.isPaddingEqual(o.padding)&&(n=!0,t.padding=o.padding),n}const a=["type","source","source-layer","minzoom","maxzoom","filter","layout"];function c(t){if(!t)return null;if("string"==typeof t)return t;if("toJS"in t&&(t=t.toJS()),!t.layers)return t;const e={};for(const o of t.layers)e[o.id]=o;const o=t.layers.map((t=>{const o=e[t.ref];let n=null;if("interactive"in t&&(n={...t},delete n.interactive),o){n=n||{...t},delete n.ref;for(const t of a)t in o&&(n[t]=o[t])}return n||t}));return{...t,layers:o}}function l(t,e){if(t===e)return!0;if(!t||!e)return!1;if(Array.isArray(t)){if(!Array.isArray(e)||t.length!==e.length)return!1;for(let o=0;o<t.length;o++)if(!l(t[o],e[o]))return!1;return!0}if(Array.isArray(e))return!1;if("object"==typeof t&&"object"==typeof e){const o=Object.keys(t),n=Object.keys(e);if(o.length!==n.length)return!1;for(const n of o){if(!e.hasOwnProperty(n))return!1;if(!l(t[n],e[n]))return!1}return!0}return!1}const u={mousedown:"onMouseDown",mouseup:"onMouseUp",mouseover:"onMouseOver",mousemove:"onMouseMove",click:"onClick",dblclick:"onDblClick",mouseenter:"onMouseEnter",mouseleave:"onMouseLeave",mouseout:"onMouseOut",contextmenu:"onContextMenu",touchstart:"onTouchStart",touchend:"onTouchEnd",touchmove:"onTouchMove",touchcancel:"onTouchCancel"},p={movestart:"onMoveStart",move:"onMove",moveend:"onMoveEnd",dragstart:"onDragStart",drag:"onDrag",dragend:"onDragEnd",zoomstart:"onZoomStart",zoom:"onZoom",zoomend:"onZoomEnd",rotatestart:"onRotateStart",rotate:"onRotate",rotateend:"onRotateEnd",pitchstart:"onPitchStart",pitch:"onPitch",pitchend:"onPitchEnd"},d={wheel:"onWheel",boxzoomstart:"onBoxZoomStart",boxzoomend:"onBoxZoomEnd",boxzoomcancel:"onBoxZoomCancel",resize:"onResize",load:"onLoad",render:"onRender",idle:"onIdle",remove:"onRemove",data:"onData",styledata:"onStyleData",sourcedata:"onSourceData",error:"onError"},m=["minZoom","maxZoom","minPitch","maxPitch","maxBounds","projection","renderWorldCopies"],f=["scrollZoom","boxZoom","dragRotate","dragPan","keyboard","doubleClickZoom","touchZoomRotate","touchPitch"];class h{constructor(t,e,o){this._map=null,this._internalUpdate=!1,this._inRender=!1,this._hoveredFeatures=null,this._deferredEvents={move:!1,zoom:!1,pitch:!1,rotate:!1},this._onEvent=t=>{const e=this.props[d[t.type]];e&&e(t)},this._onPointerEvent=t=>{"mousemove"!==t.type&&"mouseout"!==t.type||this._updateHover(t);const e=this.props[u[t.type]];if(e){if(this.props.interactiveLayerIds&&"mouseover"!==t.type&&"mouseout"!==t.type){const e=this._hoveredFeatures||this._map.queryRenderedFeatures(t.point,{layers:this.props.interactiveLayerIds});if(!e.length)return;t.features=e}e(t),delete t.features}},this._onCameraEvent=t=>{if(!this._internalUpdate){const e=this.props[p[t.type]];e&&e(t)}t.type in this._deferredEvents&&(this._deferredEvents[t.type]=!1)},this._MapClass=t,this.props=e,this._initialize(o)}get map(){return this._map}get transform(){return this._renderTransform}setProps(t){const e=this.props;this.props=t;const o=this._updateSettings(t,e);o&&(this._renderTransform=this._map.transform.clone());const n=this._updateSize(t),r=this._updateViewState(t,!0);this._updateStyle(t,e),this._updateStyleComponents(t,e),this._updateHandlers(t,e),(o||n||r&&!this._map.isMoving())&&this.redraw()}static reuse(t,e){const o=h.savedMaps.pop();if(!o)return null;const n=o.map,r=n.getContainer();for(e.className=r.className;r.childNodes.length>0;)e.appendChild(r.childNodes[0]);return n._container=e,t.initialViewState&&o._updateViewState(t.initialViewState,!1),n.resize(),o.setProps({...t,styleDiffing:!1}),n.isStyleLoaded()?n.fire("load"):n.once("styledata",(()=>n.fire("load"))),o}_initialize(t){const{props:e}=this,o={...e,...e.initialViewState,accessToken:e.mapboxAccessToken||g()||null,container:t,style:c(e.mapStyle)},n=o.initialViewState||o.viewState||o;if(Object.assign(o,{center:[n.longitude||0,n.latitude||0],zoom:n.zoom||0,pitch:n.pitch||0,bearing:n.bearing||0}),e.gl){const t=HTMLCanvasElement.prototype.getContext;HTMLCanvasElement.prototype.getContext=()=>(HTMLCanvasElement.prototype.getContext=t,e.gl)}const r=new this._MapClass(o);n.padding&&r.setPadding(n.padding),e.cursor&&(r.getCanvas().style.cursor=e.cursor),this._renderTransform=r.transform.clone();const s=r._render;r._render=t=>{this._inRender=!0,s.call(r,t),this._inRender=!1};const i=r._renderTaskQueue.run;r._renderTaskQueue.run=t=>{i.call(r._renderTaskQueue,t),this._onBeforeRepaint()},r.on("render",(()=>this._onAfterRepaint()));const a=r.fire;r.fire=this._fireEvent.bind(this,a),r.on("resize",(()=>{this._renderTransform.resize(r.transform.width,r.transform.height)})),r.on("styledata",(()=>this._updateStyleComponents(this.props,{}))),r.on("sourcedata",(()=>this._updateStyleComponents(this.props,{})));for(const t in u)r.on(t,this._onPointerEvent);for(const t in p)r.on(t,this._onCameraEvent);for(const t in d)r.on(t,this._onEvent);this._map=r}recycle(){h.savedMaps.push(this)}destroy(){this._map.remove()}redraw(){const t=this._map;!this._inRender&&t.style&&(t._frame&&(t._frame.cancel(),t._frame=null),t._render())}_updateSize(t){const{viewState:e}=t;if(e){const t=this._map;if(e.width!==t.transform.width||e.height!==t.transform.height)return t.resize(),!0}return!1}_updateViewState(t,e){if(this._internalUpdate)return!1;const o=this._map,n=this._renderTransform,{zoom:r,pitch:a,bearing:c}=n,l=i(n,{...s(o.transform),...t});if(l&&e){const t=this._deferredEvents;t.move=!0,t.zoom||(t.zoom=r!==n.zoom),t.rotate||(t.rotate=c!==n.bearing),t.pitch||(t.pitch=a!==n.pitch)}return o.isMoving()||i(o.transform,t),l}_updateSettings(t,e){const o=this._map;let n=!1;for(const r of m)r in t&&!l(t[r],e[r])&&(n=!0,o[`set${r[0].toUpperCase()}${r.slice(1)}`](t[r]));return n}_updateStyle(t,e){if(t.cursor!==e.cursor&&(this._map.getCanvas().style.cursor=t.cursor),t.mapStyle!==e.mapStyle){const e={diff:t.styleDiffing};return"localIdeographFontFamily"in t&&(e.localIdeographFontFamily=t.localIdeographFontFamily),this._map.setStyle(c(t.mapStyle),e),!0}return!1}_updateStyleComponents(t,e){const o=this._map;let n=!1;return o.style.loaded()&&("light"in t&&!l(t.light,e.light)&&(n=!0,o.setLight(t.light)),"fog"in t&&!l(t.fog,e.fog)&&(n=!0,o.setFog(t.fog)),"terrain"in t&&!l(t.terrain,e.terrain)&&(t.terrain&&!o.getSource(t.terrain.source)||(n=!0,o.setTerrain(t.terrain),this._renderTransform.elevation=o.transform.elevation))),n}_updateHandlers(t,e){const o=this._map;let n=!1;for(const r of f){const s=t[r];l(s,e[r])||(n=!0,s?o[r].enable(s):o[r].disable())}return n}_updateHover(t){const{props:e}=this;if(e.interactiveLayerIds&&(e.onMouseMove||e.onMouseEnter||e.onMouseLeave)){const o=t.type,n=this._hoveredFeatures?.length>0;let r;if("mousemove"===o)try{r=this._map.queryRenderedFeatures(t.point,{layers:e.interactiveLayerIds})}catch{r=[]}else r=[];const s=r.length>0;!s&&n&&(t.type="mouseleave",this._onPointerEvent(t)),this._hoveredFeatures=r,s&&!n&&(t.type="mouseenter",this._onPointerEvent(t)),t.type=o}else this._hoveredFeatures=null}_fireEvent(t,e,o){const n=this._map,r=n.transform,i="string"==typeof e?e:e.type;return"move"===i&&this._updateViewState(this.props,!1),i in p&&("object"==typeof e&&(e.viewState=s(r)),this._map.isMoving())?(n.transform=this._renderTransform,t.call(n,e,o),n.transform=r,n):(t.call(n,e,o),n)}_onBeforeRepaint(){const t=this._map;this._internalUpdate=!0;for(const e in this._deferredEvents)this._deferredEvents[e]&&t.fire(e);this._internalUpdate=!1;const e=this._map.transform;this._map.transform=this._renderTransform,this._onAfterRepaint=()=>{this._map.transform=e}}}function g(){let t=null;if("undefined"!=typeof location){const e=/access_token=([^&\/]*)/.exec(location.search);t=e&&e[1]}try{t=t||process.env.MapboxAccessToken}catch{}try{t=t||process.env.REACT_APP_MAPBOX_ACCESS_TOKEN}catch{}return t}h.savedMaps=[];const y=["setMaxBounds","setMinZoom","setMaxZoom","setMinPitch","setMaxPitch","setRenderWorldCopies","setProjection","setStyle","addSource","removeSource","addLayer","removeLayer","setLayerZoomRange","setFilter","setPaintProperty","setLayoutProperty","setLight","setTerrain","setFog","remove"];function _(t,e){if(!t)return null;const o=t.map,n={getMap:()=>o,getCenter:()=>t.transform.center,getZoom:()=>t.transform.zoom,getBearing:()=>t.transform.bearing,getPitch:()=>t.transform.pitch,getPadding:()=>t.transform.padding,getBounds:()=>t.transform.getBounds(),project:o=>t.transform.locationPoint(e.LngLat.convert(o)),unproject:o=>t.transform.pointLocation(e.Point.convert(o))};for(const t of function(t){const e=new Set;let o=t;for(;o;){for(const n of Object.getOwnPropertyNames(o))"_"!==n[0]&&"function"==typeof t[n]&&"fire"!==n&&"setEventedParent"!==n&&e.add(n);o=Object.getPrototypeOf(o)}return Array.from(e)}(o))t in n||y.includes(t)||(n[t]=o[t].bind(o));return n}const v="undefined"!=typeof document?n.useLayoutEffect:n.useEffect,b=["baseApiUrl","maxParallelImageRequests","workerClass","workerCount","workerUrl"];const E=n.createContext(null),L={minZoom:0,maxZoom:22,minPitch:0,maxPitch:60,scrollZoom:!0,boxZoom:!0,dragRotate:!0,dragPan:!0,keyboard:!0,doubleClickZoom:!0,touchZoomRotate:!0,touchPitch:!0,mapStyle:{version:8,sources:{},layers:[]},styleDiffing:!0,projection:"mercator",renderWorldCopies:!0,onError:t=>console.error(t.error),RTLTextPlugin:"https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-rtl-text/v0.2.3/mapbox-gl-rtl-text.js"},x=(0,n.forwardRef)(((t,e)=>{const s=(0,n.useContext)(r),[i,a]=(0,n.useState)(null),c=(0,n.useRef)(),{current:l}=(0,n.useRef)({mapLib:null,map:null});(0,n.useEffect)((()=>{const e=t.mapLib;let n,r=!0;return Promise.resolve(e||Promise.resolve().then(o.t.bind(o,6158,23))).then((e=>{if(r){if(e.Map||(e=e.default),!e||!e.Map)throw new Error("Invalid mapLib");if(!e.supported(t))throw new Error("Map is not supported by this browser");!function(t,e){for(const o of b)o in e&&(t[o]=e[o]);e.RTLTextPlugin&&t.getRTLTextPluginStatus&&"unavailable"===t.getRTLTextPluginStatus()&&t.setRTLTextPlugin(e.RTLTextPlugin,(t=>{t&&console.error(t)}),!1)}(e,t),t.reuseMaps&&(n=h.reuse(t,c.current)),n||(n=new h(e.Map,t,c.current)),l.map=_(n,e),l.mapLib=e,a(n),s?.onMapMount(l.map,t.id)}})).catch((e=>{t.onError({type:"error",target:null,originalEvent:null,error:e})})),()=>{r=!1,n&&(s?.onMapUnmount(t.id),t.reuseMaps?n.recycle():n.destroy())}}),[]),v((()=>{i&&i.setProps(t)})),(0,n.useImperativeHandle)(e,(()=>l.map),[i]);const u=(0,n.useMemo)((()=>({position:"relative",width:"100%",height:"100%",...t.style})),[t.style]);return n.createElement("div",{id:t.id,ref:c,style:u},i&&n.createElement(E.Provider,{value:l},t.children))}));x.displayName="Map",x.defaultProps=L;const C=x;var M=o(3935);const P=/box|flex|grid|column|lineHeight|fontWeight|opacity|order|tabSize|zIndex/;function S(t,e){if(!t||!e)return;const o=t.style;for(const t in e){const n=e[t];Number.isFinite(n)&&!P.test(t)?o[t]=`${n}px`:o[t]=n}}function w(t){const{map:e,mapLib:o}=(0,n.useContext)(E),r=(0,n.useRef)({props:t});r.current.props=t;const s=(0,n.useMemo)((()=>{let e=!1;n.Children.forEach(t.children,(t=>{t&&(e=!0)}));const i={...t,element:e?document.createElement("div"):null},a=new o.Marker(i).setLngLat([t.longitude,t.latitude]);return a.getElement().addEventListener("click",(t=>{r.current.props.onClick?.({type:"click",target:a,originalEvent:t})})),a.on("dragstart",(t=>{const e=t;e.lngLat=s.getLngLat(),r.current.props.onDragStart?.(e)})),a.on("drag",(t=>{const e=t;e.lngLat=s.getLngLat(),r.current.props.onDrag?.(e)})),a.on("dragend",(t=>{const e=t;e.lngLat=s.getLngLat(),r.current.props.onDragEnd?.(e)})),a}),[]);return(0,n.useEffect)((()=>(s.addTo(e.getMap()),()=>{s.remove()})),[]),(0,n.useEffect)((()=>{S(s.getElement(),t.style)}),[t.style]),s.getLngLat().lng===t.longitude&&s.getLngLat().lat===t.latitude||s.setLngLat([t.longitude,t.latitude]),t.offset&&!function(t,e){const o=Array.isArray(t)?t[0]:t?t.x:0,n=Array.isArray(t)?t[1]:t?t.y:0,r=Array.isArray(e)?e[0]:e?e.x:0,s=Array.isArray(e)?e[1]:e?e.y:0;return o===r&&n===s}(s.getOffset(),t.offset)&&s.setOffset(t.offset),s.isDraggable()!==t.draggable&&s.setDraggable(t.draggable),s.getRotation()!==t.rotation&&s.setRotation(t.rotation),s.getRotationAlignment()!==t.rotationAlignment&&s.setRotationAlignment(t.rotationAlignment),s.getPitchAlignment()!==t.pitchAlignment&&s.setPitchAlignment(t.pitchAlignment),s.getPopup()!==t.popup&&s.setPopup(t.popup),(0,M.createPortal)(t.children,s.getElement())}w.defaultProps={draggable:!1,popup:null,rotation:0,rotationAlignment:"auto",pitchAlignment:"auto"};n.memo(w);function R(t){return new Set(t?t.trim().split(/\s+/):[])}n.memo((function(t){const{map:e,mapLib:o}=(0,n.useContext)(E),r=(0,n.useMemo)((()=>document.createElement("div")),[]),s=(0,n.useRef)({props:t});s.current.props=t;const i=(0,n.useMemo)((()=>{const e={...t},n=new o.Popup(e).setLngLat([t.longitude,t.latitude]);return n.on("open",(t=>{s.current.props.onOpen?.(t)})),n.on("close",(t=>{s.current.props.onClose?.(t)})),n}),[]);if((0,n.useEffect)((()=>(i.setDOMContent(r).addTo(e.getMap()),()=>{i.isOpen()&&i.remove()})),[]),(0,n.useEffect)((()=>{S(i.getElement(),t.style)}),[t.style]),i.isOpen()&&(i.getLngLat().lng===t.longitude&&i.getLngLat().lat===t.latitude||i.setLngLat([t.longitude,t.latitude]),t.offset&&!l(i.options.offset,t.offset)&&i.setOffset(t.offset),i.options.anchor===t.anchor&&i.options.maxWidth===t.maxWidth||(i.options.anchor=t.anchor,i.setMaxWidth(t.maxWidth)),i.options.className!==t.className)){const e=R(i.options.className),o=R(t.className);for(const t of e)o.has(t)||i.removeClassName(t);for(const t of o)e.has(t)||i.addClassName(t);i.options.className=t.className}return(0,M.createPortal)(t.children,r)}));function T(t,e,o){const r=(0,n.useContext)(E),s=(0,n.useMemo)((()=>t(r)),[]);return(0,n.useEffect)((()=>{const{map:t}=r;return t.hasControl(s)||t.addControl(s,(o||e)?.position),()=>{"function"==typeof e&&e(r),t.hasControl(s)&&t.removeControl(s)}}),[]),s}n.memo((function(t){const e=T((({mapLib:e})=>new e.AttributionControl(t)),{position:t.position});return(0,n.useEffect)((()=>{S(e._container,t.style)}),[t.style]),null}));n.memo((function(t){const e=T((({mapLib:e})=>new e.FullscreenControl({container:t.containerId&&document.getElementById(t.containerId)})),{position:t.position});return(0,n.useEffect)((()=>{S(e._controlContainer,t.style)}),[t.style]),null}));const z=(0,n.forwardRef)(((t,e)=>{const o=(0,n.useRef)({props:t}),r=T((({mapLib:e})=>{const n=new e.GeolocateControl(t);return n.on("geolocate",(t=>{o.current.props.onGeolocate?.(t)})),n.on("error",(t=>{o.current.props.onError?.(t)})),n.on("outofmaxbounds",(t=>{o.current.props.onOutOfMaxBounds?.(t)})),n.on("trackuserlocationstart",(t=>{o.current.props.onTrackUserLocationStart?.(t)})),n.on("trackuserlocationend",(t=>{o.current.props.onTrackUserLocationEnd?.(t)})),n}),{position:t.position});return o.current.props=t,(0,n.useImperativeHandle)(e,(()=>({trigger:()=>r.trigger()})),[]),(0,n.useEffect)((()=>{S(r._container,t.style)}),[t.style]),null}));z.displayName="GeolocateControl";n.memo(z);n.memo((function(t){const e=T((({mapLib:e})=>new e.NavigationControl(t)),{position:t.position});return(0,n.useEffect)((()=>{S(e._container,t.style)}),[t.style]),null}));function A(t){const e=T((({mapLib:e})=>new e.ScaleControl(t)),{position:t.position});return e.options.unit===t.unit&&e.options.maxWidth===t.maxWidth||(e.options.maxWidth=t.maxWidth,e.setUnit(t.unit)),(0,n.useEffect)((()=>{S(e._container,t.style)}),[t.style]),null}A.defaultProps={unit:"metric",maxWidth:100};n.memo(A)}}]);