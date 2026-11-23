import React, { useState } from 'react';
import {
  Brain, Shield, ShieldCheck, Activity, Layers, Download, ExternalLink,
  AlertTriangle, Stethoscope, Compass, FileText,
  Scale, Cpu, Copy, Check
} from 'lucide-react';

interface Props {
  onNavigate: (path: string) => void;
}

export const NeuroCallLanding: React.FC<Props> = ({ onNavigate }) => {
  // Interactive Atlas Domain Tab
  const [activeDomain, setActiveDomain] = useState<'master' | 'cranial' | 'spine' | 'pediatric'>('master');
  
  // Interactive Caliper Simulator State
  const [selectedPathology, setSelectedPathology] = useState<'edh' | 'sdh' | 'uncal' | 'postfossa'>('edh');
  const [edhVolume, setEdhVolume] = useState<number>(34);
  const [edhThickness, setEdhThickness] = useState<number>(18);
  const [midlineShift, setMidlineShift] = useState<number>(6);

  // CPP Calculator State
  const [mapVal, setMapVal] = useState<number>(95);
  const [icpVal, setIcpVal] = useState<number>(18);
  const cppVal = mapVal - icpVal;

  // SBAR Copy State
  const [copiedSbar, setCopiedSbar] = useState<boolean>(false);

  const handleCopySbar = () => {
    const sbarText = `NEUROCALL SBAR CASE SUMMARY:
• Situation: 48M Level 1 Trauma, acute neurological deterioration, GCS 7 (E1V2M4), right pupil 5mm sluggish.
• Background: High-speed MVC, known on aspirin 81mg, no known prior neurosurgical history.
• Assessment: Non-contrast head CT demonstrates acute right temporal biconvex Epidural Hematoma (Volume ${edhVolume} mL, thickness ${edhThickness} mm, midline shift ${midlineShift} mm) with uncal herniation risk.
• Recommendation: Emergency right pterional trauma craniotomy for hematoma evacuation. Anesthesia and OR 4 notified. 3% Hypertonic Saline 250mL bolus running, SBP maintained >100.`;
    navigator.clipboard.writeText(sbarText);
    setCopiedSbar(true);
    setTimeout(() => setCopiedSbar(false), 2500);
  };

  return (
    <div className="min-h-screen bg-[#070a12] text-slate-100 flex flex-col font-sans selection:bg-cyan-500 selection:text-black">
      {/* ─── Top Global Announcement Banner ─── */}
      <div className="bg-gradient-to-r from-cyan-950 via-indigo-950 to-slate-950 border-b border-cyan-800/40 px-4 py-2 text-center text-xs text-cyan-200 flex items-center justify-center gap-2">
        <span className="flex h-2 w-2 rounded-full bg-cyan-400 animate-ping"></span>
        <span className="font-semibold text-white">NeuroCall Version 1.0 (Build 147)</span>
        <span className="hidden sm:inline text-slate-400">•</span>
        <span className="hidden sm:inline">106 Photorealistic Master Plates & 2 AM Crisis Head CT Workstation</span>
        <span className="text-slate-400">•</span>
        <span className="text-emerald-400 font-mono font-medium">100% Offline & Sovereign</span>
      </div>

      {/* ─── Navigation Header ─── */}
      <header className="border-b border-slate-800/80 bg-[#090d18]/90 backdrop-blur-md sticky top-0 z-50 px-4 sm:px-8 py-3.5">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-cyan-600 via-indigo-600 to-purple-600 p-[1.5px] shadow-lg shadow-cyan-950/50">
              <div className="w-full h-full bg-[#090d18] rounded-[10px] flex items-center justify-center">
                <Brain className="w-5 h-5 text-cyan-400" />
              </div>
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-lg font-bold tracking-tight text-white font-sans">NeuroCall</span>
                <span className="text-[10px] font-mono px-1.5 py-0.5 rounded bg-cyan-950 border border-cyan-800/60 text-cyan-300 font-semibold">v1.0</span>
              </div>
              <p className="text-[11px] text-slate-400 hidden sm:block">Operative Neurosurgery & Crisis Engine</p>
            </div>
          </div>

          <nav className="hidden md:flex items-center gap-6 text-sm font-medium text-slate-300">
            <a href="#atlas" className="hover:text-cyan-400 transition-colors">106-Plate Atlas</a>
            <a href="#calipers" className="hover:text-cyan-400 transition-colors">Crisis Head CT</a>
            <a href="#triage" className="hover:text-cyan-400 transition-colors">Frontline Triage</a>
            <a href="#calculators" className="hover:text-cyan-400 transition-colors">Clinical Hub</a>
            <button onClick={() => onNavigate('/privacy')} className="hover:text-cyan-400 transition-colors cursor-pointer">Privacy</button>
            <button onClick={() => onNavigate('/support')} className="hover:text-cyan-400 transition-colors cursor-pointer">Support</button>
          </nav>

          <div className="flex items-center gap-3">
            <a
              href="https://apps.apple.com/app/id6821489631"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-slate-950 font-semibold text-xs sm:text-sm shadow-md shadow-cyan-950/50 transition-all transform hover:-translate-y-0.5"
            >
              <Download className="w-4 h-4 text-slate-950" />
              <span>App Store</span>
            </a>
          </div>
        </div>
      </header>

      {/* ─── Hero Section ─── */}
      <section className="relative overflow-hidden pt-12 pb-20 sm:pt-20 sm:pb-28 px-4 sm:px-8 border-b border-slate-800/80">
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_80%_60%_at_50%_-20%,rgba(6,182,212,0.15),rgba(255,255,255,0))]"></div>
        <div className="max-w-6xl mx-auto relative z-10 text-center">
          
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-900/80 border border-slate-700/80 text-slate-300 text-xs font-mono mb-6 backdrop-blur-sm">
            <span className="w-2 h-2 rounded-full bg-emerald-400"></span>
            <span>ENGINEERED BY SURGEONS • TIER 0 FREE • 100% OFFLINE</span>
          </div>

          <h1 className="text-4xl sm:text-6xl font-extrabold tracking-tight text-white max-w-4xl mx-auto leading-[1.12] mb-6">
            The 2 AM Neurosurgical Decision Support Engine & <span className="bg-gradient-to-r from-cyan-400 via-indigo-300 to-purple-400 bg-clip-text text-transparent">360° Operative Atlas</span>
          </h1>

          <p className="text-base sm:text-xl text-slate-300 max-w-3xl mx-auto mb-10 leading-relaxed font-normal">
            Engineered by <strong className="text-white">Dr. A. Alex Mohit, MD, PhD</strong> for neurosurgeons, spine surgeons, neurocritical care intensivists, and surgical residents on call.
            Featuring 106 studio-grade photorealistic master plates, interactive emergency CT calipers, and 5-phase frontline emergency triage.
          </p>

          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-14">
            <a
              href="https://apps.apple.com/app/id6821489631"
              target="_blank"
              rel="noopener noreferrer"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-3 px-7 py-3.5 rounded-2xl bg-white text-slate-950 font-bold text-sm sm:text-base hover:bg-slate-200 transition-all shadow-xl shadow-cyan-950/40 group"
            >
              <Download className="w-5 h-5 text-slate-950 group-hover:scale-110 transition-transform" />
              <span>Download on the App Store</span>
              <span className="text-xs font-mono py-0.5 px-2 rounded-full bg-slate-100 border border-slate-300 text-slate-700">Free</span>
            </a>

            <a
              href="#atlas"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-2xl bg-slate-900/90 hover:bg-slate-800/90 border border-slate-700 text-slate-200 font-semibold text-sm sm:text-base transition-all"
            >
              <Layers className="w-4 h-4 text-cyan-400" />
              <span>Explore 106 Master Plates</span>
            </a>
          </div>

          {/* Quick Metrics Bar */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 max-w-4xl mx-auto text-left">
            <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800">
              <div className="text-2xl font-bold text-cyan-400 font-mono">106 Plates</div>
              <div className="text-xs text-slate-400 mt-1">4 Distinct Clinical Domains with 360° Corridors</div>
            </div>
            <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800">
              <div className="text-2xl font-bold text-indigo-400 font-mono">5.0x Zoom</div>
              <div className="text-xs text-slate-400 mt-1">Sub-millimeter Microdissection & Dual-Finger Pan</div>
            </div>
            <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800">
              <div className="text-2xl font-bold text-emerald-400 font-mono">0.0 ms</div>
              <div className="text-xs text-slate-400 mt-1">Zero Cloud Latency • 100% Offline-Sovereign</div>
            </div>
            <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800">
              <div className="text-2xl font-bold text-purple-400 font-mono">Zero Track</div>
              <div className="text-xs text-slate-400 mt-1">Absolute HIPAA Sovereignty • No Third-Party SDKs</div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── Pillar 1: The 106-Plate Surgical Atlas ─── */}
      <section id="atlas" className="py-20 px-4 sm:px-8 border-b border-slate-800/80 bg-[#080c16]">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-3xl mx-auto mb-12">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-950/60 border border-cyan-800/60 text-cyan-300 text-xs font-mono font-medium mb-3">
              <Layers className="w-3.5 h-3.5" />
              Surgical Atlas Architecture
            </div>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-white tracking-tight mb-4">
              106 Photorealistic Master Surgical Atlas Plates
            </h2>
            <p className="text-slate-400 text-sm sm:text-base leading-relaxed">
              Every anatomical plate in NeuroCall is an original, de novo digital illustration composite-engineered under practicing neurosurgical oversight.
              Explore the four standardized operative domains:
            </p>
          </div>

          {/* Domain Tabs */}
          <div className="flex flex-wrap items-center justify-center gap-2 sm:gap-3 mb-10">
            <button
              onClick={() => setActiveDomain('master')}
              className={`px-4 py-2.5 rounded-xl font-medium text-xs sm:text-sm transition-all cursor-pointer flex items-center gap-2 ${
                activeDomain === 'master'
                  ? 'bg-amber-500 text-slate-950 shadow-lg shadow-amber-500/20 font-semibold'
                  : 'bg-slate-900 text-slate-400 hover:text-slate-200 border border-slate-800'
              }`}
            >
              <span>🌟 Atlas Master (1)</span>
            </button>
            <button
              onClick={() => setActiveDomain('cranial')}
              className={`px-4 py-2.5 rounded-xl font-medium text-xs sm:text-sm transition-all cursor-pointer flex items-center gap-2 ${
                activeDomain === 'cranial'
                  ? 'bg-cyan-500 text-slate-950 shadow-lg shadow-cyan-500/20 font-semibold'
                  : 'bg-slate-900 text-slate-400 hover:text-slate-200 border border-slate-800'
              }`}
            >
              <span>🧠 Cranial & Skull Base (45)</span>
            </button>
            <button
              onClick={() => setActiveDomain('spine')}
              className={`px-4 py-2.5 rounded-xl font-medium text-xs sm:text-sm transition-all cursor-pointer flex items-center gap-2 ${
                activeDomain === 'spine'
                  ? 'bg-indigo-500 text-slate-950 shadow-lg shadow-indigo-500/20 font-semibold'
                  : 'bg-slate-900 text-slate-400 hover:text-slate-200 border border-slate-800'
              }`}
            >
              <span>🦴 Spine & CVJ (55)</span>
            </button>
            <button
              onClick={() => setActiveDomain('pediatric')}
              className={`px-4 py-2.5 rounded-xl font-medium text-xs sm:text-sm transition-all cursor-pointer flex items-center gap-2 ${
                activeDomain === 'pediatric'
                  ? 'bg-pink-500 text-slate-950 shadow-lg shadow-pink-500/20 font-semibold'
                  : 'bg-slate-900 text-slate-400 hover:text-slate-200 border border-slate-800'
              }`}
            >
              <span>👶 Pediatric Neurosurgery (5)</span>
            </button>
          </div>

          {/* Active Domain Card Showcase */}
          <div className="p-6 sm:p-8 rounded-2xl bg-slate-900/80 border border-slate-800 shadow-2xl relative overflow-hidden">
            {activeDomain === 'master' && (
              <div>
                <div className="flex items-center justify-between mb-4 flex-wrap gap-2">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono font-bold px-2 py-0.5 rounded bg-amber-500/20 text-amber-300 border border-amber-500/30">PLATE 096</span>
                    <h3 className="text-xl sm:text-2xl font-bold text-white">The NeuroCall Surgical Atlas: 360° Master Corridors</h3>
                  </div>
                  <span className="text-xs font-mono text-slate-400">Default App Launch Landing Plate</span>
                </div>
                <p className="text-sm text-slate-300 mb-6 leading-relaxed">
                  The omnidirectional orientation masterwork linking cranial anterior skull base, lateral skull base, posterior fossa, and the spinal axis into a unified 4-quadrant surgical navigation matrix.
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4">
                  <div className="p-4 rounded-xl bg-slate-950/70 border border-slate-800">
                    <div className="text-xs font-mono text-cyan-400 font-bold mb-1">QUADRANT I</div>
                    <div className="text-sm font-semibold text-white mb-1">Anterior Skull Base</div>
                    <div className="text-xs text-slate-400">Pterional, Trans-sylvian, FT-OZO, & Supraorbital Eyebrow</div>
                  </div>
                  <div className="p-4 rounded-xl bg-slate-950/70 border border-slate-800">
                    <div className="text-xs font-mono text-indigo-400 font-bold mb-1">QUADRANT II</div>
                    <div className="text-sm font-semibold text-white mb-1">Posterior Fossa & CPA</div>
                    <div className="text-xs text-slate-400">Retrosigmoid Asterion, Far-Lateral Transcondylar, & Suboccipital</div>
                  </div>
                  <div className="p-4 rounded-xl bg-slate-950/70 border border-slate-800">
                    <div className="text-xs font-mono text-purple-400 font-bold mb-1">QUADRANT III</div>
                    <div className="text-sm font-semibold text-white mb-1">Craniovertebral & Cervical</div>
                    <div className="text-xs text-slate-400">Harms C1-C2 Fixation, Odontoid Screw, & Subaxial ACDF</div>
                  </div>
                  <div className="p-4 rounded-xl bg-slate-950/70 border border-slate-800">
                    <div className="text-xs font-mono text-pink-400 font-bold mb-1">QUADRANT IV</div>
                    <div className="text-sm font-semibold text-white mb-1">Thoracolumbar Deformity</div>
                    <div className="text-xs text-slate-400">MIS TLIF, Transpsoas LLIF, & Ponte/PSO Osteotomies</div>
                  </div>
                </div>
              </div>
            )}

            {activeDomain === 'cranial' && (
              <div>
                <div className="flex items-center justify-between mb-4 flex-wrap gap-2">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono font-bold px-2 py-0.5 rounded bg-cyan-500/20 text-cyan-300 border border-cyan-500/30">45 MASTER PLATES</span>
                    <h3 className="text-xl sm:text-2xl font-bold text-white">Cranial Convexity, Skull Base & Cerebrovascular</h3>
                  </div>
                  <span className="text-xs font-mono text-slate-400">Plates 017 to 086</span>
                </div>
                <p className="text-sm text-slate-300 mb-6 leading-relaxed">
                  Microsurgical anatomy of key corridors with sequential steps, vascular landmarks, and critical bony limits:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3 text-xs">
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Pterional & Trans-sylvian (Plates 024-026)</strong>
                    Sphenoid ridge drilling, sylvian fissure dissection, ICA bifurcation, and PComA aneurysm clipping.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Retrosigmoid CPA (Plates 027-029)</strong>
                    Asterion craniectomy, transverse-sigmoid junction, CN VII/VIII preservation, and acoustic neuroma corridors.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Far-Lateral Transcondylar (Plate 030)</strong>
                    Suboccipital corridor, vertebral artery V3 horizontal segment, foramen magnum, and PICA origins.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Fronto-Temporo-Orbitozygomatic (Plate 033)</strong>
                    Two-piece osteotomy, superior orbital fissure unroofing, and basilar apex mobilization.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Endoscopic Endonasal Sellar (Plates 038-040)</strong>
                    Sphenoid sinus sphenoidotomy, sellar floor opening, carotid protuberance, and optico-carotid recess.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Decompressive Hemicraniectomy (Plates 075-077)</strong>
                    Reverse question-mark flap, 12x15 cm bone flap, middle meningeal coagulation, and duraplasty.
                  </div>
                </div>
              </div>
            )}

            {activeDomain === 'spine' && (
              <div>
                <div className="flex items-center justify-between mb-4 flex-wrap gap-2">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono font-bold px-2 py-0.5 rounded bg-indigo-500/20 text-indigo-300 border border-indigo-500/30">55 MASTER PLATES</span>
                    <h3 className="text-xl sm:text-2xl font-bold text-white">Spine, CVJ, Deformity & Peripheral Nerve</h3>
                  </div>
                  <span className="text-xs font-mono text-slate-400">Plates 001 to 092</span>
                </div>
                <p className="text-sm text-slate-300 mb-6 leading-relaxed">
                  Comprehensive spinal corridor coverage from craniovertebral junction down through the sacrum and pelvis:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3 text-xs">
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Harms C1-C2 Fixation (Plates 001, 003)</strong>
                    C1 lateral mass screw trajectory, C2 pars/pedicle trajectory, and vertebral artery loop safety.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Anterior Cervical Discectomy & Fusion (Plate 006)</strong>
                    Smith-Robinson interval, carotid sheath retraction, uncovertebral joint margin, and PLL release.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Subaxial Lateral Mass Fixation (Plate 007)</strong>
                    Magerl technique (10° lateral, 25° cranial), Roy-Camille comparison, and nerve root avoidance.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Minimally Invasive TLIF & LLIF (Plates 010-012)</strong>
                    Tubular retractor docking, Kambin triangle navigation, endplate preparation, and cage insertion.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Pedicle Subtraction Osteotomy (Plates 014-015)</strong>
                    Wedge osteotomy, anterior hinge preservation, sagittal alignment restoration, and dural buckling check.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Peripheral Nerve Decompressions (Plates 088-092)</strong>
                    Carpal tunnel release, cubital tunnel anterior transposition, and brachial plexus Oberlin transfers.
                  </div>
                </div>
              </div>
            )}

            {activeDomain === 'pediatric' && (
              <div>
                <div className="flex items-center justify-between mb-4 flex-wrap gap-2">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono font-bold px-2 py-0.5 rounded bg-pink-500/20 text-pink-300 border border-pink-500/30">5 MASTER PLATES</span>
                    <h3 className="text-xl sm:text-2xl font-bold text-white">Pediatric Neurosurgery & Neural Tube Defects</h3>
                  </div>
                  <span className="text-xs font-mono text-slate-400">Plates 002, 043, 046, 095, 105</span>
                </div>
                <p className="text-sm text-slate-300 mb-6 leading-relaxed">
                  Specialized pediatric dysraphism, craniosynostosis, and hindbrain herniation plates:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3 text-xs">
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Plate 002: Pediatric Chiari IV & Hypoplasia</strong>
                    Severe cerebellar aplasia, posterior fossa tentorial architecture, and occipital encephalocele.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Plate 043: Open Myelomeningocele Repair</strong>
                    Neural placode dissection, circumferential dural closure, myofascial flap advancement, and skin coverage.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Plate 046: Occipital Encephalocele Reconstruction</strong>
                    Torcular herophili preservation, dural reconstruction, and bony calvarial defect repair.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Plate 095: Coronal Craniosynostosis</strong>
                    Fronto-orbital advancement, supraorbital bar remodeling, and barrel-stave calvarial osteotomies.
                  </div>
                  <div className="p-3 rounded-lg bg-slate-950/60 border border-slate-800 text-slate-300">
                    <strong className="text-white block mb-0.5">Plate 105: Pediatric 4th Ventricular Ependymoma</strong>
                    Telovelar approach, vermian-sparing exposure, floor of 4th ventricle, and obex landmarks.
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* ─── Pillar 2: 2 AM Crisis Head CT Workstation & Calipers ─── */}
      <section id="calipers" className="py-20 px-4 sm:px-8 border-b border-slate-800/80">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-3xl mx-auto mb-12">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-950/60 border border-red-800/60 text-red-300 text-xs font-mono font-medium mb-3">
              <Activity className="w-3.5 h-3.5 text-red-400" />
              Interactive Emergency Caliper Simulator
            </div>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-white tracking-tight mb-4">
              2 AM Crisis Head CT Workstation
            </h2>
            <p className="text-slate-400 text-sm sm:text-base leading-relaxed">
              Standardized caliper measurements and surgical evacuation thresholds grounded strictly in Brain Trauma Foundation (BTF) guidelines.
            </p>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
            {/* Left Controls */}
            <div className="lg:col-span-5 space-y-5 p-6 rounded-2xl bg-slate-900/60 border border-slate-800">
              <div className="text-sm font-semibold text-white">Select Acute Intracranial Crisis:</div>
              <div className="grid grid-cols-2 gap-2">
                <button
                  onClick={() => setSelectedPathology('edh')}
                  className={`p-3 rounded-xl text-left border transition-all text-xs cursor-pointer ${
                    selectedPathology === 'edh'
                      ? 'bg-red-950/60 border-red-500 text-white font-semibold'
                      : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-slate-200'
                  }`}
                >
                  <strong className="block text-red-400 mb-0.5">Epidural (EDH)</strong>
                  Biconvex arterial bleed
                </button>
                <button
                  onClick={() => setSelectedPathology('sdh')}
                  className={`p-3 rounded-xl text-left border transition-all text-xs cursor-pointer ${
                    selectedPathology === 'sdh'
                      ? 'bg-blue-950/60 border-blue-500 text-white font-semibold'
                      : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-slate-200'
                  }`}
                >
                  <strong className="block text-blue-400 mb-0.5">Subdural (SDH)</strong>
                  Crescentic bridging vein
                </button>
                <button
                  onClick={() => setSelectedPathology('uncal')}
                  className={`p-3 rounded-xl text-left border transition-all text-xs cursor-pointer ${
                    selectedPathology === 'uncal'
                      ? 'bg-amber-950/60 border-amber-500 text-white font-semibold'
                      : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-slate-200'
                  }`}
                >
                  <strong className="block text-amber-400 mb-0.5">Uncal Herniation</strong>
                  Ambient cistern collapse
                </button>
                <button
                  onClick={() => setSelectedPathology('postfossa')}
                  className={`p-3 rounded-xl text-left border transition-all text-xs cursor-pointer ${
                    selectedPathology === 'postfossa'
                      ? 'bg-purple-950/60 border-purple-500 text-white font-semibold'
                      : 'bg-slate-950 border-slate-800 text-slate-400 hover:text-slate-200'
                  }`}
                >
                  <strong className="block text-purple-400 mb-0.5">Posterior Fossa</strong>
                  4th Ventricle compression
                </button>
              </div>

              {/* Sliders for EDH / SDH */}
              <div className="space-y-4 pt-2">
                <div>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-slate-300">Hematoma Volume (ABC/2):</span>
                    <span className="font-mono font-bold text-cyan-400">{edhVolume} mL</span>
                  </div>
                  <input
                    type="range"
                    min="5"
                    max="80"
                    value={edhVolume}
                    onChange={(e) => setEdhVolume(Number(e.target.value))}
                    className="w-full accent-cyan-400 cursor-pointer"
                  />
                  <div className="flex justify-between text-[10px] text-slate-500 font-mono">
                    <span>5 mL</span>
                    <span className="text-red-400 font-semibold">BTF Threshold: &gt;30 mL</span>
                    <span>80 mL</span>
                  </div>
                </div>

                <div>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-slate-300">Max Thickness:</span>
                    <span className="font-mono font-bold text-indigo-400">{edhThickness} mm</span>
                  </div>
                  <input
                    type="range"
                    min="3"
                    max="35"
                    value={edhThickness}
                    onChange={(e) => setEdhThickness(Number(e.target.value))}
                    className="w-full accent-indigo-400 cursor-pointer"
                  />
                  <div className="flex justify-between text-[10px] text-slate-500 font-mono">
                    <span>3 mm</span>
                    <span className="text-red-400 font-semibold">BTF Threshold: &gt;15 mm</span>
                    <span>35 mm</span>
                  </div>
                </div>

                <div>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-slate-300">Midline Shift (Septum Pellucidum):</span>
                    <span className="font-mono font-bold text-purple-400">{midlineShift} mm</span>
                  </div>
                  <input
                    type="range"
                    min="0"
                    max="20"
                    value={midlineShift}
                    onChange={(e) => setMidlineShift(Number(e.target.value))}
                    className="w-full accent-purple-400 cursor-pointer"
                  />
                  <div className="flex justify-between text-[10px] text-slate-500 font-mono">
                    <span>0 mm</span>
                    <span className="text-red-400 font-semibold">BTF Threshold: &gt;5 mm</span>
                    <span>20 mm</span>
                  </div>
                </div>
              </div>
            </div>

            {/* Right Verdict Banner */}
            <div className="lg:col-span-7 space-y-6">
              <div className={`p-6 sm:p-8 rounded-2xl border transition-all ${
                edhVolume > 30 || edhThickness > 15 || midlineShift > 5
                  ? 'bg-red-950/40 border-red-500/60 shadow-xl shadow-red-950/50'
                  : 'bg-emerald-950/30 border-emerald-500/40'
              }`}>
                <div className="flex items-center gap-2 mb-3">
                  {edhVolume > 30 || edhThickness > 15 || midlineShift > 5 ? (
                    <>
                      <AlertTriangle className="w-6 h-6 text-red-400 animate-bounce" />
                      <span className="text-xs font-mono font-bold text-red-300 uppercase tracking-widest">
                        CRITICAL EMERGENCY INDICATION • IMMEDIATE OR EVACUATION
                      </span>
                    </>
                  ) : (
                    <>
                      <ShieldCheck className="w-6 h-6 text-emerald-400" />
                      <span className="text-xs font-mono font-bold text-emerald-300 uppercase tracking-widest">
                        SUB-THRESHOLD • ICU NEURO-OBSERVATION & SERIAL CT
                      </span>
                    </>
                  )}
                </div>

                <h3 className="text-2xl font-bold text-white mb-3">
                  {edhVolume > 30 || edhThickness > 15 || midlineShift > 5
                    ? 'Operative Indications Met: Emergent Craniotomy'
                    : 'Non-Operative Protocol: Strict ICU Neuromonitoring'}
                </h3>

                <p className="text-sm text-slate-300 leading-relaxed mb-6">
                  {edhVolume > 30 || edhThickness > 15 || midlineShift > 5
                    ? 'Per Brain Trauma Foundation Guidelines: An epidural hematoma with volume >30 cm³ should be surgically evacuated regardless of the patient’s Glasgow Coma Scale (GCS) score. Thickness >15 mm or midline shift >5 mm independently mandate operative decompression.'
                    : 'Current hematoma metrics do not breach absolute surgical threshold. Patient may undergo serial neurological evaluations and follow-up non-contrast head CT in 6 hours, provided GCS is >8 and no pupillary asymmetry or focal deficit exists.'}
                </p>

                <div className="grid grid-cols-3 gap-3 text-center font-mono">
                  <div className="p-3 rounded-xl bg-slate-900/80 border border-slate-800">
                    <div className="text-[10px] text-slate-400 uppercase">Volume Status</div>
                    <div className={`text-sm font-bold mt-1 ${edhVolume > 30 ? 'text-red-400' : 'text-emerald-400'}`}>
                      {edhVolume > 30 ? 'CRITICAL (>30)' : 'STABLE (<30)'}
                    </div>
                  </div>
                  <div className="p-3 rounded-xl bg-slate-900/80 border border-slate-800">
                    <div className="text-[10px] text-slate-400 uppercase">Thickness</div>
                    <div className={`text-sm font-bold mt-1 ${edhThickness > 15 ? 'text-red-400' : 'text-emerald-400'}`}>
                      {edhThickness > 15 ? 'CRITICAL (>15)' : 'STABLE (<15)'}
                    </div>
                  </div>
                  <div className="p-3 rounded-xl bg-slate-900/80 border border-slate-800">
                    <div className="text-[10px] text-slate-400 uppercase">Midline Shift</div>
                    <div className={`text-sm font-bold mt-1 ${midlineShift > 5 ? 'text-red-400' : 'text-emerald-400'}`}>
                      {midlineShift > 5 ? 'HERNIATING (>5)' : 'STABLE (<5)'}
                    </div>
                  </div>
                </div>
              </div>

              {/* SBAR Copier Box */}
              <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex items-center justify-between gap-4 flex-wrap">
                <div>
                  <div className="text-xs font-semibold text-white">Attending SBAR Teleprompter Integration</div>
                  <div className="text-xs text-slate-400">1-Tap formatted case transfer for phone call, Epic Haiku, or iMessage.</div>
                </div>
                <button
                  onClick={handleCopySbar}
                  className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-cyan-950 hover:bg-cyan-900 border border-cyan-800/80 text-cyan-300 text-xs font-semibold font-mono cursor-pointer transition-all"
                >
                  {copiedSbar ? (
                    <>
                      <Check className="w-3.5 h-3.5 text-emerald-400" />
                      <span className="text-emerald-300">Copied to Clipboard!</span>
                    </>
                  ) : (
                    <>
                      <Copy className="w-3.5 h-3.5" />
                      <span>Copy Attending SBAR</span>
                    </>
                  )}
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── Pillar 3: Frontline ER Triage & 5 Phases ─── */}
      <section id="triage" className="py-20 px-4 sm:px-8 border-b border-slate-800/80 bg-[#080c16]">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-3xl mx-auto mb-14">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-950/60 border border-indigo-800/60 text-indigo-300 text-xs font-mono font-medium mb-3">
              <Stethoscope className="w-3.5 h-3.5" />
              Frontline Emergency Triage
            </div>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-white tracking-tight mb-4">
              5-Phase Rapid Emergency Triage Protocol
            </h2>
            <p className="text-slate-400 text-sm sm:text-base leading-relaxed">
              Engineered to eliminate cognitive overload during catastrophic multi-trauma admissions and acute herniation crises.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
            <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
              <div>
                <span className="text-xs font-mono font-bold text-cyan-400 mb-2 block">PHASE 01</span>
                <h4 className="text-base font-bold text-white mb-2">Airway & Hemodynamics</h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Endotracheal intubation if GCS ≤8. Maintain SBP ≥100 mmHg (or MAP ≥80). Avoid hypoxemia (PaO₂ &lt;60 mmHg).
                </p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-800 text-[10px] font-mono text-cyan-300">Target: CPP 60-70</div>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
              <div>
                <span className="text-xs font-mono font-bold text-indigo-400 mb-2 block">PHASE 02</span>
                <h4 className="text-base font-bold text-white mb-2">Coagulopathy Reversal</h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Identify oral anticoagulants. Administer 4-Factor PCC (Kcentra) for warfarin, Idarucizumab for dabigatran, Andexanet for Xa inhibitors.
                </p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-800 text-[10px] font-mono text-indigo-300">INR Goal: &lt;1.4</div>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
              <div>
                <span className="text-xs font-mono font-bold text-purple-400 mb-2 block">PHASE 03</span>
                <h4 className="text-base font-bold text-white mb-2">Osmotherapy Bolus</h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Transtentorial herniation or blown pupil: 3% Hypertonic Saline 250-500 mL bolus or Mannitol 20% (1 g/kg IV push).
                </p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-800 text-[10px] font-mono text-purple-300">Na Target: 145-155</div>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
              <div>
                <span className="text-xs font-mono font-bold text-pink-400 mb-2 block">PHASE 04</span>
                <h4 className="text-base font-bold text-white mb-2">Bedside Hardware</h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Immediate Kocher&apos;s Point External Ventricular Drain (EVD) or Camino parenchymal ICP bolt if hydrocephalus or unmonitorable exam.
                </p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-800 text-[10px] font-mono text-pink-300">Level at Tragus</div>
            </div>

            <div className="p-5 rounded-2xl bg-slate-900/60 border border-slate-800 flex flex-col justify-between">
              <div>
                <span className="text-xs font-mono font-bold text-amber-400 mb-2 block">PHASE 05</span>
                <h4 className="text-base font-bold text-white mb-2">Operative Decompression</h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  Mobilize Trauma OR. Frontotemporoparietal trauma craniectomy with duraplasty. Bone flap banked or frozen.
                </p>
              </div>
              <div className="mt-4 pt-3 border-t border-slate-800 text-[10px] font-mono text-amber-300">Door-to-Cut: &lt;60 min</div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── Pillar 4: Clinical Calculators & Decision Hub ─── */}
      <section id="calculators" className="py-20 px-4 sm:px-8 border-b border-slate-800/80">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-3xl mx-auto mb-14">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-950/60 border border-emerald-800/60 text-emerald-300 text-xs font-mono font-medium mb-3">
              <Cpu className="w-3.5 h-3.5" />
              Mathematical Decision Engines
            </div>
            <h2 className="text-3xl sm:text-4xl font-extrabold text-white tracking-tight mb-4">
              Deterministic Neurosurgical Calculators
            </h2>
            <p className="text-slate-400 text-sm sm:text-base leading-relaxed">
              Zero guessing. Instant bedside scoring for CPP, Hemphill ICH volume, Fisher, Hunt & Hess, and SLICS/TLICS.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {/* Live Interactive CPP Calculator */}
            <div className="p-6 sm:p-8 rounded-2xl bg-slate-900/80 border border-slate-800">
              <div className="flex items-center justify-between mb-4">
                <h3 className="text-lg font-bold text-white flex items-center gap-2">
                  <Activity className="w-5 h-5 text-cyan-400" />
                  Cerebral Perfusion Pressure (CPP) Engine
                </h3>
                <span className="text-xs font-mono text-cyan-400 bg-cyan-950 px-2 py-0.5 rounded border border-cyan-800">CPP = MAP - ICP</span>
              </div>

              <div className="space-y-4 my-6">
                <div>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-slate-300">Mean Arterial Pressure (MAP):</span>
                    <span className="font-mono font-bold text-white">{mapVal} mmHg</span>
                  </div>
                  <input
                    type="range"
                    min="50"
                    max="140"
                    value={mapVal}
                    onChange={(e) => setMapVal(Number(e.target.value))}
                    className="w-full accent-cyan-400 cursor-pointer"
                  />
                </div>

                <div>
                  <div className="flex justify-between text-xs mb-1">
                    <span className="text-slate-300">Intracranial Pressure (ICP):</span>
                    <span className="font-mono font-bold text-white">{icpVal} mmHg</span>
                  </div>
                  <input
                    type="range"
                    min="0"
                    max="50"
                    value={icpVal}
                    onChange={(e) => setIcpVal(Number(e.target.value))}
                    className="w-full accent-indigo-400 cursor-pointer"
                  />
                </div>
              </div>

              <div className={`p-4 rounded-xl border flex items-center justify-between ${
                cppVal >= 60 && cppVal <= 70
                  ? 'bg-emerald-950/40 border-emerald-500/50 text-emerald-200'
                  : cppVal < 60
                  ? 'bg-red-950/40 border-red-500/50 text-red-200'
                  : 'bg-amber-950/40 border-amber-500/50 text-amber-200'
              }`}>
                <div>
                  <div className="text-xs font-mono uppercase tracking-wider">Calculated CPP</div>
                  <div className="text-2xl font-bold font-mono mt-0.5">{cppVal} mmHg</div>
                </div>
                <div className="text-right text-xs">
                  {cppVal >= 60 && cppVal <= 70 && (
                    <span className="font-semibold text-emerald-400 block">OPTIMAL PERFUSION (60-70)</span>
                  )}
                  {cppVal < 60 && (
                    <span className="font-semibold text-red-400 block">ISCHEMIA RISK (&lt;60) • INCREASE MAP</span>
                  )}
                  {cppVal > 70 && (
                    <span className="font-semibold text-amber-400 block">HYPERPERFUSION / ARDS RISK (&gt;70)</span>
                  )}
                  <span className="text-[11px] text-slate-400">BTF Guideline Target: 60–70 mmHg</span>
                </div>
              </div>
            </div>

            {/* Comprehensive Decision Engines List */}
            <div className="space-y-3">
              <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800 flex items-start gap-3">
                <div className="p-2 rounded-lg bg-cyan-950 text-cyan-400 mt-0.5">
                  <Scale className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-sm font-semibold text-white">Hemphill ICH Score & ABC/2 Volume</h4>
                  <p className="text-xs text-slate-400 mt-0.5">Predicts 30-day mortality based on GCS, ICH volume (&gt;30 mL), intraventricular extension, infratentorial origin, and age.</p>
                </div>
              </div>

              <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800 flex items-start gap-3">
                <div className="p-2 rounded-lg bg-indigo-950 text-indigo-400 mt-0.5">
                  <Brain className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-sm font-semibold text-white">Hunt & Hess + WFNS SAH Grading</h4>
                  <p className="text-xs text-slate-400 mt-0.5">Aneurysmal subarachnoid hemorrhage clinical severity scoring coupled with Modified Fisher CT vasospasm risk prediction.</p>
                </div>
              </div>

              <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800 flex items-start gap-3">
                <div className="p-2 rounded-lg bg-purple-950 text-purple-400 mt-0.5">
                  <Compass className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-sm font-semibold text-white">Spinal Trauma Scores: SLICS & TLICS</h4>
                  <p className="text-xs text-slate-400 mt-0.5">Subaxial and Thoracolumbar injury classification assessing morphology, disco-ligamentous complex, and neurological status to guide surgery.</p>
                </div>
              </div>

              <div className="p-4 rounded-xl bg-slate-900/60 border border-slate-800 flex items-start gap-3">
                <div className="p-2 rounded-lg bg-emerald-950 text-emerald-400 mt-0.5">
                  <Shield className="w-4 h-4" />
                </div>
                <div>
                  <h4 className="text-sm font-semibold text-white">Spinal Instability Neoplastic Score (SINS)</h4>
                  <p className="text-xs text-slate-400 mt-0.5">Standardized 0-18 scale determining surgical vs radiation oncological management for metastatic spine disease.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ─── Medical Governance & Citations ─── */}
      <section className="py-16 px-4 sm:px-8 border-b border-slate-800/80 bg-[#080c16]">
        <div className="max-w-4xl mx-auto text-center">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-slate-900 border border-slate-800 text-slate-400 text-xs font-mono mb-4">
            <FileText className="w-3.5 h-3.5" />
            Clinical Evidence & Institutional Governance
          </div>
          <h3 className="text-2xl font-bold text-white mb-4">
            Peer-Reviewed Clinical Foundation
          </h3>
          <p className="text-sm text-slate-300 leading-relaxed mb-8">
            NeuroCall synthesizes decades of landmark neurosurgical literature and consensus guidelines into rapid bedside decision pathways:
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-3 text-xs text-left">
            <div className="p-4 rounded-xl bg-slate-950 border border-slate-800/80">
              <strong className="text-cyan-400 block mb-1">Brain Trauma Foundation</strong>
              <p className="text-slate-400">Management of Severe Traumatic Brain Injury (4th Edition). Guidelines for ICP & CPP thresholds.</p>
            </div>
            <div className="p-4 rounded-xl bg-slate-950 border border-slate-800/80">
              <strong className="text-indigo-400 block mb-1">AANS / CNS Guidelines</strong>
              <p className="text-slate-400">Surgical Management of Traumatic Brain Injury & Acute Cervical Spine Dislocation.</p>
            </div>
            <div className="p-4 rounded-xl bg-slate-950 border border-slate-800/80">
              <strong className="text-purple-400 block mb-1">AHA / ASA Stroke Council</strong>
              <p className="text-slate-400">Guidelines for the Management of Spontaneous Intracerebral Hemorrhage (ICH) & SAH.</p>
            </div>
            <div className="p-4 rounded-xl bg-slate-950 border border-slate-800/80">
              <strong className="text-pink-400 block mb-1">AOSpine & SLICS Group</strong>
              <p className="text-slate-400">Subaxial Cervical Spine Injury Classification System & TLICS thoracolumbar algorithm.</p>
            </div>
          </div>
        </div>
      </section>

      {/* ─── Mandatory Clinical Disclaimer (Guideline 1.4.1) ─── */}
      <section className="py-10 px-4 sm:px-8 border-b border-slate-800/80 bg-slate-950">
        <div className="max-w-4xl mx-auto p-6 rounded-2xl bg-amber-950/20 border border-amber-500/30 text-xs text-amber-200/80 leading-relaxed">
          <div className="flex items-center gap-2 text-amber-300 font-semibold mb-2">
            <AlertTriangle className="w-4 h-4" />
            <span>MANDATORY CLINICAL REFERENCE DISCLAIMER (Apple App Store Guideline 1.4.1 Compliant)</span>
          </div>
          <p>
            NeuroCall is engineered strictly as an educational and bedside reference tool for neurosurgeons, spine surgeons, neurocritical care teams,
            and surgical residents on call. The clinical scores, hematoma calipers, and algorithms provided within this software are clinical decision-support aids
            and do NOT replace direct physical examination, institutional protocols, or independent surgical judgment.
            Neither the author nor any affiliated medical center assumes liability for clinical decisions rendered using this application.
          </p>
        </div>
      </section>

      {/* ─── Footer ─── */}
      <footer className="border-t border-slate-800/80 bg-[#060810] py-12 px-4 sm:px-8 text-xs text-slate-400">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6">
          <div className="flex items-center gap-3">
            <Brain className="w-5 h-5 text-cyan-400" />
            <div>
              <div className="text-sm font-bold text-white">NeuroCall</div>
              <div className="text-[11px] text-slate-500">Operative Neurosurgery & Emergency Decision Support</div>
            </div>
          </div>

          <div className="flex items-center gap-6 font-medium">
            <button onClick={() => onNavigate('/')} className="hover:text-cyan-400 transition-colors cursor-pointer">Home</button>
            <a href="#atlas" className="hover:text-cyan-400 transition-colors">106 Plates</a>
            <a href="#calipers" className="hover:text-cyan-400 transition-colors">Crisis CT</a>
            <button onClick={() => onNavigate('/privacy')} className="hover:text-cyan-400 transition-colors cursor-pointer">Privacy Policy</button>
            <button onClick={() => onNavigate('/support')} className="hover:text-cyan-400 transition-colors cursor-pointer">Support</button>
            <a
              href="https://apps.apple.com/app/id6821489631"
              target="_blank"
              rel="noopener noreferrer"
              className="text-cyan-400 hover:text-cyan-300 transition-colors flex items-center gap-1"
            >
              <span>App Store</span>
              <ExternalLink className="w-3 h-3" />
            </a>
          </div>

          <div className="text-center md:text-right text-slate-500">
            <div>© 2026 A. Alex Mohit. All rights reserved.</div>
            <div className="mt-0.5">Developed by A. Alex Mohit, MD, PhD • Seattle, WA</div>
          </div>
        </div>
      </footer>
    </div>
  );
};
