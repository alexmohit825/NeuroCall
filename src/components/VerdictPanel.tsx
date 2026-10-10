import React from 'react';
import type { DiagnosticVerdict } from '../engine/evaluator';
import { CheckCircle, Activity, FileText, Zap, Compass } from 'lucide-react';

interface VerdictPanelProps {
  verdict: DiagnosticVerdict;
  onGenerateReport: () => void;
}

export const VerdictPanel: React.FC<VerdictPanelProps> = ({ verdict, onGenerateReport }) => {
  const getBadgeStyle = () => {
    switch (verdict.primaryEtiology) {
      case 'root':
        return 'bg-indigo-950 text-indigo-300 border-indigo-700/80 shadow-indigo-900/30';
      case 'peripheral_nerve':
        return 'bg-cyan-950 text-cyan-300 border-cyan-700/80 shadow-cyan-900/30';
      case 'double_crush':
        return 'bg-rose-950 text-rose-300 border-rose-700/80 shadow-rose-900/30';
      default:
        return 'bg-slate-900 text-slate-300 border-slate-700';
    }
  };

  return (
    <div className="bg-slate-900/80 border border-slate-800 rounded-3xl p-6 shadow-2xl backdrop-blur-md relative overflow-hidden">
      {/* Background ambient glow */}
      <div className="absolute -top-24 -right-24 w-72 h-72 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute -bottom-24 -left-24 w-72 h-72 bg-cyan-500/10 rounded-full blur-3xl pointer-events-none" />

      {/* Header & Confidence */}
      <div className="flex flex-wrap items-center justify-between gap-3 mb-5 border-b border-slate-800/80 pb-4">
        <div>
          <span className="text-[10px] font-extrabold uppercase tracking-widest text-slate-400">
            RADIX CONFLICT ARBITRATION VERDICT
          </span>
          <h2 className="text-xl sm:text-2xl font-black text-white tracking-tight mt-0.5">
            {verdict.verdictHeadline}
          </h2>
        </div>

        <div className="flex items-center gap-2">
          <span className={`text-xs px-3 py-1 rounded-full font-bold uppercase tracking-wider border shadow-md ${getBadgeStyle()}`}>
            {verdict.confidenceGrade}
          </span>
        </div>
      </div>

      {/* Likelihood Bars */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-6">
        {/* Root Probability */}
        <div className="bg-slate-950/60 rounded-2xl p-4 border border-slate-800">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-xs font-bold text-slate-300">Spinal Root Likelihood</span>
            <span className="text-lg font-black text-indigo-400">{verdict.rootProbability}%</span>
          </div>
          <div className="w-full bg-slate-900 rounded-full h-2.5 overflow-hidden">
            <div
              className="bg-gradient-to-r from-indigo-500 to-indigo-400 h-2.5 rounded-full transition-all duration-700"
              style={{ width: `${verdict.rootProbability}%` }}
            />
          </div>
          <p className="text-[10px] text-slate-400 mt-2">Dermatomal / myotomal multi-nerve convergence</p>
        </div>

        {/* Nerve Probability */}
        <div className="bg-slate-950/60 rounded-2xl p-4 border border-slate-800">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-xs font-bold text-slate-300">Peripheral Nerve Likelihood</span>
            <span className="text-lg font-black text-cyan-400">{verdict.nerveProbability}%</span>
          </div>
          <div className="w-full bg-slate-900 rounded-full h-2.5 overflow-hidden">
            <div
              className="bg-gradient-to-r from-cyan-500 to-cyan-400 h-2.5 rounded-full transition-all duration-700"
              style={{ width: `${verdict.nerveProbability}%` }}
            />
          </div>
          <p className="text-[10px] text-slate-400 mt-2">Terminal focal entrapment with proximal sparing</p>
        </div>

        {/* Double-Crush Probability */}
        <div className="bg-slate-950/60 rounded-2xl p-4 border border-slate-800">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-xs font-bold text-slate-300">Double-Crush Risk</span>
            <span className="text-lg font-black text-rose-400">{verdict.doubleCrushProbability}%</span>
          </div>
          <div className="w-full bg-slate-900 rounded-full h-2.5 overflow-hidden">
            <div
              className="bg-gradient-to-r from-rose-500 to-amber-500 h-2.5 rounded-full transition-all duration-700"
              style={{ width: `${verdict.doubleCrushProbability}%` }}
            />
          </div>
          <p className="text-[10px] text-slate-400 mt-2">Tandem root compromise + distal canal compression</p>
        </div>
      </div>

      {/* Executive Summary */}
      <div className="bg-slate-950/80 rounded-2xl p-4 border border-slate-800/90 mb-5">
        <div className="flex items-center gap-2 mb-1.5">
          <Activity className="w-4 h-4 text-cyan-400" />
          <h4 className="text-xs font-bold uppercase tracking-wider text-slate-300">
            Diagnostic Logic & Anatomical Rationale
          </h4>
        </div>
        <p className="text-xs sm:text-sm text-slate-200 leading-relaxed">
          {verdict.executiveSummary}
        </p>
      </div>

      {/* Key Arbitrator Findings */}
      {verdict.keyArbitratorFindings.length > 0 && (
        <div className="mb-5">
          <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-2.5">
            Decisive Arbitrator Findings Recorded
          </h4>
          <div className="space-y-2">
            {verdict.keyArbitratorFindings.map((finding, idx) => (
              <div
                key={idx}
                className="p-3 rounded-xl bg-slate-950/50 border border-slate-800 flex items-start gap-2.5"
              >
                <div className={`mt-0.5 p-1 rounded-full ${
                  finding.favors === 'root'
                    ? 'bg-indigo-950 text-indigo-400'
                    : finding.favors === 'nerve'
                    ? 'bg-cyan-950 text-cyan-400'
                    : 'bg-rose-950 text-rose-400'
                }`}>
                  <CheckCircle className="w-3.5 h-3.5" />
                </div>
                <div className="flex-1">
                  <div className="flex items-center justify-between">
                    <span className="text-xs font-bold text-slate-200">{finding.finding}</span>
                    <span className="text-[10px] font-semibold uppercase px-2 py-0.5 rounded bg-slate-900 text-slate-400 border border-slate-800">
                      Favors {finding.favors === 'root' ? 'Root' : finding.favors === 'nerve' ? 'Peripheral Nerve' : 'Double Crush'}
                    </span>
                  </div>
                  <p className="text-xs text-slate-400 mt-1 leading-normal">
                    {finding.clinicalSignificance}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Targeted EMG Prescription & Next Steps */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3 mb-5">
        <div className="bg-indigo-950/20 border border-indigo-800/40 rounded-2xl p-4">
          <div className="flex items-center gap-2 mb-1">
            <Zap className="w-4 h-4 text-indigo-400" />
            <h5 className="text-xs font-bold text-indigo-200 uppercase tracking-wide">
              Targeted EMG / NCS Protocol
            </h5>
          </div>
          <p className="text-xs text-slate-300 leading-relaxed">
            {verdict.emgPrescription}
          </p>
        </div>

        <div className="bg-cyan-950/20 border border-cyan-800/40 rounded-2xl p-4">
          <div className="flex items-center gap-2 mb-1">
            <Compass className="w-4 h-4 text-cyan-400" />
            <h5 className="text-xs font-bold text-cyan-200 uppercase tracking-wide">
              Recommended Clinical Action
            </h5>
          </div>
          <p className="text-xs text-slate-300 leading-relaxed">
            {verdict.nextStepRecommendation}
          </p>
        </div>
      </div>

      {/* Action Footer */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-3 pt-3 border-t border-slate-800/70">
        <span className="text-xs text-slate-400">
          Generated automatically by Radix Conflict Engine (2026 A. Alex Mohit)
        </span>
        <button
          onClick={onGenerateReport}
          className="w-full sm:w-auto flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl bg-gradient-to-r from-cyan-500 to-indigo-600 hover:from-cyan-400 hover:to-indigo-500 text-white font-bold text-xs uppercase tracking-wider shadow-lg shadow-indigo-600/25 transition-all"
        >
          <FileText className="w-4 h-4" />
          <span>Generate Formal Neuro-Spine Consult Note</span>
        </button>
      </div>
    </div>
  );
};
