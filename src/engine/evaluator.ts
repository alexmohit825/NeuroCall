import { PATHOGNOMONIC_TESTS } from './data';
import type { SpinalRegion, SpinalRootLevel, PeripheralNerve, MRCSale } from './types';

export interface ExamInputState {
  region: SpinalRegion;
  // Motor scores by muscle id (0 to 5)
  motorScores: Record<string, MRCSale>;
  // Sensory deficits by sensory zone id (boolean or severity: 0=normal, 1=reduced, 2=absent)
  sensoryScores: Record<string, number>;
  // Reflex scores by reflex id (0=absent, 1=hypo, 2=normal, 3=brisk, 4=clonus)
  reflexScores: Record<string, number>;
  // Maneuvers positive: record of test id -> boolean
  positiveTests: Record<string, boolean>;
}

export interface DiagnosticVerdict {
  primaryEtiology: 'root' | 'peripheral_nerve' | 'plexopathy' | 'double_crush' | 'indeterminate';
  rootProbability: number; // 0 to 100
  nerveProbability: number; // 0 to 100
  doubleCrushProbability: number; // 0 to 100
  suspectedRoot?: SpinalRootLevel;
  suspectedNerve?: PeripheralNerve;
  suspectedNerveName?: string;
  verdictHeadline: string;
  confidenceGrade: 'Definitive' | 'High Likelihood' | 'Equivocal' | 'Incomplete Exam';
  executiveSummary: string;
  keyArbitratorFindings: {
    finding: string;
    clinicalSignificance: string;
    favors: 'root' | 'nerve' | 'double_crush';
  }[];
  pathognomonicArbitration: {
    testName: string;
    status: 'Positive' | 'Negative' | 'Untested';
    takeaway: string;
  }[];
  emgPrescription: string;
  nextStepRecommendation: string;
}

