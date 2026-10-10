import React from 'react';
import { BookOpen, CheckCircle, XCircle } from 'lucide-react';

export const EMGGuide: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Intro */}
      <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-6 backdrop-blur-sm">
        <div className="flex items-center gap-3 mb-2">
          <div className="w-9 h-9 rounded-xl bg-violet-950 border border-violet-700/60 flex items-center justify-center text-violet-300">
            <BookOpen className="w-5 h-5" />
          </div>
          <div>
            <h2 className="text-lg font-black text-white tracking-tight">
              EMG & NCS Electrodiagnostic Principles for Spine vs. Nerve
            </h2>
            <p className="text-xs text-slate-400">
              The definitive pre-ganglionic vs. post-ganglionic electrophysiological decision tree.
            </p>
          </div>
        </div>
      </div>

      {/* The Golden Rule of SNAPs */}
      <div className="bg-slate-900/80 border border-slate-800 rounded-3xl p-6 sm:p-8 backdrop-blur-md shadow-xl">
        <div className="flex items-center gap-2 mb-3">
          <span className="text-xs font-black uppercase px-2.5 py-0.5 rounded-full bg-amber-950 text-amber-400 border border-amber-800/60">
            Core Electrophysiological Axiom
          </span>
          <h3 className="text-base sm:text-lg font-bold text-white">
            The Sensory Nerve Action Potential (SNAP) Paradox
          </h3>
        </div>

        <p className="text-xs sm:text-sm text-slate-300 leading-relaxed mb-4">
          Because the <strong>Dorsal Root Ganglion (DRG)</strong> lies outside the spinal cord inside or just distal to the neural foramen, radiculopathies are almost always <strong>PRE-GANGLIONIC</strong> lesions. The sensory cell bodies and their peripheral axonal projections remain completely intact!
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="bg-indigo-950/30 border border-indigo-800/40 rounded-2xl p-5">
            <div className="flex items-center gap-2 mb-2">
              <CheckCircle className="w-5 h-5 text-indigo-400" />
              <h4 className="text-xs font-bold uppercase tracking-wider text-indigo-200">
                Pre-Ganglionic Root Lesion (Radiculopathy)
              </h4>
            </div>
            <ul className="space-y-2 text-xs text-slate-300">
              <li>• <strong>SNAP Amplitude:</strong> NORMAL in the numb dermatome! (Sensory axon is continuous with its intact ganglion cell body).</li>
              <li>• <strong>Needle EMG Paraspinals:</strong> Fibrillations and positive sharp waves present in posterior primary rami innervated multifidi.</li>
              <li>• <strong>CMAP:</strong> Normal unless severe motor axon loss.</li>
            </ul>
          </div>

          <div className="bg-cyan-950/30 border border-cyan-800/40 rounded-2xl p-5">
            <div className="flex items-center gap-2 mb-2">
              <XCircle className="w-5 h-5 text-cyan-400" />
              <h4 className="text-xs font-bold uppercase tracking-wider text-cyan-200">
                Post-Ganglionic Nerve Lesion (Peripheral Entrapment)
              </h4>
            </div>
            <ul className="space-y-2 text-xs text-slate-300">
              <li>• <strong>SNAP Amplitude:</strong> REDUCED or ABSENT across the entrapment canal (Wallerian degeneration of distal sensory axons).</li>
              <li>• <strong>Needle EMG Paraspinals:</strong> 100% NORMAL (Paraspinals are innervated far proximal to peripheral nerve).</li>
              <li>• <strong>Conduction Velocity:</strong> Focal slowing or conduction block across the ligament/tunnel.</li>
            </ul>
          </div>
        </div>
      </div>

      {/* Muscle Needle EMG Sampling Table */}
      <div className="bg-slate-900/80 border border-slate-800 rounded-3xl p-6 backdrop-blur-md shadow-xl">
        <h3 className="text-base font-bold text-white mb-3">
          Recommended Needle EMG Muscle Sampling Protocol
        </h3>
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs border-collapse">
            <thead>
              <tr className="border-b border-slate-800 text-slate-400 font-bold uppercase tracking-wider">
                <th className="py-2.5 px-3">Suspected Level</th>
                <th className="py-2.5 px-3">Primary Root Muscles</th>
                <th className="py-2.5 px-3">Key Differentiating Non-Index Muscle</th>
                <th className="py-2.5 px-3">Paraspinal Segment</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800/60 text-slate-300">
              <tr>
                <td className="py-3 px-3 font-bold text-indigo-400">C6 Root</td>
                <td className="py-3 px-3">Biceps, Brachioradialis, Pronator Teres</td>
                <td className="py-3 px-3 text-cyan-300">Pronator Teres (Spared in CTS)</td>
                <td className="py-3 px-3">C5-C6 Paraspinals</td>
              </tr>
              <tr>
                <td className="py-3 px-3 font-bold text-indigo-400">C7 Root</td>
                <td className="py-3 px-3">Triceps, FCR, EDC</td>
                <td className="py-3 px-3 text-cyan-300">Latissimus Dorsi (Spared in Radial Palsy)</td>
                <td className="py-3 px-3">C6-C7 Paraspinals</td>
              </tr>
              <tr>
                <td className="py-3 px-3 font-bold text-indigo-400">C8/T1 Root</td>
                <td className="py-3 px-3">FDI, ADM, APB, FPL</td>
                <td className="py-3 px-3 text-cyan-300">APB & FPL (Spared in Ulnar Neuropathy)</td>
                <td className="py-3 px-3">C7-T1 Paraspinals</td>
              </tr>
              <tr>
                <td className="py-3 px-3 font-bold text-indigo-400">L4 Root</td>
                <td className="py-3 px-3">Quadriceps, Tibialis Anterior</td>
                <td className="py-3 px-3 text-cyan-300">Adductor Longus (Spared in Femoral Palsy)</td>
                <td className="py-3 px-3">L3-L4 Paraspinals</td>
              </tr>
              <tr>
                <td className="py-3 px-3 font-bold text-indigo-400">L5 Root</td>
                <td className="py-3 px-3">Tibialis Anterior, EHL, Peroneus Longus</td>
                <td className="py-3 px-3 text-cyan-300">Tibialis Posterior & Glut Medius (Spared in Peroneal)</td>
                <td className="py-3 px-3">L4-L5 Paraspinals</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
