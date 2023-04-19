"use strict";(()=>{var W=Object.create;var H=Object.defineProperty;var k=Object.getOwnPropertyDescriptor;var C=Object.getOwnPropertyNames;var N=Object.getPrototypeOf,j=Object.prototype.hasOwnProperty;var d=(e=>typeof require<"u"?require:typeof Proxy<"u"?new Proxy(e,{get:(t,r)=>(typeof require<"u"?require:t)[r]}):e)(function(e){if(typeof require<"u")return require.apply(this,arguments);throw new Error('Dynamic require of "'+e+'" is not supported')});var F=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var L=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let s of C(t))!j.call(e,s)&&s!==r&&H(e,s,{get:()=>t[s],enumerable:!(n=k(t,s))||n.enumerable});return e};var I=(e,t,r)=>(r=e!=null?W(N(e)):{},L(t||!e||!e.__esModule?H(r,"default",{value:e,enumerable:!0}):r,e));var O=F((me,f)=>{var T={};T.__wbindgen_placeholder__=f.exports;var c,{TextDecoder:G}=d("util"),M=new G("utf-8",{ignoreBOM:!0,fatal:!0});M.decode();var p=null;function x(){return(p===null||p.buffer!==c.memory.buffer)&&(p=new Uint8Array(c.memory.buffer)),p}function J(e,t){return M.decode(x().subarray(e,e+t))}var g=0;function q(e,t){let r=t(e.length*1);return x().set(e,r/1),g=e.length,r}var u=class{static __wrap(t){let r=Object.create(u.prototype);return r.ptr=t,r}__destroy_into_raw(){let t=this.ptr;return this.ptr=0,t}free(){let t=this.__destroy_into_raw();c.__wbg_hasher_free(t)}constructor(){var t=c.hasher_new();return u.__wrap(t)}update(t){var r=q(t,c.__wbindgen_malloc),n=g;c.hasher_update(this.ptr,r,n)}digest(t){try{var r=q(t,c.__wbindgen_malloc),n=g;c.hasher_digest(this.ptr,r,n)}finally{t.set(x().subarray(r/1,r/1+n)),c.__wbindgen_free(r,n*1)}}};f.exports.Hasher=u;f.exports.__wbindgen_throw=function(e,t){throw new Error(J(e,t))};var K=d("path").join(__dirname,"chromehash_bg.wasm"),Q=d("fs").readFileSync(K),X=new WebAssembly.Module(Q),Y=new WebAssembly.Instance(X,T);c=Y.exports;f.exports.__wasm=c});var U=F(l=>{"use strict";Object.defineProperty(l,"__esModule",{value:!0});l.shaHashFile=l.hashFile=l.shaHash=l.hash=void 0;var D=O(),S=d("fs"),P=d("string_decoder"),E=d("crypto"),m=Buffer.alloc(4*5),Z=e=>{let t=new D.Hasher;return t.update(te(e)),t.digest(m),t.free(),m.toString("hex")};l.hash=Z;var $=e=>{let t=(0,E.createHash)("sha256");return t.update(re(e)),t.digest("hex")};l.shaHash=$;var z=async(e,t=4096)=>{t%2===1&&t++;let r=Buffer.alloc(t),n=new D.Hasher,s;try{s=await S.promises.open(e,"r");let a=await s.read(r,0,r.length,null),i=r.slice(0,a.bytesRead);if(_(i))for(n.update(i.slice(2));a.bytesRead===r.length;)a=await s.read(r,0,r.length,null),n.update(r.slice(0,a.bytesRead));else if(B(i))for(n.update(i.slice(2).swap16());a.bytesRead===r.length;)a=await s.read(r,0,r.length,null),n.update(r.slice(0,a.bytesRead).swap16());else if(w(i)){let o=new P.StringDecoder("utf8");for(n.update(Buffer.from(o.write(i.slice(3)),"utf16le"));a.bytesRead===r.length;)a=await s.read(r,0,r.length,null),n.update(Buffer.from(o.write(r.slice(0,a.bytesRead)),"utf16le"))}else{let o=new P.StringDecoder("utf8");for(n.update(Buffer.from(o.write(i),"utf16le"));a.bytesRead===r.length;)a=await s.read(r,0,r.length,null),n.update(Buffer.from(o.write(r.slice(0,a.bytesRead)),"utf16le"))}return n.digest(m),m.toString("hex")}finally{n.free(),s!==void 0&&await s.close()}};l.hashFile=z;var y={stream:!0},ee=async(e,t=4096)=>{t%2===1&&t++;let r=Buffer.alloc(t),n=(0,E.createHash)("sha256"),s;try{s=await S.promises.open(e,"r");let a=await s.read(r,0,r.length,null),i=r.slice(0,a.bytesRead);if(_(i)){let o=new TextDecoder("utf-16le");for(n.update(o.decode(i.slice(2),y));a.bytesRead>0;)a=await s.read(r,0,r.length,null),n.update(o.decode(r.slice(0,a.bytesRead),y))}else if(B(i)){let o=new TextDecoder("utf-16be");for(n.update(o.decode(i.slice(2),y));a.bytesRead>0;)a=await s.read(r,0,r.length,null),n.update(o.decode(r.slice(0,a.bytesRead),y))}else if(w(i))for(n.update(i.slice(3));a.bytesRead>0;)a=await s.read(r,0,r.length,null),n.update(r.slice(0,a.bytesRead));else for(n.update(i);a.bytesRead>0;)a=await s.read(r,0,r.length,null),n.update(r.slice(0,a.bytesRead));return n.digest("hex")}finally{await s?.close()}};l.shaHashFile=ee;var w=e=>e.length>=3&&e[0]===239&&e[1]===187&&e[2]===191,_=e=>e.length>=2&&e[0]===255&&e[1]===254,B=e=>e.length>=2&&e[0]===254&&e[1]===255,te=e=>w(e)?v(e.slice(3)):_(e)?e.slice(2):B(e)?e.slice(2).swap16():v(e),re=e=>w(e)?e.slice(3):_(e)?new TextEncoder().encode(new TextDecoder("utf-16le").decode(e.slice(2))):B(e)?new TextEncoder().encode(new TextDecoder("utf-16be").decode(e.slice(2))):e,v=e=>Buffer.from(e.toString("utf8"),"utf16le")});var h=I(U()),b=d("fs"),R=d("worker_threads"),se=(s=>(s[s.HashFile=0]="HashFile",s[s.HashBytes=1]="HashBytes",s[s.VerifyFile=2]="VerifyFile",s[s.VerifyBytes=3]="VerifyBytes",s))(se||{}),ne=(r=>(r[r.Chromehash=0]="Chromehash",r[r.SHA256=1]="SHA256",r))(ne||{}),ae=Buffer.from("(function (exports, require, module, __filename, __dirname) { "),ie=Buffer.from(`
});`),oe=Buffer.from("(function (exports, require, module, __filename, __dirname, process, global, Buffer) { return function (exports, require, module, __filename, __dirname) { "),ce=Buffer.from(`
}.call(this, exports, require, module, __filename, __dirname); });`),le=Buffer.from("#!"),de=Buffer.from("\r")[0],he=Buffer.from(`
`)[0],ue=(e,t)=>e.slice(0,t.length).equals(t),V=(e,t,r)=>{let n=t.length===64?h.shaHash:h.hash;if(n(e)===t)return!0;if(r){if(ue(e,le)){let s=e.indexOf(he);return e[s-1]===de&&s--,n(e.slice(s))===t}if(n(Buffer.concat([ae,e,ie]))===t)return!0}return n(Buffer.concat([oe,e,ce]))===t},A=e=>e instanceof Buffer?e:Buffer.from(e,"utf-8");async function fe(e){switch(e.type){case 0:try{let t=await b.promises.readFile(e.file);return{id:e.id,hash:e.mode===0?(0,h.hash)(t):(0,h.shaHash)(t)}}catch(t){return{id:e.id}}case 1:try{return{id:e.id,hash:(0,h.hash)(A(e.data))}}catch(t){return{id:e.id}}case 2:try{let t=await b.promises.readFile(e.file);return{id:e.id,matches:V(t,e.expected,e.checkNode)}}catch(t){return{id:e.id,matches:!1}}case 3:try{return{id:e.id,matches:V(A(e.data),e.expected,e.checkNode)}}catch(t){return{id:e.id,matches:!1}}}}function pe(e){e.on("message",t=>{fe(t).then(r=>e.postMessage(r))})}R.parentPort&&pe(R.parentPort);})();
//# sourceMappingURL=hash.js.map