export function evaluateClinicalExam(state: ExamInputState): DiagnosticVerdict {
  const { region, motorScores, sensoryScores, reflexScores, positiveTests } = state;

  // Find relevant conflict scenario
  let rootPoints = 0;
  let nervePoints = 0;
  let totalDataPoints = 0;

  const keyFindings: DiagnosticVerdict['keyArbitratorFindings'] = [];

  // 1. Cervical Evaluation
  if (region === 'cervical') {
    // C6 vs CTS check: Pronator Teres & Palmar Cutaneous
    const ptScore = motorScores['pronator_teres'] ?? 5;
    const apbScore = motorScores['abductor_pollicis_brevis'] ?? 5;
    const palmSensory = sensoryScores['c6_palmar_cutaneous'] ?? 0;
    const thumbSensory = sensoryScores['c6_radial_forearm_thumb'] ?? 0;
    const spurling = positiveTests['spurlings_test'] ?? false;
    const phalen = positiveTests['phalens_tinel_cts'] ?? false;

    // Pronator Teres is crucial:
    if (ptScore < 5) {
      rootPoints += 35;
      totalDataPoints += 35;
      keyFindings.push({
        finding: `Pronator Teres Weakness (MRC ${ptScore}/5)`,
        clinicalSignificance: 'Pronator Teres is innervated proximal to carpal tunnel. Spared in CTS; directly implicates C6/C7 root or high pronator entrapment.',
        favors: 'root'
      });
    } else if (ptScore === 5 && thumbSensory > 0 && apbScore < 5) {
      nervePoints += 30;
      totalDataPoints += 30;
      keyFindings.push({
        finding: 'Pronator Teres Intact (5/5) with Distal Median Deficits',
        clinicalSignificance: 'Sparing of proximal median motor branch strongly localizes lesion distal to elbow to the carpal tunnel.',
        favors: 'nerve'
      });
    }

    // Palmar Cutaneous Sensation:
    if (palmSensory > 0) {
      rootPoints += 25;
      totalDataPoints += 25;
      keyFindings.push({
        finding: 'Thenar Palmar Cutaneous Sensation Reduced',
        clinicalSignificance: 'Palmar cutaneous branch travels superficial to carpal tunnel. Numbness proves pre-retinacular or C6 root pathology.',
        favors: 'root'
      });
    } else if (palmSensory === 0 && thumbSensory > 0) {
      nervePoints += 25;
      totalDataPoints += 25;
      keyFindings.push({
        finding: 'Thenar Palmar Sensation Sparing with Digital Numbness',
        clinicalSignificance: 'Classic hallmark of Carpal Tunnel Syndrome: sub-ligamentous digital branches compressed while superficial palmar branch is untouched.',
        favors: 'nerve'
      });
    }

    // C7 vs Radial / Triceps / Latissimus:
    const tricepsScore = motorScores['triceps_brachii'] ?? 5;
    const latScore = motorScores['latissimus_dorsi'] ?? 5;
    const edcScore = motorScores['extensor_digitorum_communis'] ?? 5;

    if (latScore < 5 || (tricepsScore < 5 && edcScore < 5)) {
      rootPoints += 30;
      totalDataPoints += 30;
      keyFindings.push({
        finding: `Triceps (${tricepsScore}/5) or Latissimus Dorsi (${latScore}/5) Deficit`,
        clinicalSignificance: 'Latissimus Dorsi (thoracodorsal nerve) and high Triceps origin rule out radial groove/posterior interosseous entrapment; confirms C7 root.',
        favors: 'root'
      });
    }

    // C8/T1 vs Ulnar / Cubital:
    const fdiScore = motorScores['first_dorsal_interosseous'] ?? 5;
    const t1Sensory = sensoryScores['t1_medial_forearm'] ?? 0;
    const cubitalTinel = positiveTests['elbow_flexion_tinel_cubital'] ?? false;

    if (fdiScore < 5 && apbScore < 5) {
      rootPoints += 35;
      totalDataPoints += 35;
      keyFindings.push({
        finding: 'Both FDI (Ulnar) and APB (Median) Weakness (Dual Hand Intrinsics)',
        clinicalSignificance: 'Simultaneous weakness across distinct peripheral nerves indicates C8/T1 root compression or Lower Trunk Plexopathy / Thoracic Outlet.',
        favors: 'root'
      });
    } else if (fdiScore < 5 && apbScore === 5) {
      nervePoints += 35;
      totalDataPoints += 35;
      keyFindings.push({
        finding: 'FDI Weakness with Strict APB Normalcy (5/5)',
        clinicalSignificance: 'Isolated ulnar intrinsic loss with intact median intrinsics localizes to ulnar nerve (cubital tunnel or Guyon canal).',
        favors: 'nerve'
      });
    }

    if (t1Sensory > 0) {
      rootPoints += 20;
      totalDataPoints += 20;
      keyFindings.push({
        finding: 'Medial Antebrachial Cutaneous Territory Sensory Loss',
        clinicalSignificance: 'Involvement above medial epicondyle points directly to T1 root or medial cord/thoracic outlet, not cubital tunnel.',
        favors: 'root'
      });
    }

    // Reflexes
    if ((reflexScores['biceps_jerk'] ?? 2) < 2 || (reflexScores['brachioradialis_jerk'] ?? 2) < 2) {
      rootPoints += 15;
      totalDataPoints += 15;
    }
    if ((reflexScores['triceps_jerk'] ?? 2) < 2) {
      rootPoints += 15;
      totalDataPoints += 15;
    }

    // Pathognomonic Tests
    if (spurling) {
      rootPoints += 30;
      totalDataPoints += 30;
    }
    if (phalen || cubitalTinel) {
      nervePoints += 30;
      totalDataPoints += 30;
    }

  } else {
    // 2. Lumbosacral Evaluation
    // Foot drop arbitrator: Tibialis Posterior (inversion) & Gluteus Medius
    const tibPostScore = motorScores['tibialis_posterior'] ?? 5;
    const tibAntScore = motorScores['tibialis_anterior'] ?? 5;
    const ehlScore = motorScores['extensor_hallucis_longus'] ?? 5;
    const glutMedScore = motorScores['gluteus_medius'] ?? 5;
    const slr = positiveTests['straight_leg_raise'] ?? false;
    const fibTinel = positiveTests['fibular_neck_tinel'] ?? false;
    const femStretch = positiveTests['femoral_nerve_stretch'] ?? false;
    const adductorScore = motorScores['adductor_longus'] ?? 5;
    const quadScore = motorScores['quadriceps_femoris'] ?? 5;

    // THE SUPREME FOOT DROP RULE:
    if ((tibAntScore < 5 || ehlScore < 5)) {
      if (tibPostScore < 5 || glutMedScore < 5) {
        rootPoints += 45;
        totalDataPoints += 45;
        keyFindings.push({
          finding: `Tibialis Posterior (Foot Inversion) Weakness (MRC ${tibPostScore}/5)`,
          clinicalSignificance: 'GOLD STANDARD: Tibialis Posterior is innervated by L5 via the TIBIAL nerve. Weakness proves the lesion is at the L5 ROOT or Sciatic trunk, NEVER isolated Common Peroneal at the fibular head!',
          favors: 'root'
        });
      } else if (tibPostScore === 5 && glutMedScore === 5) {
        nervePoints += 45;
        totalDataPoints += 45;
        keyFindings.push({
          finding: 'Tibialis Posterior (Inversion) & Gluteus Medius 100% Intact (5/5)',
          clinicalSignificance: 'Foot inversion and hip abduction are preserved despite foot drop. Localizes with extreme precision to Common Peroneal Nerve at the fibular neck.',
          favors: 'nerve'
        });
      }
    }

    // L4 vs Femoral / Adductor Longus:
    if (quadScore < 5) {
      if (adductorScore < 5) {
        rootPoints += 35;
        totalDataPoints += 35;
        keyFindings.push({
          finding: `Adductor Longus Weakness (MRC ${adductorScore}/5) with Quadriceps Deficit`,
          clinicalSignificance: 'Adductors are innervated by the Obturator nerve (L2-L4). Concomitant adductor weakness confirms L3/L4 Root or Lumbar Plexus, ruling out isolated Femoral Neuropathy.',
          favors: 'root'
        });
      } else {
        nervePoints += 30;
        totalDataPoints += 30;
        keyFindings.push({
          finding: 'Quadriceps Weakness with Normal Adductor Power (5/5)',
          clinicalSignificance: 'Obturator nerve sparing favors isolated Femoral nerve lesion (e.g. pelvic compression, hematoma, catheterization injury).',
          favors: 'nerve'
        });
      }
    }

    // Reflexes
    if ((reflexScores['patellar_jerk'] ?? 2) < 2) {
      rootPoints += 15;
      totalDataPoints += 15;
    }
    if ((reflexScores['achilles_jerk'] ?? 2) < 2) {
      rootPoints += 20;
      totalDataPoints += 20;
    }

    // Maneuvers
    if (slr || femStretch) {
      rootPoints += 30;
      totalDataPoints += 30;
    }
    if (fibTinel) {
      nervePoints += 30;
      totalDataPoints += 30;
    }
  }

  // Calculate probabilities
  const sum = rootPoints + nervePoints;
  let rootProb = 50;
  let nerveProb = 50;
  let doubleCrushProb = 15;

  if (sum > 0) {
    rootProb = Math.min(98, Math.max(5, Math.round((rootPoints / sum) * 100)));
    nerveProb = 100 - rootProb;

    // Detect Double-Crush
    if (rootPoints >= 30 && nervePoints >= 30) {
      doubleCrushProb = Math.min(85, Math.round((rootPoints * nervePoints) / (sum * 1.2)));
    }
  }

  // Determine Headline & Etiology
  let primaryEtiology: DiagnosticVerdict['primaryEtiology'] = 'indeterminate';
  let confidenceGrade: DiagnosticVerdict['confidenceGrade'] = 'Equivocal';
  let headline = 'Undetermined / Symmetrical Findings';
  let summary = 'Please enter additional muscle MRC scores or pathognomonic provocative maneuvers to resolve the conflict.';
  let emgPrescription = 'Standard Upper & Lower Extremity Nerve Conduction Study (NCS) and Needle EMG.';
  let nextStep = 'Perform targeted neurological re-examination of key arbitrator muscles.';

  if (doubleCrushProb >= 50) {
    primaryEtiology = 'double_crush';
    confidenceGrade = 'High Likelihood';
    headline = 'Tandem Double-Crush Syndrome Detected';
    summary = `Significant convergence of both spinal root compression and peripheral nerve entrapment signs (${doubleCrushProb}% double-crush probability). Proximal root axonopathy impairs anterograde axoplasmic transport, dramatically increasing susceptibility to distal compressive neuropathy.`;
    emgPrescription = 'Order both paraspinal needle EMG (evaluating fibrillations/positive sharp waves for preganglionic root) AND cross-tunnel sensory/motor nerve conduction velocity studies (CTS/cubital tunnel/fibular head).';
    nextStep = 'Obtain cervical/lumbar MRI for foraminal stenosis and high-resolution peripheral nerve ultrasound to evaluate focal nerve cross-sectional area expansion.';
  } else if (rootProb >= 70) {
    primaryEtiology = 'root';
    confidenceGrade = rootProb >= 85 ? 'Definitive' : 'High Likelihood';
    headline = region === 'cervical' ? 'Cervical Radiculopathy Strongly Favored' : 'Lumbosacral Radiculopathy Strongly Favored';
    summary = `Clinical presentation exhibits hallmark multi-peripheral-nerve root distribution, proximal arbitrator muscle involvement, and provocative dural/foraminal tension.`;
    emgPrescription = 'Needle EMG of paraspinal musculature and multiple muscles sharing common root derivation (confirming pre-ganglionic root compromise with normal sensory nerve action potential SNAP amplitudes).';
    nextStep = 'Urgent non-contrast MRI of the spine to identify neural foramen impingement, disc herniation, or uncovertebral osteophytosis.';
  } else if (nerveProb >= 70) {
    primaryEtiology = 'peripheral_nerve';
    confidenceGrade = nerveProb >= 85 ? 'Definitive' : 'High Likelihood';
    headline = 'Isolated Peripheral Nerve Entrapment Favored';
    summary = `Deficits strictly adhere to terminal peripheral nerve anatomical boundaries, with preservation of proximal root-derived muscles and pathognomonic local focal compression signs.`;
    emgPrescription = 'Focal segment Nerve Conduction Studies across anatomical entrapment site (assessing focal conduction block, prolonged distal motor latency, and attenuated SNAP). Paraspinal EMG will be normal.';
    nextStep = 'High-resolution musculoskeletal ultrasound of the suspected nerve canal, wrist/elbow/fibular splinting, and consideration of local corticosteroid hydrodissection or decompression.';
  }

  // Compile pathognomonic list
  const pathognomonicArbitration = PATHOGNOMONIC_TESTS
    .filter(t => t.region === region)
    .map(t => {
      const isPos = positiveTests[t.id];
      return {
        testName: t.name,
        status: isPos === true ? 'Positive' as const : isPos === false ? 'Negative' as const : 'Untested' as const,
        takeaway: isPos
          ? t.positiveIndication
          : `If positive: ${t.specificityRate}`
      };
    });

  return {
    primaryEtiology,
    rootProbability: rootProb,
    nerveProbability: nerveProb,
    doubleCrushProbability: doubleCrushProb,
    verdictHeadline: headline,
    confidenceGrade,
    executiveSummary: summary,
    keyArbitratorFindings: keyFindings,
    pathognomonicArbitration,
    emgPrescription,
    nextStepRecommendation: nextStep
  };
}
