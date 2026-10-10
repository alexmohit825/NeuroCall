import React, { useState } from 'react';
import { CONFLICT_SCENARIOS, PATHOGNOMONIC_TESTS } from '../engine/data';
import { BookOpen, Layers, ShieldCheck, Zap, AlertTriangle } from 'lucide-react';

export const ConflictAtlas: React.FC = () => {
  const [selectedScenarioId, setSelectedScenarioId] = useState<string>(CONFLICT_SCENARIOS[0].id);

  const scenario = CONFLICT_SCENARIOS.find(s => s.id === selectedScenarioId) || CONFLICT_SCENARIOS[0];
  const testInfo = PATHOGNOMONIC_TESTS.find(t => t.id === scenario.pathognomonicTestId);

  return (
    <div className="space-y-6">
      {/* Intro Header */}
      <div className="bg-slate-900/60 border border-slate-800 rounded-2xl p-6 backdrop-blur-sm">
        <div className="flex items-center gap-3 mb-2">
          <div className="w-9 h-9 rounded-xl bg-indigo-900/50 border border-indigo-700/60 flex items-center justify-center text-indigo-300">
            <Layers className="w-5 h-5" />
          </div>
          <div>
            <h2 className="text-lg font-black text-white tracking-tight">
              Anatomical Conflict Atlas & High-Yield Differentiators
            </h2>
            <p className="text-xs text-slate-400">
              Comprehensive peer-reviewed reference guide for decoupled root vs. nerve clinical presentations.
            </p>
          </div>
        </div>

        {/* Tab Selector */}
        <div className="flex flex-wrap gap-2 mt-4 pt-4 border-t border-slate-800/80">
          {CONFLICT_SCENARIOS.map(s => (
            <button
              key={s.id}
              onClick={() => setSelectedScenarioId(s.id)}
              className={`text-xs px-3.5 py-2 rounded-xl font-bold transition-all ${
                selectedScenarioId === s.id
                  ? 'bg-indigo-600 text-white shadow-md shadow-indigo-600/30 ring-1 ring-white/20'
                  : 'bg-slate-950 text-slate-400 hover:text-white hover:bg-slate-900 border border-slate-800'
              }`}
            >
              {s.title.split(' vs. ')[0]} vs. {s.title.split(' vs. ')[1]}
            </button>
          ))}
        </div>
      </div>

      {/* Detailed Comparative Card */}
      <div className="bg-slate-900/80 border border-slate-800 rounded-3xl p-6 sm:p-8 backdrop-blur-md shadow-xl">
        <div className="flex flex-wrap items-center justify-between gap-3 mb-4">
          <div>
            <span className="text-[10px] font-extrabold uppercase tracking-widest text-cyan-400">
              {scenario.region === 'cervical' ? 'Cervical Spine / Upper Extremity' : 'Lumbosacral Spine / Lower Extremity'}
            </span>
            <h3 className="text-xl sm:text-2xl font-black text-white tracking-tight mt-0.5">
              {scenario.title}
            </h3>
            <p className="text-xs sm:text-sm text-slate-300 mt-1">
              {scenario.subtitle}
            </p>
          </div>
        </div>

        {/* Presentation vs. Primary Conflict */}
        <div className="bg-slate-950/60 rounded-2xl p-4 border border-slate-800 mb-6">
          <div className="text-[11px] font-bold text-slate-400 uppercase tracking-wider mb-1">
            Overlapping Clinical Presentation
          </div>
          <p className="text-xs sm:text-sm text-slate-200">
            {scenario.primaryPresentation}
          </p>
        </div>

        {/* Decisive Comparison Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
          {/* Key Arbitrator Muscle */}
          <div className="bg-indigo-950/30 border border-indigo-800/50 rounded-2xl p-5">
            <div className="flex items-center gap-2 mb-2">
              <ShieldCheck className="w-5 h-5 text-indigo-400" />
              <h4 className="text-xs font-bold uppercase tracking-wider text-indigo-200">
                Key Arbitrator Muscle & Mechanism
              </h4>
            </div>
            <div className="text-sm font-black text-white mb-2">
              {scenario.keyDifferentiatorMuscle}
            </div>
            <p className="text-xs text-slate-300 leading-relaxed">
              {scenario.keyDifferentiatorExplanation}
            </p>
          </div>

          {/* EMG / NCS Distinguisher */}
          <div className="bg-cyan-950/30 border border-cyan-800/50 rounded-2xl p-5">
            <div className="flex items-center gap-2 mb-2">
              <Zap className="w-5 h-5 text-cyan-400" />
              <h4 className="text-xs font-bold uppercase tracking-wider text-cyan-200">
                Electrodiagnostic (EMG/NCS) Hallmark
              </h4>
            </div>
            <p className="text-xs text-slate-300 leading-relaxed">
              {scenario.emgKeyDifferentiator}
            </p>
          </div>
        </div>

        {/* Pathognomonic Physical Test Feature */}
        {testInfo && (
          <div className="bg-emerald-950/30 border border-emerald-800/50 rounded-2xl p-5 mb-6">
            <div className="flex items-center justify-between gap-2 mb-2">
              <div className="flex items-center gap-2">
                <BookOpen className="w-5 h-5 text-emerald-400" />
                <h4 className="text-xs font-bold uppercase tracking-wider text-emerald-200">
                  Definitive Clinical Maneuver: {testInfo.name}
                </h4>
              </div>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-emerald-950 text-emerald-300 border border-emerald-800/80">
                {testInfo.specificityRate}
              </span>
            </div>
            <p className="text-xs text-slate-200 mb-2">
              <strong className="text-slate-100">Procedure:</strong> {testInfo.procedure}
            </p>
            <p className="text-xs text-emerald-300/90 font-medium">
              <strong className="text-emerald-200">Positive Criterion:</strong> {testInfo.positiveIndication}
            </p>
          </div>
        )}

        {/* Double-Crush Risk Alert */}
        <div className="bg-amber-950/30 border border-amber-800/50 rounded-2xl p-5">
          <div className="flex items-center gap-2 mb-2">
            <AlertTriangle className="w-5 h-5 text-amber-400" />
            <h4 className="text-xs font-bold uppercase tracking-wider text-amber-200">
              Double-Crush Syndrome Vulnerability
            </h4>
          </div>
          <p className="text-xs text-slate-300 leading-relaxed">
            {scenario.doubleCrushRiskExplanation}
          </p>
        </div>
      </div>
    </div>
  );
};
