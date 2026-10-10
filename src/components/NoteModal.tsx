import React from 'react';
import type { DiagnosticVerdict } from '../engine/evaluator';
import { X, Copy, Check, Printer } from 'lucide-react';
import confetti from 'canvas-confetti';

interface NoteModalProps {
  isOpen: boolean;
  onClose: () => void;
  verdict: DiagnosticVerdict;
}

export const NoteModal: React.FC<NoteModalProps> = ({ isOpen, onClose, verdict }) => {
  const [copied, setCopied] = React.useState(false);

  if (!isOpen) return null;

  const dateStr = new Date().toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  const generateMarkdownNote = () => {
    return `# NEURO-SPINE & PERIPHERAL NERVE CONFLICT CONSULTATION NOTE
**Date:** ${dateStr}
**Application:** RADIX Neural Conflict Arbitration Engine v2.4
**Diagnostic Methodology:** Deterministic Multi-Segmental Arbitrator

---

## 1. DIAGNOSTIC VERDICT & PROBABILITY PROFILE
* **Primary Localization:** ${verdict.verdictHeadline}
* **Confidence Level:** ${verdict.confidenceGrade}
* **Spinal Root Probability:** ${verdict.rootProbability}%
* **Peripheral Nerve Probability:** ${verdict.nerveProbability}%
* **Double-Crush Syndrome Risk:** ${verdict.doubleCrushProbability}%

### Executive Summary:
${verdict.executiveSummary}

---

## 2. DECISIVE ARBITRATOR PHYSICAL FINDINGS
${verdict.keyArbitratorFindings.map(f => `* **${f.finding}** (${f.favors.toUpperCase()}): ${f.clinicalSignificance}`).join('\n')}

---

## 3. PATHOGNOMONIC PROVOCATIVE MANEUVERS
${verdict.pathognomonicArbitration.map(p => `* **${p.testName}:** ${p.status} — ${p.takeaway}`).join('\n')}

---

## 4. TARGETED ELECTRODIAGNOSTIC (EMG / NCS) PROTOCOL
${verdict.emgPrescription}

---

## 5. RECOMMENDED CLINICAL PLAN
${verdict.nextStepRecommendation}

---
*Report certified by Radix Neural Engine. Evaluated for Dr. A. Alex Mohit.*
`;
  };

  const handleCopy = () => {
    navigator.clipboard.writeText(generateMarkdownNote());
    setCopied(true);
    confetti({ particleCount: 30, spread: 60, origin: { y: 0.8 } });
    setTimeout(() => setCopied(false), 2500);
  };

  const handlePrint = () => {
    window.print();
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm animate-fade-in">
      <div className="bg-slate-900 border border-slate-800 rounded-3xl max-w-3xl w-full max-h-[90vh] flex flex-col shadow-2xl overflow-hidden">
        {/* Header */}
        <div className="p-5 border-b border-slate-800 flex items-center justify-between bg-slate-950/70">
          <div>
            <h3 className="text-base font-bold text-white">
              Official Neuro-Spine Consultation Note
            </h3>
            <p className="text-xs text-slate-400">
              Generated Markdown / EHR-ready documentation for clinical chart entry.
            </p>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-xl text-slate-400 hover:text-white hover:bg-slate-800 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Note Body */}
        <div className="p-6 overflow-y-auto font-mono text-xs text-slate-300 space-y-4 bg-slate-950/40 select-all leading-relaxed whitespace-pre-wrap">
          {generateMarkdownNote()}
        </div>

        {/* Footer Actions */}
        <div className="p-4 border-t border-slate-800 bg-slate-950 flex flex-wrap items-center justify-between gap-3">
          <span className="text-[11px] text-slate-400">
            Formatted for instant copy-paste into Epic, Cerner, or Clinic EHR.
          </span>
          <div className="flex items-center gap-2">
            <button
              onClick={handlePrint}
              className="flex items-center gap-1.5 px-4 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs font-semibold transition-all"
            >
              <Printer className="w-4 h-4" />
              <span>Print</span>
            </button>
            <button
              onClick={handleCopy}
              className="flex items-center gap-1.5 px-5 py-2 rounded-xl bg-gradient-to-r from-cyan-500 to-indigo-600 hover:from-cyan-400 hover:to-indigo-500 text-white text-xs font-bold shadow-lg shadow-indigo-600/30 transition-all"
            >
              {copied ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
              <span>{copied ? 'Copied to Clipboard!' : 'Copy Note'}</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
