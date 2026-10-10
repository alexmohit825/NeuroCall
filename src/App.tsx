import { useState } from 'react';
import { Header } from './components/Header';
import { QuickPresets } from './components/QuickPresets';
import { SensoryMap } from './components/SensoryMap';
import { MotorTesting } from './components/MotorTesting';
import { ReflexesAndTests } from './components/ReflexesAndTests';
import { VerdictPanel } from './components/VerdictPanel';
import { ConflictAtlas } from './components/ConflictAtlas';
import { DoubleCrushMatrix } from './components/DoubleCrushMatrix';
import { EMGGuide } from './components/EMGGuide';
import { NoteModal } from './components/NoteModal';
import type { SpinalRegion, MRCSale } from './engine/types';
import { evaluateClinicalExam } from './engine/evaluator';
import type { ExamInputState } from './engine/evaluator';
import { CONFLICT_SCENARIOS } from './engine/data';

export function App() {
  const [activeTab, setActiveTab] = useState<'solver' | 'conflict_atlas' | 'double_crush' | 'emg_guide'>('solver');
  const [region, setRegion] = useState<SpinalRegion>('cervical');
  const [selectedScenarioId, setSelectedScenarioId] = useState<string | undefined>('c6_vs_carpal_tunnel');
  const [isNoteModalOpen, setIsNoteModalOpen] = useState(false);

  // Examination State
  const [examState, setExamState] = useState<ExamInputState>({
    region: 'cervical',
    motorScores: {
      pronator_teres: 5,
      abductor_pollicis_brevis: 4,
      biceps_brachii: 5,
      brachioradialis: 5,
      triceps_brachii: 5,
      latissimus_dorsi: 5,
      first_dorsal_interosseous: 5,
      flexor_pollicis_longus: 5,
    },
    sensoryScores: {
      c6_radial_forearm_thumb: 1, // numb thumb/index
      c6_palmar_cutaneous: 0,      // SPARED thenar eminence palm (classic CTS)
    },
    reflexScores: {
      biceps_jerk: 2,
      brachioradialis_jerk: 2,
      triceps_jerk: 2,
    },
    positiveTests: {
      phalens_tinel_cts: true,
      spurlings_test: false,
    }
  });

  // Evaluate clinical exam dynamically
  const verdict = evaluateClinicalExam(examState);

  // Handlers for exam mutations
  const handleUpdateMotor = (muscleId: string, score: MRCSale) => {
    setExamState(prev => ({
      ...prev,
      motorScores: { ...prev.motorScores, [muscleId]: score }
    }));
    setSelectedScenarioId(undefined);
  };

  const handleUpdateSensory = (zoneId: string, score: number) => {
    setExamState(prev => ({
      ...prev,
      sensoryScores: { ...prev.sensoryScores, [zoneId]: score }
    }));
    setSelectedScenarioId(undefined);
  };

  const handleUpdateReflex = (reflexId: string, score: number) => {
    setExamState(prev => ({
      ...prev,
      reflexScores: { ...prev.reflexScores, [reflexId]: score }
    }));
    setSelectedScenarioId(undefined);
  };

  const handleUpdateTest = (testId: string, status: boolean | undefined) => {
    setExamState(prev => {
      const nextTests = { ...prev.positiveTests };
      if (status === undefined) {
        delete nextTests[testId];
      } else {
        nextTests[testId] = status;
      }
      return { ...prev, positiveTests: nextTests };
    });
    setSelectedScenarioId(undefined);
  };

  const handleRegionSwitch = (newRegion: SpinalRegion) => {
    setRegion(newRegion);
    setExamState({
      region: newRegion,
      motorScores: {},
      sensoryScores: {},
      reflexScores: {},
      positiveTests: {}
    });
    setSelectedScenarioId(undefined);
  };

  const handleSelectScenario = (scenarioId: string) => {
    setSelectedScenarioId(scenarioId);
    const scenario = CONFLICT_SCENARIOS.find(s => s.id === scenarioId);
    if (!scenario) return;

    setRegion(scenario.region);

    if (scenarioId === 'c6_vs_carpal_tunnel') {
      // Classic CTS pattern with spared Pronator Teres and spared Palmar Cutaneous
      setExamState({
        region: 'cervical',
        motorScores: {
          pronator_teres: 5,               // Spared!
          abductor_pollicis_brevis: 3,     // Weak APB
          biceps_brachii: 5,
          brachioradialis: 5,
        },
        sensoryScores: {
          c6_radial_forearm_thumb: 2,      // Numb digits
          c6_palmar_cutaneous: 0,          // Spared thenar palm!
        },
        reflexScores: {
          biceps_jerk: 2,
          brachioradialis_jerk: 2,
          triceps_jerk: 2,
        },
        positiveTests: {
          phalens_tinel_cts: true,
          spurlings_test: false,
        }
      });
    } else if (scenarioId === 'c7_vs_radial_pin') {
      // C7 Radiculopathy pattern with weak Latissimus and weak Triceps
      setExamState({
        region: 'cervical',
        motorScores: {
          triceps_brachii: 3,
          latissimus_dorsi: 3,             // Decisive non-radial C7 muscle!
          extensor_digitorum_communis: 3,
          flexor_carpi_radialis: 3,
        },
        sensoryScores: {
          c7_middle_finger: 2,
        },
        reflexScores: {
          triceps_jerk: 0,
        },
        positiveTests: {
          spurlings_test: true,
        }
      });
    } else if (scenarioId === 'c8_t1_vs_cubital_tunnel') {
      // Cubital Tunnel: FDI weak, APB intact
      setExamState({
        region: 'cervical',
        motorScores: {
          first_dorsal_interosseous: 3,
          abductor_digiti_minimi: 3,
          abductor_pollicis_brevis: 5,     // 100% normal (rules out C8/T1 root / TOS!)
          flexor_pollicis_longus: 5,
        },
        sensoryScores: {
          c8_hypothenar_fifth_digit: 2,
          t1_medial_forearm: 0,            // Spared!
        },
        reflexScores: {
          biceps_jerk: 2,
          triceps_jerk: 2,
        },
        positiveTests: {
          elbow_flexion_tinel_cubital: true,
          spurlings_test: false,
        }
      });
    } else if (scenarioId === 'l5_vs_common_peroneal') {
      // Isolated Peroneal Nerve: Tibialis Anterior & EHL weak, but Tibialis Posterior 5/5!
      setExamState({
        region: 'lumbosacral',
        motorScores: {
          tibialis_anterior: 2,            // Foot drop
          extensor_hallucis_longus: 1,     // Weak big toe
          peroneus_longus: 2,              // Weak eversion
          tibialis_posterior: 5,           // 100% Normal Inversion! (Rules out L5 root!)
          gluteus_medius: 5,               // Normal hip abductors!
        },
        sensoryScores: {
          l5_first_web_space: 2,
          l5_dorsum_foot: 1,
        },
        reflexScores: {
          patellar_jerk: 2,
          achilles_jerk: 2,
        },
        positiveTests: {
          fibular_neck_tinel: true,
          straight_leg_raise: false,
        }
      });
    } else if (scenarioId === 'l4_vs_femoral_neuropathy') {
      // L4 Radiculopathy: Both Quadriceps and Adductor Longus (Obturator) are weak
      setExamState({
        region: 'lumbosacral',
        motorScores: {
          quadriceps_femoris: 3,
          adductor_longus: 3,              // Decisive Obturator involvement = ROOT!
          tibialis_anterior: 4,
        },
        sensoryScores: {
          l4_medial_leg_malleolus: 2,
          l2_l3_anterior_thigh: 1,
        },
        reflexScores: {
          patellar_jerk: 0,
          achilles_jerk: 2,
        },
        positiveTests: {
          femoral_nerve_stretch: true,
        }
      });
    }
  };

  const handleReset = () => {
    setSelectedScenarioId(undefined);
    setExamState({
      region,
      motorScores: {},
      sensoryScores: {},
      reflexScores: {},
      positiveTests: {}
    });
  };

  return (
    <div className="min-h-screen bg-[#090d16] text-slate-100 flex flex-col font-sans selection:bg-indigo-500 selection:text-white pb-12">
      {/* Top Header */}
      <Header
        activeTab={activeTab}
        setActiveTab={setActiveTab}
        onReset={handleReset}
        onExport={() => setIsNoteModalOpen(true)}
      />

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-6 w-full flex-1">
        {activeTab === 'solver' && (
          <div className="space-y-6">
            {/* Quick Presets Carousel */}
            <QuickPresets
              onSelectScenario={handleSelectScenario}
              selectedScenarioId={selectedScenarioId}
            />

            {/* Region Selection Switch */}
            <div className="flex items-center justify-between bg-slate-900/60 p-2 rounded-2xl border border-slate-800">
              <span className="text-xs font-bold text-slate-300 ml-3">
                Target Anatomic Region:
              </span>
              <div className="flex items-center gap-1 bg-slate-950 p-1 rounded-xl border border-slate-800">
                <button
                  onClick={() => handleRegionSwitch('cervical')}
                  className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all ${
                    region === 'cervical'
                      ? 'bg-gradient-to-r from-cyan-600 to-indigo-600 text-white shadow-md'
                      : 'text-slate-400 hover:text-white'
                  }`}
                >
                  Cervical / Upper Extremity
                </button>
                <button
                  onClick={() => handleRegionSwitch('lumbosacral')}
                  className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all ${
                    region === 'lumbosacral'
                      ? 'bg-gradient-to-r from-indigo-600 to-emerald-600 text-white shadow-md'
                      : 'text-slate-400 hover:text-white'
                  }`}
                >
                  Lumbosacral / Lower Extremity
                </button>
              </div>
            </div>

            {/* Dynamic Real-Time Verdict Panel */}
            <VerdictPanel
              verdict={verdict}
              onGenerateReport={() => setIsNoteModalOpen(true)}
            />

            {/* Two-Column Exam Grid */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Left Column: Motor Exam */}
              <div className="space-y-6">
                <MotorTesting
                  region={region}
                  motorScores={examState.motorScores}
                  onUpdateScore={handleUpdateMotor}
                />
              </div>

              {/* Right Column: Sensory Map & Reflexes */}
              <div className="space-y-6">
                <SensoryMap
                  region={region}
                  sensoryScores={examState.sensoryScores}
                  onUpdateScore={handleUpdateSensory}
                />
                <ReflexesAndTests
                  region={region}
                  reflexScores={examState.reflexScores}
                  positiveTests={examState.positiveTests}
                  onUpdateReflex={handleUpdateReflex}
                  onUpdateTest={handleUpdateTest}
                />
              </div>
            </div>
          </div>
        )}

        {activeTab === 'conflict_atlas' && <ConflictAtlas />}
        {activeTab === 'double_crush' && <DoubleCrushMatrix />}
        {activeTab === 'emg_guide' && <EMGGuide />}
      </main>

      {/* Note Export Modal */}
      <NoteModal
        isOpen={isNoteModalOpen}
        onClose={() => setIsNoteModalOpen(false)}
        verdict={verdict}
      />
    </div>
  );
}

export default App;
