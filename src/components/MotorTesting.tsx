import React from 'react';
import { MUSCLES } from '../engine/data';
import type { SpinalRegion, MRCSale } from '../engine/types';
import { Star, ShieldCheck } from 'lucide-react';

interface MotorTestingProps {
  region: SpinalRegion;
  motorScores: Record<string, MRCSale>;
  onUpdateScore: (muscleId: string, score: MRCSale) => void;
}

export const MotorTesting: React.FC<MotorTestingProps> = ({ region, motorScores, onUpdateScore }) => {
  const filteredMuscles = MUSCLES.filter(m => m.region === region);

  return (
    <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 backdrop-blur-sm">
      <div className="flex items-center justify-between mb-4">
        <div>
          <div className="flex items-center gap-2">
            <h3 className="text-sm font-bold text-slate-100 flex items-center gap-2">
              <span className="w-2.5 h-2.5 rounded-full bg-indigo-400"></span>
              Motor Power Testing (MRC Scale 0 – 5)
            </h3>
            <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-indigo-950 text-indigo-300 border border-indigo-800/60">
              Myotomal Matrix
            </span>
          </div>
          <p className="text-xs text-slate-400 mt-0.5">
            Key arbitrator muscles highlighted with amber stars. Pay close attention to multi-nerve / proximal muscles.
          </p>
        </div>
      </div>

      <div className="space-y-3">
        {filteredMuscles.map(muscle => {
          const currentScore = motorScores[muscle.id] ?? 5;
          const isWeak = currentScore < 5;

          return (
            <div
              key={muscle.id}
              className={`p-3.5 rounded-xl border transition-all ${
                muscle.isKeyArbitrator
                  ? isWeak
                    ? 'bg-amber-950/30 border-amber-500/80 shadow-md shadow-amber-900/20'
                    : 'bg-slate-950/60 border-slate-700/80'
                  : isWeak
                  ? 'bg-slate-900/80 border-indigo-700/50'
                  : 'bg-slate-950/40 border-slate-800/80 hover:border-slate-700'
              }`}
            >
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-2">
                <div>
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="text-xs font-bold text-slate-100">{muscle.name}</span>
                    <span className="text-[11px] text-slate-400 font-medium">({muscle.commonName})</span>
                    {muscle.isKeyArbitrator && (
                      <span className="flex items-center gap-1 text-[10px] px-2 py-0.5 rounded-full bg-amber-950 text-amber-300 border border-amber-700/80 font-bold">
                        <Star className="w-3 h-3 fill-amber-400 text-amber-400" />
                        Key Arbitrator
                      </span>
                    )}
                  </div>

                  <div className="flex items-center gap-3 text-[11px] text-slate-400 mt-1">
                    <span>
                      Roots: <strong className="text-indigo-300">{muscle.roots.join(', ')}</strong> (Primary: {muscle.primaryRoot})
                    </span>
                    <span>•</span>
                    <span>
                      Nerve: <strong className="text-cyan-300">{muscle.peripheralNerveName}</strong>
                    </span>
                  </div>
                </div>

                {/* MRC 0-5 Selector Buttons */}
                <div className="flex items-center gap-1 bg-slate-950 p-1 rounded-xl border border-slate-800">
                  {([5, 4, 3, 2, 1, 0] as MRCSale[]).map(grade => {
                    const isSelected = currentScore === grade;
                    return (
                      <button
                        key={grade}
                        onClick={() => onUpdateScore(muscle.id, grade)}
                        className={`w-7 h-7 rounded-lg text-xs font-bold transition-all flex items-center justify-center ${
                          isSelected
                            ? grade === 5
                              ? 'bg-emerald-600 text-white shadow-sm ring-1 ring-white/20'
                              : grade >= 3
                              ? 'bg-amber-600 text-white shadow-sm ring-1 ring-white/20'
                              : 'bg-rose-600 text-white shadow-sm ring-1 ring-white/20'
                            : 'text-slate-400 hover:text-slate-200 hover:bg-slate-900'
                        }`}
                        title={`MRC Grade ${grade}: ${
                          grade === 5 ? 'Normal Power' :
                          grade === 4 ? 'Movement against moderate resistance' :
                          grade === 3 ? 'Movement against gravity only' :
                          grade === 2 ? 'Movement with gravity eliminated' :
                          grade === 1 ? 'Trace flicker contraction' : 'Complete paralysis'
                        }`}
                      >
                        {grade}
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* Arbitration Explanatory Note */}
              {muscle.arbitrationNote && (
                <div className="text-[11px] text-slate-300 bg-slate-900/90 rounded-lg p-2 border border-slate-800/80 mt-1.5 flex items-start gap-2">
                  <ShieldCheck className="w-3.5 h-3.5 text-cyan-400 shrink-0 mt-0.5" />
                  <span>{muscle.arbitrationNote}</span>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};
