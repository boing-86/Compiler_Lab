(()=>{"use strict";var t={747:t=>{t.exports=require("fs")},631:t=>{t.exports=require("net")},549:t=>{t.exports=require("vscode")}},e={};function a(n){var s=e[n];if(void 0!==s)return s.exports;var o=e[n]={exports:{}};return t[n](o,o.exports,a),o.exports}var n={};(()=>{var t=n;Object.defineProperty(t,"__esModule",{value:!0}),t.deactivate=t.activate=void 0;const e=a(747),s=a(631),o=a(549),i={disabled:o.l10n.t("Auto Attach: Disabled"),always:o.l10n.t("Auto Attach: Always"),smart:o.l10n.t("Auto Attach: Smart"),onlyWithFlag:o.l10n.t("Auto Attach: With Flag")},r={disabled:o.l10n.t("Disabled"),always:o.l10n.t("Always"),smart:o.l10n.t("Smart"),onlyWithFlag:o.l10n.t("Only With Flag")},c={disabled:o.l10n.t("Auto attach is disabled and not shown in status bar"),always:o.l10n.t("Auto attach to every Node.js process launched in the terminal"),smart:o.l10n.t("Auto attach when running scripts that aren't in a node_modules folder"),onlyWithFlag:o.l10n.t("Only auto attach when the `--inspect` flag is given")},l=o.l10n.t("Toggle auto attach in this workspace"),u=o.l10n.t("Toggle auto attach on this machine"),d=o.l10n.t("Temporarily disable auto attach in this session"),g=o.l10n.t("Re-enable auto attach"),p=o.l10n.t("Auto Attach: Disabled"),h="extension.node-debug.toggleAutoAttach",w="jsDebugIpcState",f="debug.javascript",m="autoAttachFilter",b=new Set(["autoAttachSmartPattern",m].map((t=>`debug.javascript.${t}`)));let y,A,v,x=!1;async function C(t,e){const a=o.workspace.getConfiguration(f);var n;const s=(e=e||((n=a.inspect(m))?n.workspaceFolderValue?o.ConfigurationTarget.WorkspaceFolder:n.workspaceValue?o.ConfigurationTarget.Workspace:(n.globalValue,o.ConfigurationTarget.Global):o.ConfigurationTarget.Global))===o.ConfigurationTarget.Global,i=o.window.createQuickPick(),p=T(),h=["always","smart","onlyWithFlag","disabled"].map((t=>({state:t,label:r[t],description:c[t],alwaysShow:!0})));"disabled"!==p&&h.unshift({setTempDisabled:!x,label:x?g:d,alwaysShow:!0}),i.items=h,i.activeItems=x?[h[0]]:i.items.filter((t=>"state"in t&&t.state===p)),i.title=s?u:l,i.buttons=[{iconPath:new o.ThemeIcon(s?"folder":"globe"),tooltip:s?l:u}],i.show();let w=await new Promise((t=>{i.onDidAccept((()=>t(i.selectedItems[0]))),i.onDidHide((()=>t(void 0))),i.onDidTriggerButton((()=>{t({scope:s?o.ConfigurationTarget.Workspace:o.ConfigurationTarget.Global})}))}));if(i.dispose(),w){if("scope"in w)return await C(t,w.scope);"state"in w&&(w.state!==p?a.update(m,w.state,e):x&&(w={setTempDisabled:!1})),"setTempDisabled"in w&&(F(t,p,!0),x=w.setTempDisabled,w.setTempDisabled?await j():await k(t),F(t,p,!1))}}function T(){return o.workspace.getConfiguration(f).get(m)??"disabled"}async function k(t){const e=await async function(t){const e=t.workspaceState.get(w),a=o.extensions.getExtension("ms-vscode.js-debug-nightly")?.extensionPath||o.extensions.getExtension("ms-vscode.js-debug")?.extensionPath,n=function(){const t={},e=o.workspace.getConfiguration(f);for(const a of b)t[a]=e.get(a);return JSON.stringify(t)}();if(e?.jsDebugPath===a&&e?.settingsValue===n)return e.ipcAddress;const s=await o.commands.executeCommand("extension.js-debug.setAutoAttachVariables",e?.ipcAddress);if(!s)return;const i=s.ipcAddress;return await t.workspaceState.update(w,{ipcAddress:i,jsDebugPath:a,settingsValue:n}),i}(t);if(e)return v=S(e).catch((t=>{console.error(t)})),await v}t.activate=function(t){y=Promise.resolve({context:t,state:null}),t.subscriptions.push(o.commands.registerCommand(h,C.bind(null,t))),t.subscriptions.push(o.workspace.onDidChangeConfiguration((t=>{(t.affectsConfiguration(`debug.javascript.${m}`)||[...b].some((e=>t.affectsConfiguration(e))))&&(W("disabled"),W(T()))}))),W(T())},t.deactivate=async function(){await j()};const S=async t=>{try{return await D(t)}catch(a){return await e.promises.unlink(t).catch((()=>{})),await D(t)}},D=t=>new Promise(((e,a)=>{const n=(0,s.createServer)((t=>{const e=[];t.on("data",(async a=>{if(0===a[a.length-1]){e.push(a.slice(0,-1));try{await o.commands.executeCommand("extension.js-debug.autoAttachToProcess",JSON.parse(Buffer.concat(e).toString())),t.write(Buffer.from([0]))}catch(e){t.write(Buffer.from([1])),console.error(e)}}else e.push(a)}))})).on("error",a).listen(t,(()=>e(n)))}));async function j(){const t=await v;t&&await new Promise((e=>t.close(e)))}const P={async disabled(t){await async function(t){(v||await t.workspaceState.get(w))&&(await t.workspaceState.update(w,void 0),await o.commands.executeCommand("extension.js-debug.clearAutoAttachVariables"),await j())}(t)},async onlyWithFlag(t){await k(t)},async smart(t){await k(t)},async always(t){await k(t)}};function F(t,e,a=!1){if("disabled"===e&&!a)return void A?.hide();A||(A=o.window.createStatusBarItem("status.debug.autoAttach",o.StatusBarAlignment.Left),A.name=o.l10n.t("Debug Auto Attach"),A.command=h,A.tooltip=o.l10n.t("Automatically attach to node.js processes in debug mode"),t.subscriptions.push(A));let n=a?"$(loading) ":"";n+=x?p:i[e],A.text=n,A.show()}function W(t){y=y.then((async({context:e,state:a})=>t===a?{context:e,state:a}:(null!==a&&F(e,a,!0),await P[t](e),x=!1,F(e,t,!1),{context:e,state:t})))}})();var s=exports;for(var o in n)s[o]=n[o];n.__esModule&&Object.defineProperty(s,"__esModule",{value:!0})})();
//# sourceMappingURL=https://ticino.blob.core.windows.net/sourcemaps/7f329fe6c66b0f86ae1574c2911b681ad5a45d63/extensions/debug-auto-launch/dist/extension.js.map