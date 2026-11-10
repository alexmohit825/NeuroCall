/**
 * NeuroCall 1-Tap Wireless Safari Ad-Hoc OTA Worker
 * Serves /install, /manifest.plist, and /NeuroCall.ipa
 * Valid for 365 days on registered device: Alex's iPhone (00008150-001E7C892200401C)
 */

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const normPath = url.pathname.replace(/\/+$/, '').toLowerCase() || '/';

    // 1. Apple Wireless OTA Manifest
    if (normPath === '/manifest.plist') {
      const origin = url.origin;
      const plist = `<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>${origin}/NeuroCall.ipa</string>
                </dict>
                <dict>
                    <key>kind</key>
                    <string>display-image</string>
                    <key>needs-shine</key>
                    <false/>
                    <key>url</key>
                    <string>${origin}/icon.png</string>
                </dict>
                <dict>
                    <key>kind</key>
                    <string>full-size-image</string>
                    <key>needs-shine</key>
                    <false/>
                    <key>url</key>
                    <string>${origin}/icon.png</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>com.AlexMohit.Trephine</string>
                <key>bundle-version</key>
                <string>1.0.0</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>NeuroCall</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>`;
      return new Response(plist, {
        status: 200,
        headers: {
          'Content-Type': 'application/xml; charset=utf-8',
          'Access-Control-Allow-Origin': '*',
          'Cache-Control': 'no-cache, no-store, must-revalidate',
        },
      });
    }

    // 2. Direct IPA Binary Route (Handles any casing: /NeuroCall.ipa, /neurocall.ipa, etc.)
    if (normPath === '/neurocall.ipa' || normPath.endsWith('.ipa')) {
      if (env.ASSETS) {
        try {
          const ipaReq = new Request(new URL('/NeuroCall.ipa', url.origin), request);
          const assetResp = await env.ASSETS.fetch(ipaReq);
          if (assetResp.status === 200) {
            const headers = new Headers(assetResp.headers);
            headers.set('Content-Type', 'application/octet-stream');
            headers.set('Content-Disposition', 'attachment; filename="NeuroCall.ipa"');
            headers.set('Cache-Control', 'no-store, no-cache, must-revalidate');
            return new Response(assetResp.body, { status: 200, headers });
          }
        } catch (_) {}
      }

      // Live Fallback: Stream directly from GitHub repository raw blob or release
      const rawGithubUrl = 'https://raw.githubusercontent.com/alexmohit825/NeuroCall/main/worker/public/NeuroCall.ipa';
      try {
        const ghResp = await fetch(rawGithubUrl);
        if (ghResp.ok) {
          const headers = new Headers(ghResp.headers);
          headers.set('Content-Type', 'application/octet-stream');
          headers.set('Content-Disposition', 'attachment; filename="NeuroCall.ipa"');
          headers.set('Cache-Control', 'no-store, no-cache, must-revalidate');
          return new Response(ghResp.body, { status: 200, headers });
        }
      } catch (_) {}

      return new Response('NeuroCall.ipa is currently compiling in the cloud pipeline. Please refresh in ~2 minutes.', {
        status: 503,
        headers: { 'Content-Type': 'text/plain; charset=utf-8' },
      });
    }

    // 3. 1-Tap Safari OTA Install Page
    if (normPath === '/install' || normPath === '/' || normPath === '/ota' || normPath === '/adhoc') {
      const origin = url.origin;
      const itmsUrl = `itms-services://?action=download-manifest&url=${encodeURIComponent(`${origin}/manifest.plist`)}`;
      const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
  <title>Install NeuroCall (Ad-Hoc Direct OTA)</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
      background: linear-gradient(160deg, #05070c 0%, #0d131f 60%, #151e2e 100%);
      color: #f1f5f9;
      margin: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
      box-sizing: border-box;
    }
    .card {
      background: rgba(15, 23, 42, 0.85);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
      border: 1px solid rgba(56, 189, 248, 0.25);
      border-radius: 28px;
      max-width: 420px;
      width: 100%;
      padding: 32px 24px;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6), 0 0 40px rgba(56, 189, 248, 0.15);
      text-align: center;
    }
    .icon {
      width: 100px;
      height: 100px;
      border-radius: 22px;
      margin: 0 auto 20px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5), 0 0 20px rgba(56, 189, 248, 0.3);
      border: 2px solid rgba(255, 255, 255, 0.15);
      display: block;
      background: #000;
    }
    h1 {
      font-size: 24px;
      font-weight: 800;
      margin: 0 0 6px;
      color: #fff;
      letter-spacing: -0.5px;
    }
    .badge-bar {
      display: flex;
      justify-content: center;
      gap: 8px;
      margin-bottom: 16px;
    }
    .badge {
      display: inline-block;
      background: rgba(56, 189, 248, 0.15);
      color: #38bdf8;
      border: 1px solid rgba(56, 189, 248, 0.3);
      border-radius: 12px;
      padding: 4px 10px;
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .badge.green {
      background: rgba(34, 197, 94, 0.15);
      color: #4ade80;
      border-color: rgba(34, 197, 94, 0.3);
    }
    .desc {
      font-size: 13px;
      line-height: 1.5;
      color: #94a3b8;
      margin-bottom: 24px;
    }
    .btn {
      display: block;
      background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
      color: #fff;
      text-decoration: none;
      font-weight: 700;
      font-size: 16px;
      padding: 16px 20px;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(2, 132, 199, 0.4);
      transition: transform 0.15s, box-shadow 0.15s;
    }
    .btn:active {
      transform: scale(0.98);
      box-shadow: 0 4px 12px rgba(2, 132, 199, 0.3);
    }
    .steps {
      margin-top: 24px;
      padding-top: 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.08);
      text-align: left;
      font-size: 12px;
      color: #94a3b8;
      line-height: 1.6;
    }
    .steps strong {
      color: #cbd5e1;
    }
    .device-info {
      margin-top: 14px;
      font-size: 10px;
      color: #64748b;
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
    }
  </style>
</head>
<body>
  <div class="card">
    <img src="/icon.png" alt="NeuroCall Icon" class="icon" />
    <h1>NeuroCall</h1>
    <div class="badge-bar">
      <span class="badge">Ad-Hoc Wireless OTA</span>
      <span class="badge green">Valid 365 Days</span>
    </div>
    <div class="desc">
      Neurosurgical ER & Surgical Decision Platform.<br />
      Direct native install bypassing TestFlight processing delays.
    </div>

    <a href="${itmsUrl}" class="btn">📲 Tap to Install on iPhone</a>

    <div class="steps">
      <strong>Installation Guide:</strong><br />
      1. Tap the install button above in <strong>Safari</strong>.<br />
      2. When iOS prompts <em>"Install NeuroCall?"</em>, tap <strong>Install</strong>.<br />
      3. Return to your Home Screen — the app downloads in the background.
    </div>

    <div class="device-info">
      Registered iPhone UDID: 00008150-001E7C892200401C<br />
      Bundle: com.AlexMohit.Trephine
    </div>
  </div>
</body>
</html>`;
      return new Response(html, {
        status: 200,
        headers: {
          'Content-Type': 'text/html; charset=utf-8',
          'Cache-Control': 'no-cache, no-store, must-revalidate',
        },
      });
    }

    // Fallback to static assets
    if (env.ASSETS) {
      return env.ASSETS.fetch(request);
    }

    return new Response('Not Found', { status: 404 });
  },
};
