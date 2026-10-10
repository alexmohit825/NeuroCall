import React from 'react';
import { Zap } from 'lucide-react';

export const DoubleCrushMatrix: React.FC = () => {
  const pathways = [
    {
      title: 'Cervical Root (C6) + Median Nerve (Carpal Tunnel)',
      proximalSite: 'C5/C6 Neural Foramen (Osteophytes / Herniation)',
      distalSite: 'Transverse Carpal Ligament (Flexor Retinaculum)',
      mechanism: 'Impaired fast anterograde axoplasmic transport (kinesin motors) starves distal median axonal segments, predisposing to compression by normal physiological compartment pressures.',
      prevalence: 'Up to 40% of refractory CTS cases exhibit tandem cervical spondylosis.',
      clinicalPearl: 'Decompressing the neck often resolves mild wrist paresthesias; releasing the wrist eliminates hand nocturnal waking without resolving neck pain.'
    },
    {
      title: 'Cervical Root (C8/T1) + Ulnar Nerve (Cubital Tunnel)',
      proximalSite: 'C7/T1 Neural Foramen or Cervical Rib / Scalene Band',
      distalSite: 'Osborne Ligament & Retrocondylar Groove at Elbow',
      mechanism: 'Subclinical root irritation weakens ulnar Schwann cell sheath maintenance, increasing susceptibility to repetitive traction during elbow flexion.',
      prevalence: 'Common in manual laborers and overhead athletes.',
      clinicalPearl: 'Check medial antebrachial cutaneous sensation and APB power before isolated cubital tunnel release.'
    },
    {
      title: 'Lumbar Root (L5) + Common Peroneal Nerve (Fibular Head)',
      proximalSite: 'L4/L5 Foraminal Stenosis or Far-Lateral Disc',
      distalSite: 'Fibro-osseous Tunnel at Peroneus Longus Origin / Fibular Neck',
      mechanism: 'Axons innervating the anterior compartment of the lower leg suffer ischemic metabolic stress at the lumbar root, making them exquisitely fragile to external pressure (e.g., knee casting, habitual leg crossing).',
      prevalence: 'Frequent cause of sudden-onset "catastrophic" foot drop following minor external pressure.',
      clinicalPearl: 'Always test Tibialis Posterior (foot inversion) and examine L4/L5 on MRI before attributing foot drop solely to habitual leg crossing.'
    }
  ];

  return (
    <div className="space-y-6">
      <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-6 backdrop-blur-sm">
        <div className="flex items-center gap-3 mb-2">
          <div className="w-9 h-9 rounded-xl bg-rose-950 border border-rose-700/60 flex items-center justify-center text-rose-300">
            <Zap className="w-5 h-5" />
          </div>
          <div>
            <h2 className="text-lg font-black text-white tracking-tight">
              Tandem Double-Crush Matrix (Upton & McComas Principle)
            </h2>
            <p className="text-xs text-slate-400">
              Biomechanical & axoplasmic transport pathophysiology of multi-level serial compressions.
            </p>
          </div>
        </div>

        <div className="bg-slate-950/60 rounded-xl p-4 border border-slate-800/80 mt-4 text-xs text-slate-300 leading-relaxed">
          The <strong>Double-Crush Hypothesis</strong> dictates that serial compressions along an axon act synergistically. A proximal lesion (such as cervical spondylotic radiculopathy) that interrupts axoplasmic flow renders distal axonal segments vulnerable to secondary entrapment at peripheral anatomical bottlenecks that would otherwise remain asymptomatic.
        </div>
      </div>

      <div className="grid grid-cols-1 gap-4">
        {pathways.map((item, index) => (
          <div
            key={index}
            className="bg-slate-900/80 border border-slate-800 rounded-3xl p-6 backdrop-blur-md shadow-xl"
          >
            <div className="flex items-center gap-2 mb-3">
              <span className="text-xs font-black uppercase px-2.5 py-0.5 rounded-full bg-rose-950 text-rose-400 border border-rose-800/60">
                Pattern #{index + 1}
              </span>
              <h3 className="text-base sm:text-lg font-bold text-white">
                {item.title}
              </h3>
            </div>

            {/* Serial compression diagram */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-4">
              <div className="bg-indigo-950/30 border border-indigo-800/40 rounded-xl p-3.5">
                <span className="text-[10px] font-bold uppercase tracking-wider text-indigo-400">
                  Primary Proximal Crush (Root / Trunk)
                </span>
                <div className="text-xs font-bold text-slate-100 mt-1">
                  {item.proximalSite}
                </div>
              </div>

              <div className="bg-cyan-950/30 border border-cyan-800/40 rounded-xl p-3.5">
                <span className="text-[10px] font-bold uppercase tracking-wider text-cyan-400">
                  Secondary Distal Crush (Peripheral Canal)
                </span>
                <div className="text-xs font-bold text-slate-100 mt-1">
                  {item.distalSite}
                </div>
              </div>
            </div>

            <div className="space-y-2.5 text-xs text-slate-300">
              <div>
                <strong className="text-slate-100">Axoplasmic Mechanism: </strong>
                {item.mechanism}
              </div>
              <div>
                <strong className="text-slate-100">Surgical & Clinical Implication: </strong>
                {item.clinicalPearl}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
