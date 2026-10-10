import React from 'react';
import { REFLEXES, PATHOGNOMONIC_TESTS } from '../engine/data';
import type { SpinalRegion } from '../engine/types';
import { CheckCircle2, XCircle, MinusCircle } from 'lucide-react';

interface ReflexesAndTestsProps {
  region: SpinalRegion;
  reflexScores: Record<string, number>;
  positiveTests: Record<string, boolean>;
  onUpdateReflex: (reflexId: string, score: number) => void;
  onUpdateTest: (testId: string, status: boolean | undefined) => void;
}

export const ReflexesAndTests: React.FC<ReflexesAndTestsProps> = ({
  region,
  reflexScores,
  positiveTests,
  onUpdateReflex,
  onUpdateTest,
}) => {
  const filteredReflexes = REFLEXES.filter(r =>
    region === 'cervical'
      ? ['C5', 'C6', 'C7'].includes(r.root)
      : ['L4', 'S1'].includes(r.root)
  );

  const filteredTests = PATHOGNOMONIC_TESTS.filter(t => t.region === region);

  return (
    <div className="space-y-6">
      {/* Deep Tendon Reflexes */}
      <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 backdrop-blur-sm">
        <div className="mb-4">
          <div className="flex items-center gap-2">
            <h3 className="text-sm font-bold text-slate-100 flex items-center gap-2">
              <span className="w-2.5 h-2.5 rounded-full bg-violet-400"></span>
              Deep Tendon Reflexes (0 – 4+)
            </h3>
            <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-violet-950 text-violet-300 border border-violet-800/60">
              Monosynaptic Arc
            </span>
          </div>
          <p className="text-xs text-slate-400 mt-0.5">
            Hyporeflexia (0 or 1+) indicates lower motor neuron or root/nerve disruption.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
          {filteredReflexes.map(reflex => {
            const currentGrade = reflexScores[reflex.id] ?? 2;
            return (
              <div
                key={reflex.id}
                className="p-3.5 rounded-xl bg-slate-950/40 border border-slate-800/80 flex flex-col justify-between"
              >
                <div>
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-xs font-bold text-slate-200">{reflex.name}</span>
                    <span className="text-[11px] font-bold px-2 py-0.5 rounded bg-indigo-950 text-indigo-300 border border-indigo-800/50">
                      Root {reflex.root}
                    </span>
                  </div>
                  <div className="text-[11px] text-slate-400">
                    Arc: <strong className="text-cyan-300">{reflex.peripheralNerve}</strong> ({reflex.tendon})
                  </div>
                </div>

                <div className="flex items-center justify-between mt-3 pt-2 border-t border-slate-800/60">
                  <span className="text-[10px] uppercase font-bold text-slate-400">Grade:</span>
                  <div className="flex items-center gap-1">
                    {[
                      { grade: 0, label: '0 (Absent)', color: 'bg-rose-950 text-rose-300' },
                      { grade: 1, label: '1+ (Hypo)', color: 'bg-amber-950 text-amber-300' },
                      { grade: 2, label: '2+ (Normal)', color: 'bg-emerald-950 text-emerald-300' },
                      { grade: 3, label: '3+ (Brisk)', color: 'bg-indigo-950 text-indigo-300' },
                    ].map(opt => (
                      <button
                        key={opt.grade}
                        onClick={() => onUpdateReflex(reflex.id, opt.grade)}
                        className={`text-[10px] px-2 py-0.5 rounded font-medium transition-all ${
                          currentGrade === opt.grade
                            ? `${opt.color} ring-1 ring-white/30 font-bold shadow`
                            : 'bg-slate-900 text-slate-400 hover:text-slate-200'
                        }`}
                      >
                        {opt.label}
                      </button>
                    ))}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Pathognomonic Maneuvers Switchboard */}
      <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 backdrop-blur-sm">
        <div className="mb-4">
          <div className="flex items-center gap-2">
            <h3 className="text-sm font-bold text-slate-100 flex items-center gap-2">
              <span className="w-2.5 h-2.5 rounded-full bg-emerald-400"></span>
              Pathognomonic Provocative Maneuvers
            </h3>
            <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-emerald-950 text-emerald-300 border border-emerald-800/60">
              Physical Arbitrators
            </span>
          </div>
          <p className="text-xs text-slate-400 mt-0.5">
            Definitive clinical physical exam tests designed to arbitrate root vs. peripheral nerve entrapment.
          </p>
        </div>

        <div className="space-y-3">
          {filteredTests.map(test => {
            const status = positiveTests[test.id]; // true = positive, false = negative, undefined = not done

            return (
              <div
                key={test.id}
                className={`p-3.5 rounded-xl border transition-all ${
                  status === true
                    ? 'bg-indigo-950/40 border-indigo-500/80 shadow-md shadow-indigo-950/20'
                    : status === false
                    ? 'bg-slate-950/50 border-slate-800/60 opacity-75'
                    : 'bg-slate-950/30 border-slate-800/80'
                }`}
              >
                <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-3 mb-2">
                  <div>
                    <div className="flex items-center gap-2">
                      <span className="text-xs font-bold text-slate-100">{test.name}</span>
                      <span className="text-[10px] px-2 py-0.5 rounded font-bold uppercase tracking-wider bg-slate-800 text-slate-300">
                        {test.targets.join(' / ')}
                      </span>
                    </div>
                    <p className="text-xs text-slate-300 mt-1">{test.procedure}</p>
                    <div className="text-[11px] text-emerald-400/90 mt-1 font-medium">
                      Positive finding: {test.positiveIndication}
                    </div>
                  </div>

                  {/* Status buttons */}
                  <div className="flex items-center gap-1.5 shrink-0 self-start sm:self-auto">
                    <button
                      onClick={() => onUpdateTest(test.id, true)}
                      className={`flex items-center gap-1 text-xs px-2.5 py-1 rounded-lg font-bold transition-all ${
                        status === true
                          ? 'bg-emerald-600 text-white shadow ring-1 ring-white/30'
                          : 'bg-slate-900 text-slate-400 hover:text-emerald-300 hover:bg-emerald-950/50'
                      }`}
                    >
                      <CheckCircle2 className="w-3.5 h-3.5" />
                      <span>Positive</span>
                    </button>

                    <button
                      onClick={() => onUpdateTest(test.id, false)}
                      className={`flex items-center gap-1 text-xs px-2.5 py-1 rounded-lg font-medium transition-all ${
                        status === false
                          ? 'bg-rose-900/80 text-rose-200 shadow ring-1 ring-white/30'
                          : 'bg-slate-900 text-slate-400 hover:text-rose-300 hover:bg-rose-950/50'
                      }`}
                    >
                      <XCircle className="w-3.5 h-3.5" />
                      <span>Negative</span>
                    </button>

                    <button
                      onClick={() => onUpdateTest(test.id, undefined)}
                      className={`text-xs px-2 py-1 rounded-lg transition-all ${
                        status === undefined
                          ? 'bg-slate-800 text-slate-300'
                          : 'bg-slate-950 text-slate-400 hover:text-slate-300'
                      }`}
                      title="Clear Test"
                    >
                      <MinusCircle className="w-3.5 h-3.5" />
                    </button>
                  </div>
                </div>

                <div className="text-[10px] text-slate-400 flex items-center justify-between border-t border-slate-800/60 pt-1.5">
                  <span className="font-semibold text-cyan-400">{test.specificityRate}</span>
                  <span className="hidden sm:inline">vs. {test.conflictingEntities.join(', ')}</span>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};
