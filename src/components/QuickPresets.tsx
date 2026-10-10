import React from 'react';
import { CONFLICT_SCENARIOS } from '../engine/data';
import { Sparkles, CheckCircle2 } from 'lucide-react';

interface QuickPresetsProps {
  onSelectScenario: (scenarioId: string) => void;
  selectedScenarioId?: string;
}

export const QuickPresets: React.FC<QuickPresetsProps> = ({ onSelectScenario, selectedScenarioId }) => {
  return (
    <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-4 backdrop-blur-sm">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-2">
          <Sparkles className="w-4 h-4 text-amber-400" />
          <h3 className="text-xs font-bold uppercase tracking-wider text-slate-300">
            High-Yield Clinical Conflict Presets
          </h3>
        </div>
        <span className="text-[11px] text-slate-400">Click to instantly populate exam</span>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-2.5">
        {CONFLICT_SCENARIOS.map((scenario) => {
          const isSelected = selectedScenarioId === scenario.id;
          return (
            <button
              key={scenario.id}
              onClick={() => onSelectScenario(scenario.id)}
              className={`p-3 rounded-xl text-left border transition-all relative overflow-hidden group ${
                isSelected
                  ? 'bg-indigo-950/70 border-indigo-500 shadow-md shadow-indigo-900/30'
                  : 'bg-slate-950/40 border-slate-800/80 hover:border-slate-700 hover:bg-slate-900/60'
              }`}
            >
              <div className="flex items-center justify-between mb-1.5">
                <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded uppercase tracking-wider ${
                  scenario.region === 'cervical'
                    ? 'bg-cyan-950 text-cyan-400 border border-cyan-800/60'
                    : 'bg-emerald-950 text-emerald-400 border border-emerald-800/60'
                }`}>
                  {scenario.region === 'cervical' ? 'Cervical' : 'Lumbosacral'}
                </span>
                {isSelected && <CheckCircle2 className="w-3.5 h-3.5 text-indigo-400" />}
              </div>

              <div className="text-xs font-semibold text-slate-200 line-clamp-1 group-hover:text-cyan-300 transition-colors">
                {scenario.title.split(' vs. ')[0]}
              </div>
              <div className="text-[11px] text-slate-400 line-clamp-1">
                vs. {scenario.title.split(' vs. ')[1] || scenario.nerveCandidateName}
              </div>

              <div className="mt-2 text-[10px] text-slate-400 border-t border-slate-800/60 pt-1.5 flex items-center justify-between">
                <span>Key: <strong className="text-amber-300/90 font-medium">{scenario.keyDifferentiatorMuscle.split(' ')[0]}</strong></span>
              </div>
            </button>
          );
        })}
      </div>
    </div>
  );
};
