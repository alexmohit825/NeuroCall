// Radix Neuro-Anatomical Taxonomy & Conflict Arbitration Engine

export type SpinalRegion = 'cervical' | 'lumbosacral';

export type SpinalRootLevel =
  | 'C5' | 'C6' | 'C7' | 'C8' | 'T1'
  | 'L1' | 'L2' | 'L3' | 'L4' | 'L5' | 'S1' | 'S2';

export type PeripheralNerve =
  // Upper Extremity
  | 'median_carpal_tunnel'
  | 'median_pronator_teres'
  | 'anterior_interosseous'
  | 'ulnar_cubital_tunnel'
  | 'ulnar_guyon_canal'
  | 'radial_spiral_groove'
  | 'posterior_interosseous'
  | 'axillary'
  | 'musculocutaneous'
  | 'suprascapular'
  | 'thoracic_outlet_neurogenic'
  // Lower Extremity
  | 'common_peroneal_fibular_neck'
  | 'deep_peroneal'
  | 'superficial_peroneal'
  | 'tibial_tarsal_tunnel'
  | 'femoral'
  | 'lateral_femoral_cutaneous'
  | 'obturator'
  | 'sciatic_piriformis';

export type MRCSale = 0 | 1 | 2 | 3 | 4 | 5;

export interface MuscleDefinition {
  id: string;
  name: string;
  commonName: string;
  region: SpinalRegion;
  roots: SpinalRootLevel[];
  primaryRoot: SpinalRootLevel;
  peripheralNerve: PeripheralNerve;
  peripheralNerveName: string;
  action: string;
  isKeyArbitrator: boolean;
  arbitrationNote?: string;
}

export interface SensoryZone {
  id: string;
  name: string;
  region: SpinalRegion;
  rootLevel: SpinalRootLevel;
  peripheralNerve: PeripheralNerve;
  peripheralNerveName: string;
  anatomicalLocation: string;
  isAutonomicAutonomousZone: boolean;
  dermatomeCoverage: string;
}

export interface ReflexTest {
  id: string;
  name: string;
  tendon: string;
  root: SpinalRootLevel;
  peripheralNerve: string;
  normalGrade: number;
}

export interface PathognomonicTest {
  id: string;
  name: string;
  region: SpinalRegion;
  targets: ('root' | 'nerve' | 'plexus')[];
  description: string;
  procedure: string;
  positiveIndication: string;
  specificityRate: string;
  conflictingEntities: string[];
}

export interface ConflictScenario {
  id: string;
  region: SpinalRegion;
  title: string;
  subtitle: string;
  rootCandidate: SpinalRootLevel;
  nerveCandidate: PeripheralNerve;
  nerveCandidateName: string;
  primaryPresentation: string;
  keyDifferentiatorMuscle: string;
  keyDifferentiatorExplanation: string;
  pathognomonicTestId: string;
  emgKeyDifferentiator: string;
  doubleCrushRiskExplanation: string;
}
