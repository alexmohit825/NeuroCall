import React from 'react';
import { HelpCircle, Mail, Phone, ExternalLink, ArrowLeft, Smartphone, CheckCircle2 } from 'lucide-react';

interface Props {
  onNavigate: (path: string) => void;
}

export const NeuroCallSupport: React.FC<Props> = ({ onNavigate }) => {
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
          <span className="w-2 h-2 rounded-full bg-cyan-400"></span>
          <span className="text-xs font-mono text-cyan-300 uppercase tracking-widest font-semibold">Official Clinical Support</span>
        </div>
      </nav>

      {/* Main Content */}
      <main className="flex-1 max-w-4xl mx-auto w-full px-4 sm:px-8 py-12">
        <div className="mb-10 border-b border-slate-800/80 pb-8">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-950/60 border border-cyan-800/60 text-cyan-300 text-xs font-mono font-medium mb-4">
            <HelpCircle className="w-3.5 h-3.5" />
            Neurosurgical Clinical & Technical Support
          </div>
          <h1 className="text-3xl sm:text-4xl font-bold tracking-tight text-white mb-3">
            NeuroCall Support & Documentation
          </h1>
          <p className="text-slate-400 text-sm">
            Institutional Support & Direct Clinical Inquiries • Developed by A. Alex Mohit, MD, PhD
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {/* Card 1 */}
          <div className="p-6 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
            <div>
              <div className="w-10 h-10 rounded-xl bg-cyan-950 border border-cyan-800/60 flex items-center justify-center text-cyan-400 mb-4">
                <Mail className="w-5 h-5" />
              </div>
              <h3 className="text-base font-semibold text-white mb-1">Direct Developer Email</h3>
              <p className="text-xs text-slate-400 mb-4">Direct surgeon-to-surgeon correspondence and clinical feedback.</p>
            </div>
            <a
              href="mailto:mohalex@gmail.com?subject=NeuroCall%20Clinical%20Inquiry"
              className="text-xs font-mono text-cyan-400 hover:text-cyan-300 underline flex items-center gap-1.5"
            >
              <span>mohalex@gmail.com</span>
              <ExternalLink className="w-3 h-3" />
            </a>
          </div>

          {/* Card 2 */}
          <div className="p-6 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
            <div>
              <div className="w-10 h-10 rounded-xl bg-indigo-950 border border-indigo-800/60 flex items-center justify-center text-indigo-400 mb-4">
                <Phone className="w-5 h-5" />
              </div>
              <h3 className="text-base font-semibold text-white mb-1">Direct Phone Support</h3>
              <p className="text-xs text-slate-400 mb-4">Urgent institutional triage and clinical licensing verification.</p>
            </div>
            <div className="text-xs font-mono text-indigo-300">
              +1 (206) 679-5710
            </div>
          </div>

          {/* Card 3 */}
          <div className="p-6 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
            <div>
              <div className="w-10 h-10 rounded-xl bg-emerald-950 border border-emerald-800/60 flex items-center justify-center text-emerald-400 mb-4">
                <Smartphone className="w-5 h-5" />
              </div>
              <h3 className="text-base font-semibold text-white mb-1">App Store Version</h3>
              <p className="text-xs text-slate-400 mb-4">Current release: Version 1.0.0 (Build 147) for iOS & iPadOS.</p>
            </div>
            <a
              href="https://apps.apple.com/app/id6821489631"
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs font-mono text-emerald-400 hover:text-emerald-300 underline flex items-center gap-1.5"
            >
              <span>View in App Store</span>
              <ExternalLink className="w-3 h-3" />
            </a>
          </div>
        </div>

        {/* FAQs */}
        <section className="space-y-6">
          <h2 className="text-2xl font-bold text-white tracking-tight">
            Frequently Asked Questions (FAQ)
          </h2>

          <div className="space-y-4">
            <div className="p-5 rounded-2xl bg-slate-900/40 border border-slate-800/80">
              <h3 className="text-base font-semibold text-white mb-2 flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-cyan-400 flex-shrink-0" />
                Does NeuroCall require an internet or Wi-Fi connection?
              </h3>
              <p className="text-sm text-slate-300 leading-relaxed">
                No. NeuroCall is 100% offline-sovereign. All 106 high-magnification photorealistic surgical atlas plates,
                2 AM emergency head CT calipers, bedside hardware protocols, and mathematical calculators are fully bundled
                into the native app binary. It functions with zero latency inside shielded operating rooms and basement CT suites.
              </p>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/40 border border-slate-800/80">
              <h3 className="text-base font-semibold text-white mb-2 flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-cyan-400 flex-shrink-0" />
                What devices and iOS versions are supported?
              </h3>
              <p className="text-sm text-slate-300 leading-relaxed">
                NeuroCall is optimized for iPhone (iOS 17.0+) and iPad (iPadOS 17.0+). On iPad and iPhone Pro Max displays,
                it features expansive multi-touch pinch-to-zoom (up to 5.0x magnification) and smooth dual-finger canvas panning
                to inspect minute neurovascular microanatomy.
              </p>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/40 border border-slate-800/80">
              <h3 className="text-base font-semibold text-white mb-2 flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-cyan-400 flex-shrink-0" />
                What are the clinical reference sources behind the emergency thresholds?
              </h3>
              <p className="text-sm text-slate-300 leading-relaxed">
                All triage algorithms, surgical thresholds (e.g. EDH &gt;30 mL, SDH &gt;10 mm with &gt;5 mm midline shift), and
                procedural steps are strictly grounded in peer-reviewed clinical guidelines, including the Brain Trauma Foundation (BTF)
                Management of Severe Traumatic Brain Injury (4th Edition), American Association of Neurological Surgeons (AANS) guidelines,
                and the Subaxial Injury Classification (SLICS) system.
              </p>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/40 border border-slate-800/80">
              <h3 className="text-base font-semibold text-white mb-2 flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-cyan-400 flex-shrink-0" />
                How can I request additional surgical corridors or report an error?
              </h3>
              <p className="text-sm text-slate-300 leading-relaxed">
                We actively expand the 106-plate atlas based on institutional feedback from practicing neurosurgeons and residents.
                Please email <a href="mailto:mohalex@gmail.com" className="text-cyan-400 underline">mohalex@gmail.com</a> with the subject
                &ldquo;NeuroCall Corridor Request&rdquo; detailing the surgical approach, bony boundaries, and neurovascular structures requested.
              </p>
            </div>
          </div>
        </section>

        {/* Clinical Disclaimer */}
        <section className="mt-12 p-6 rounded-2xl bg-amber-950/20 border border-amber-500/20 text-xs text-amber-200/80 leading-relaxed">
          <strong className="text-amber-200 font-semibold block mb-1">CLINICAL REFERENCE DISCLAIMER (Apple Guideline 1.4.1):</strong>
          NeuroCall is designed strictly as an educational and bedside reference tool for neurosurgeons, spine surgeons, neurocritical care teams,
          and surgical residents on call. Calculations and risk scores are clinical decision-support aids that do not replace independent clinical judgment.
        </section>
      </main>

      {/* Footer */}
      <footer className="border-t border-slate-800/80 bg-[#060810] py-6 px-4 sm:px-8 text-center text-xs text-slate-500">
        <p>© 2026 A. Alex Mohit. All rights reserved. • NeuroCall Operative Workstation</p>
      </footer>
    </div>
  );
};
