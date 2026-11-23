import React from 'react';
import { ShieldCheck, Lock, ArrowLeft, Mail, Phone } from 'lucide-react';

interface Props {
  onNavigate: (path: string) => void;
}

export const NeuroCallPrivacy: React.FC<Props> = ({ onNavigate }) => {
  return (
    <div className="min-h-screen bg-[#070a12] text-slate-100 flex flex-col font-sans selection:bg-cyan-500 selection:text-black">
      {/* Top Navbar */}
      <nav className="border-b border-slate-800/80 bg-[#090d18]/90 backdrop-blur-md sticky top-0 z-50 px-4 sm:px-8 py-3.5 flex items-center justify-between">
        <button
          onClick={() => onNavigate('/')}
          className="flex items-center gap-2 text-slate-300 hover:text-white transition-colors text-sm font-medium cursor-pointer"
        >
          <ArrowLeft className="w-4 h-4 text-cyan-400" />
          <span>Back to NeuroCall</span>
        </button>
        <div className="flex items-center gap-2">
          <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
          <span className="text-xs font-mono text-emerald-400 uppercase tracking-widest font-semibold">HIPAA Sovereign • Zero Tracking</span>
        </div>
      </nav>

      {/* Main Content */}
      <main className="flex-1 max-w-4xl mx-auto w-full px-4 sm:px-8 py-12">
        <div className="mb-10 border-b border-slate-800/80 pb-8">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-950/60 border border-cyan-800/60 text-cyan-300 text-xs font-mono font-medium mb-4">
            <ShieldCheck className="w-3.5 h-3.5" />
            Official App Store Privacy Policy
          </div>
          <h1 className="text-3xl sm:text-4xl font-bold tracking-tight text-white mb-3">
            Privacy Policy for NeuroCall
          </h1>
          <p className="text-slate-400 text-sm">
            Effective Date: November 23, 2026 • Developer: A. Alex Mohit, MD, PhD • Version 1.0.0
          </p>
        </div>

        <div className="space-y-8 text-slate-300 text-sm sm:text-base leading-relaxed">
          {/* Executive Summary */}
          <div className="p-6 rounded-2xl bg-gradient-to-br from-cyan-950/30 via-slate-900/60 to-slate-950 border border-cyan-500/20">
            <h2 className="text-lg font-semibold text-white mb-2 flex items-center gap-2">
              <Lock className="w-5 h-5 text-cyan-400" />
              Core Privacy Commitment: Absolute Zero Data Collection
            </h2>
            <p className="text-slate-300 leading-relaxed text-sm sm:text-base">
              NeuroCall is engineered from the ground up to guarantee absolute clinical confidentiality and HIPAA sovereignty.
              NeuroCall <strong className="text-white">does not collect, transmit, store, sell, or share</strong> any personal identity information,
              device telemetry, usage analytics, or patient health information (PHI). Everything you view, calculate, or enter in NeuroCall
              remains strictly confined to your physical iOS device’s volatile memory.
            </p>
          </div>

          {/* Section 1 */}
          <section className="space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <span className="text-cyan-400 font-mono">1.</span> Information We Do Not Collect
            </h2>
            <p>
              Unlike conventional mobile health tools, NeuroCall contains <strong className="text-white">zero tracking SDKs, zero advertising frameworks, and zero analytics libraries</strong> (such as Google Analytics, Firebase Analytics, Meta SDK, or Mixpanel).
            </p>
            <ul className="list-disc pl-5 space-y-1.5 text-slate-400">
              <li><strong className="text-slate-200">No Patient Health Information (PHI):</strong> Any clinical values, hematoma measurements, or caliper coordinates entered during crisis triage are executed in device RAM and are never written to disk or transmitted across any network.</li>
              <li><strong className="text-slate-200">No Personal Identity Data:</strong> We do not ask for, collect, or store your name, email address, phone number, hospital affiliation, or Apple ID credentials.</li>
              <li><strong className="text-slate-200">No Location or Sensor Data:</strong> The application does not access GPS, cellular location, camera, microphone, or Bluetooth hardware.</li>
              <li><strong className="text-slate-200">No Device Telemetry:</strong> We do not log IP addresses, MAC addresses, IDFA (Identifier for Advertisers), or operating system logs.</li>
            </ul>
          </section>

          {/* Section 2 */}
          <section className="space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <span className="text-cyan-400 font-mono">2.</span> 100% Offline Architecture & Data Sovereignty
            </h2>
            <p>
              NeuroCall is intentionally built as a standalone, 100% offline-first application. All 106 photorealistic master surgical atlas plates,
              caliper calculators, emergency triage algorithms, and procedural guides are bundled directly into the compiled native Swift application binary.
            </p>
            <p>
              The application requires <strong className="text-white">no network connection</strong> to operate and makes zero outbound HTTP/HTTPS requests
              during runtime. You can launch, examine high-resolution operative corridors, and compute emergency hematoma thresholds in subterranean OR suites,
              hardened trauma centers, or during complete hospital network blackouts without compromising application functionality or patient data security.
            </p>
          </section>

          {/* Section 3 */}
          <section className="space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <span className="text-cyan-400 font-mono">3.</span> App Store & Apple In-App Review
            </h2>
            <p>
              When you download NeuroCall from the Apple App Store, Apple processes the transaction and license verification under their own standard privacy policy.
              NeuroCall does not use third-party payment gateways, does not offer subscriptions, and does not sell digital merchandise.
              In accordance with Apple Guideline 5.6.1, native rating prompts are presented via Apple's standard un-gated review interface with zero data interception.
            </p>
          </section>

          {/* Section 4 */}
          <section className="space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <span className="text-cyan-400 font-mono">4.</span> Children's Privacy
            </h2>
            <p>
              NeuroCall is a specialized operative reference and medical decision-support workstation intended solely for healthcare professionals,
              surgeons, and medical trainees. It is not directed at children under the age of 13, and we do not knowingly collect any data from children.
            </p>
          </section>

          {/* Section 5 */}
          <section className="space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <span className="text-cyan-400 font-mono">5.</span> Changes to this Policy
            </h2>
            <p>
              If this privacy policy is modified in future releases, updates will be reflected on this page with an updated revision date.
              Because NeuroCall does not collect email addresses or contact details, we encourage users to review this page periodically.
            </p>
          </section>

          {/* Section 6 */}
          <section className="p-6 rounded-2xl bg-slate-900/50 border border-slate-800 space-y-3">
            <h2 className="text-xl font-semibold text-white tracking-tight flex items-center gap-2">
              <Mail className="w-5 h-5 text-cyan-400" />
              Contact Information & Inquiries
            </h2>
            <p className="text-slate-400 text-sm">
              If you have any questions or require additional documentation regarding NeuroCall's privacy architecture or compliance standards, please contact the developer directly:
            </p>
            <div className="pt-2 space-y-1 font-mono text-sm text-slate-300">
              <div className="text-white font-medium">A. Alex Mohit, MD, PhD</div>
              <div>Department of Neurological Surgery</div>
              <div className="flex items-center gap-2 text-cyan-400">
                <Mail className="w-4 h-4" />
                <a href="mailto:mohalex@gmail.com" className="hover:underline">mohalex@gmail.com</a>
              </div>
              <div className="flex items-center gap-2 text-slate-400">
                <Phone className="w-4 h-4" />
                <span>+1 (206) 679-5710</span>
              </div>
            </div>
          </section>
        </div>
      </main>

      {/* Footer */}
      <footer className="border-t border-slate-800/80 bg-[#060810] py-6 px-4 sm:px-8 text-center text-xs text-slate-500">
        <p>© 2026 A. Alex Mohit. All rights reserved. • NeuroCall Operative Workstation</p>
      </footer>
    </div>
  );
};
