import React, { useState } from 'react';
import { SENSORY_ZONES } from '../engine/data';
import type { SpinalRegion } from '../engine/types';

interface SensoryMapProps {
  region: SpinalRegion;
  sensoryScores: Record<string, number>;
  onUpdateScore: (zoneId: string, score: number) => void;
}

export const SensoryMap: React.FC<SensoryMapProps> = ({ region, sensoryScores, onUpdateScore }) => {
  const [viewMode, setViewMode] = useState<'root_dermatome' | 'peripheral_autonomous'>('root_dermatome');

  const filteredZones = SENSORY_ZONES.filter(z => z.region === region);

  return (
    <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 backdrop-blur-sm">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-4">
        <div>
          <div className="flex items-center gap-2">
            <h3 className="text-sm font-bold text-slate-100 flex items-center gap-2">
              <span className="w-2.5 h-2.5 rounded-full bg-cyan-400"></span>
              Sensory Territory & Autonomous Zones
            </h3>
            <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-300">
              Tactile Map
            </span>
          </div>
          <p className="text-xs text-slate-400 mt-0.5">
            Identify sensory loss across spinal root dermatomes vs. isolated peripheral cutaneous fields.
          </p>
        </div>

        {/* View mode toggle */}
        <div className="flex items-center bg-slate-950 p-1 rounded-xl border border-slate-800 text-xs">
          <button
            onClick={() => setViewMode('root_dermatome')}
            className={`px-3 py-1 rounded-lg transition-all ${
              viewMode === 'root_dermatome'
                ? 'bg-indigo-600 text-white shadow-sm'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            Root Dermatomes
          </button>
          <button
            onClick={() => setViewMode('peripheral_autonomous')}
            className={`px-3 py-1 rounded-lg transition-all ${
              viewMode === 'peripheral_autonomous'
                ? 'bg-cyan-600 text-white shadow-sm'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            Peripheral Autonomous
          </button>
        </div>
      </div>

      {/* Interactive Zones Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        {filteredZones.map(zone => {
          const currentScore = sensoryScores[zone.id] ?? 0;
          return (
            <div
              key={zone.id}
              className={`p-3.5 rounded-xl border transition-all ${
                currentScore === 2
                  ? 'bg-rose-950/40 border-rose-600/70 shadow-sm'
                  : currentScore === 1
                  ? 'bg-amber-950/40 border-amber-600/70 shadow-sm'
                  : 'bg-slate-950/40 border-slate-800/80 hover:border-slate-700'
              }`}
            >
              <div className="flex items-start justify-between gap-2 mb-1.5">
                <div>
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-bold text-slate-200">{zone.name}</span>
                    {zone.isAutonomicAutonomousZone && (
                      <span className="text-[10px] px-1.5 py-0.2 rounded bg-amber-950/80 text-amber-300 border border-amber-800/60 font-semibold" title="Cleanly separates root from peripheral nerve">
                        Autonomous Zone
                      </span>
                    )}
                  </div>
                  <div className="text-[11px] text-slate-400 mt-0.5">
                    Root: <strong className="text-indigo-300">{zone.rootLevel}</strong> • Nerve: <strong className="text-cyan-300">{zone.peripheralNerveName}</strong>
                  </div>
                </div>
              </div>

              <p className="text-[11px] text-slate-400 italic mb-2.5">
                {zone.dermatomeCoverage}
              </p>

              {/* Sensation selector pill */}
              <div className="flex items-center justify-between border-t border-slate-800/70 pt-2">
                <span className="text-[10px] uppercase font-bold text-slate-400">Tactile Perception:</span>
                <div className="flex items-center gap-1">
                  {[
                    { val: 0, label: 'Normal (100%)', color: 'bg-emerald-950 text-emerald-300 hover:bg-emerald-900' },
                    { val: 1, label: 'Reduced (Hypo)', color: 'bg-amber-950 text-amber-300 hover:bg-amber-900' },
                    { val: 2, label: 'Anesthesia (0%)', color: 'bg-rose-950 text-rose-300 hover:bg-rose-900' },
                  ].map(option => (
                    <button
                      key={option.val}
                      onClick={() => onUpdateScore(zone.id, option.val)}
                      className={`text-[10px] px-2 py-0.5 rounded font-medium transition-all ${
                        currentScore === option.val
                          ? `${option.color} ring-1 ring-white/30 font-bold shadow`
                          : 'bg-slate-900 text-slate-400 hover:text-slate-200'
                      }`}
                    >
                      {option.label}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};
