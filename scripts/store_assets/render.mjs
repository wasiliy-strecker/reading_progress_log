// Code-native layouts around unchanged, real Android screenshots. Node >= 22.
import {spawn, execFileSync} from 'node:child_process';
import {mkdtempSync, readFileSync, writeFileSync, mkdirSync, existsSync, renameSync, rmSync} from 'node:fs';
import {resolve, join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {setTimeout as delay} from 'node:timers/promises';

const [mode, destination, locale = 'de-DE'] = process.argv.slice(2);
if (!['assets', 'contact'].includes(mode) || !destination) {
  throw Error('Usage: node scripts/store_assets/render.mjs assets|contact OUTPUT');
}
const copy = JSON.parse(readFileSync(`scripts/store_assets/locales/${locale}.json`, 'utf8'));
const escape = value => value.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;');
const out = resolve(destination);
mkdirSync(out, {recursive: true});
const profile = mkdtempSync('/dev/shm/sh-assets-chrome-');
const chrome = spawn('google-chrome', ['--headless=new', '--no-sandbox',
  '--disable-gpu', '--disable-dev-shm-usage', '--no-first-run',
  '--no-default-browser-check', '--hide-scrollbars', '--remote-debugging-port=0',
  `--user-data-dir=${profile}`, 'about:blank'], {stdio: 'ignore'});
let socket;
try {
  for (let i = 0; !existsSync(join(profile, 'DevToolsActivePort')); i++) {
    if (i > 100) throw Error('Chrome did not start');
    await delay(100);
  }
  const port = readFileSync(join(profile, 'DevToolsActivePort'), 'utf8').split('\n')[0];
  const pages = await (await fetch(`http://127.0.0.1:${port}/json`)).json();
  socket = new WebSocket(pages.find(p => p.type === 'page').webSocketDebuggerUrl);
  await new Promise((ok, fail) => {socket.onopen = ok; socket.onerror = fail;});
  let id = 0;
  const pending = new Map();
  socket.onmessage = ({data}) => {
    const message = JSON.parse(data);
    if (pending.has(message.id)) {
      const {ok, fail} = pending.get(message.id);
      pending.delete(message.id);
      if (message.error) fail(Error(JSON.stringify(message.error))); else ok(message.result);
    }
  };
  const call = (method, params = {}) => new Promise((ok, fail) => {
    pending.set(++id, {ok, fail});
    socket.send(JSON.stringify({id, method, params}));
  });
  const uri = p => pathToFileURL(resolve(p)).href;
  const font = `@font-face{font-family:Roboto;src:url('${uri('assets/fonts/Roboto-Regular.ttf')}')}@font-face{font-family:Roboto;src:url('${uri('assets/fonts/Roboto-Bold.ttf')}');font-weight:700}`;
  async function render(name, width, height, body, css = '') {
    const path = join(out, name);
    mkdirSync(resolve(path, '..'), {recursive: true});
    const html = join(out, 'raw/layouts', `${name}.html`);
    mkdirSync(resolve(html, '..'), {recursive:true});
    if (existsSync(`${path}.html`)) renameSync(`${path}.html`, html);
    writeFileSync(html, `<!doctype html><meta charset="utf-8"><style>${font}*{box-sizing:border-box}html,body{margin:0;width:${width}px;height:${height}px;overflow:hidden;background:#fff;font-family:Roboto,sans-serif}${css}</style>${body}`);
    await call('Emulation.setDeviceMetricsOverride', {width, height, deviceScaleFactor:1, mobile:false});
    await call('Page.navigate', {url:uri(html)});
    await delay(100);
    const ready = await call('Runtime.evaluate', {expression:'Promise.all([document.fonts.ready,...Array.from(document.images).map(i=>i.decode())])', awaitPromise:true});
    if (ready.exceptionDetails) throw Error(`Image/font loading failed for ${name}`);
    await call('Runtime.evaluate', {expression:'new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve)))', awaitPromise:true});
    await delay(250);
    const result = await call('Page.captureScreenshot', {format:'png', captureBeyondViewport:false});
    writeFileSync(path, Buffer.from(result.data, 'base64'));
    // Lossless RGB encoding only: no changes to the screenshot content.
    execFileSync('convert', [path, `${name === 'icon/app-icon.png' ? 'PNG32' : 'PNG24'}:${path}`]);
    console.log(path);
  }
  if (mode === 'contact') {
    const groups = [
      ['Smartphone', Array.from({length:6},(_,i)=>`phone/0${i+1}.png`)],
      ['7-Zoll-Tablet', ['01-dashboard','02-history','03-reading','04-backup'].map(n=>`tablet7/${n}.png`)],
      ['10-Zoll-Tablet', ['01-dashboard','02-history','03-reading','04-backup'].map(n=>`tablet10/${n}.png`)],
    ];
    let body = `<h1>Strick &amp; Häkelbuch <span>Store-Bilder · ${escape(copy.language)}</span></h1><section class="branding"><img src="${uri(join(out,'icon/app-icon.png'))}"><img src="${uri(join(out,'feature/feature-graphic.png'))}"></section>`;
    for (const [title,files] of groups) {
      body += `<h2>${title}</h2><section class="${title==='Smartphone'?'phones':'tablets'}">${files.map(f=>`<figure><img src="${uri(join(out,f))}"><figcaption>${f}</figcaption></figure>`).join('')}</section>`;
    }
    await render('VORSCHAU.png',1800,4200,body,`body{background:#FAF6EF;padding:45px;color:#526B59}h1{font-size:36px;margin:0 0 30px}h1 span{font-size:22px;font-weight:400;margin-left:20px}h2{font-size:24px;margin:28px 0 16px}.branding{display:flex;gap:40px;height:240px}.branding img{height:100%;width:auto}.phones,.tablets{display:grid;gap:18px}.phones{grid-template-columns:repeat(3,1fr)}.tablets{grid-template-columns:repeat(2,1fr)}figure{margin:0}figure img{width:100%;display:block}figcaption{font-size:13px;margin-top:8px}.tablets img{height:275px;object-fit:contain;background:#FAF6EF}.tablets{row-gap:18px}`);
  } else {
    const logo = uri('assets/branding/strick_haekelbuch_icon.svg');
    await render('icon/app-icon.png',512,512,`<img src="${logo}" width="512" height="512">`);
    const scarf = uri('assets/examples/project_photos/01_stricken_schal.png');
    await render('feature/feature-graphic.png',1024,500,`<div class="orb"></div><main><div class="eyebrow">${escape(copy.eyebrow)}</div><h1>Strick &amp;<br>Häkelbuch</h1><p>${escape(copy.tagline).replace('\n','<br>')}</p></main><img class="project" src="${scarf}">`,
      `body{background:#526B59;color:#FAF6EF}.orb{position:absolute;width:500px;height:500px;left:650px;top:-100px;border:1px solid #8C9F84;border-radius:50%}.project{position:absolute;right:55px;top:67px;width:365px;height:365px;object-fit:cover;border-radius:28px}main{position:absolute;left:64px;top:66px}.eyebrow{font-size:14px;letter-spacing:2px;color:#E3DDCC}h1{font-size:61px;line-height:1.03;letter-spacing:-1.6px;margin:26px 0 22px}p{font-size:29px;line-height:1.25;margin:0;color:#FAF6EF}`);
    const headlines = copy.heads;
    for (let i=0;i<headlines.length;i++) {
      const number = String(i+1).padStart(2,'0');
      const raw = join(out,`raw/phone/${number}.png`);
      if (!existsSync(raw)) throw Error(`Missing real capture: ${raw}`);
      // Remove the captured Android status area and its empty inset (72 px)
      // and the bottom navigation bar (54 px). App controls remain intact
      // and proportional, including the app bar and scrollable viewport.
      await render(`phone/${number}.png`,1080,1920,`<header><div class="brand">STRICK &amp; HÄKELBUCH <span>· ${number}</span></div><h1>${escape(headlines[i]).replace('\n','<br>')}</h1></header><div class="screen-frame"><img class="screen" src="${uri(raw)}"></div>`,
        `body{background:#FAF6EF;color:#526B59}header{height:330px;padding:45px 70px 0}.brand{font-size:22px;font-weight:700;letter-spacing:2px}.brand span{color:#7B806E}h1{font-size:59px;line-height:1.1;letter-spacing:-1.8px;margin:25px 0 0}.screen-frame{height:1550px;width:calc(1550px * 1080 / 1794);overflow:hidden;margin:0 auto;box-shadow:0 8px 26px #263D2D20}.screen{display:block;width:100%;height:auto;transform:translateY(calc(-72px * 1550 / 1794))}`);
    }
  }
} finally {
  socket?.close();
  chrome.kill();
  await delay(300);
  rmSync(profile, {recursive:true, force:true});
}
