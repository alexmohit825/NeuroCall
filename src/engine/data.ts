import type { MuscleDefinition, SensoryZone, ReflexTest, PathognomonicTest, ConflictScenario } from './types';

export const MUSCLES: MuscleDefinition[] = [
  // CERVICAL - C5
  {
    id: 'deltoid',
    name: 'Deltoid',
    commonName: 'Shoulder Abduction',
    region: 'cervical',
    roots: ['C5', 'C6'],
    primaryRoot: 'C5',
    peripheralNerve: 'axillary',
    peripheralNerveName: 'Axillary Nerve',
    action: 'Shoulder abduction beyond 15 degrees',
    isKeyArbitrator: true,
    arbitrationNote: 'Weakness with intact Infraspinatus favors Axillary nerve injury over C5 radiculopathy.'
  },
  {
    id: 'infraspinatus',
    name: 'Infraspinatus',
    commonName: 'Shoulder External Rotation',
    region: 'cervical',
    roots: ['C5', 'C6'],
    primaryRoot: 'C5',
    peripheralNerve: 'suprascapular',
    peripheralNerveName: 'Suprascapular Nerve',
    action: 'External rotation of humerus',
    isKeyArbitrator: true,
    arbitrationNote: 'Spared in Axillary nerve injury; impaired in C5 root or Suprascapular notch entrapment.'
  },
  {
    id: 'biceps_brachii',
    name: 'Biceps Brachii',
    commonName: 'Elbow Flexion & Supination',
    region: 'cervical',
    roots: ['C5', 'C6'],
    primaryRoot: 'C6',
    peripheralNerve: 'musculocutaneous',
    peripheralNerveName: 'Musculocutaneous Nerve',
    action: 'Elbow flexion with forearm supinated',
    isKeyArbitrator: false
  },
  {
    id: 'brachioradialis',
    name: 'Brachioradialis',
    commonName: 'Forearm Mid-Pronation Flexion',
    region: 'cervical',
    roots: ['C5', 'C6'],
    primaryRoot: 'C6',
    peripheralNerve: 'radial_spiral_groove',
    peripheralNerveName: 'Radial Nerve',
    action: 'Elbow flexion in neutral/mid-pronation',
    isKeyArbitrator: true,
    arbitrationNote: 'Distinguishes C6 root from Musculocutaneous (Biceps is Musculocutaneous, Brachioradialis is Radial).'
  },
  // CERVICAL - C6 / MEDIAN CONFLICT
  {
    id: 'pronator_teres',
    name: 'Pronator Teres',
    commonName: 'Forearm Pronation',
    region: 'cervical',
    roots: ['C6', 'C7'],
    primaryRoot: 'C6',
    peripheralNerve: 'median_pronator_teres',
    peripheralNerveName: 'Median Nerve (High/Arm branch)',
    action: 'Pronates forearm',
    isKeyArbitrator: true,
    arbitrationNote: 'CRITICAL ARBITRATOR: Innervated ABOVE the carpal tunnel. SPARED in Carpal Tunnel Syndrome, WEAK in C6/C7 Radiculopathy or Pronator Syndrome.'
  },
  {
    id: 'flexor_carpi_radialis',
    name: 'Flexor Carpi Radialis (FCR)',
    commonName: 'Wrist Flexion & Radial Deviation',
    region: 'cervical',
    roots: ['C6', 'C7'],
    primaryRoot: 'C7',
    peripheralNerve: 'median_pronator_teres',
    peripheralNerveName: 'Median Nerve (Proximal)',
    action: 'Flexes wrist and radially abducts',
    isKeyArbitrator: true,
    arbitrationNote: 'Innervated proximal to carpal tunnel. Spared in CTS; impaired in C7 radiculopathy.'
  },
  // CERVICAL - C7 / RADIAL CONFLICT
  {
    id: 'triceps_brachii',
    name: 'Triceps Brachii',
    commonName: 'Elbow Extension',
    region: 'cervical',
    roots: ['C6', 'C7', 'C8'],
    primaryRoot: 'C7',
    peripheralNerve: 'radial_spiral_groove',
    peripheralNerveName: 'Radial Nerve',
    action: 'Extension of forearm at elbow',
    isKeyArbitrator: true,
    arbitrationNote: 'Branch arises in axilla. SPARED in Radial Neuropathy at spiral groove (Saturday Night Palsy) or PIN syndrome; WEAK in C7 radiculopathy.'
  },
  {
    id: 'latissimus_dorsi',
    name: 'Latissimus Dorsi',
    commonName: 'Arm Adduction & Internal Rotation',
    region: 'cervical',
    roots: ['C6', 'C7', 'C8'],
    primaryRoot: 'C7',
    peripheralNerve: 'suprascapular', // Thoracodorsal
    peripheralNerveName: 'Thoracodorsal Nerve (Posterior Cord)',
    action: 'Adducts, extends and internally rotates arm',
    isKeyArbitrator: true,
    arbitrationNote: 'KEY C7 ROOT ARBITRATOR: Non-radial nerve C7 muscle. If Latissimus is denervated on EMG, lesion is C7 root/posterior cord, NEVER isolated radial nerve!'
  },
  {
    id: 'extensor_digitorum_communis',
    name: 'Extensor Digitorum Communis (EDC)',
    commonName: 'Finger Extension at MCPs',
    region: 'cervical',
    roots: ['C7', 'C8'],
    primaryRoot: 'C7',
    peripheralNerve: 'posterior_interosseous',
    peripheralNerveName: 'Posterior Interosseous Nerve (PIN)',
    action: 'Extends fingers at metacarpophalangeal joints',
    isKeyArbitrator: false
  },
  // CERVICAL - C8 / T1 / ULNAR CONFLICT
  {
    id: 'abductor_pollicis_brevis',
    name: 'Abductor Pollicis Brevis (APB)',
    commonName: 'Thumb Abduction (Perpendicular)',
    region: 'cervical',
    roots: ['C8', 'T1'],
    primaryRoot: 'T1',
    peripheralNerve: 'median_carpal_tunnel',
    peripheralNerveName: 'Median Nerve (Recurrent Motor Branch)',
    action: 'Abducts thumb perpendicularly to palm',
    isKeyArbitrator: true,
    arbitrationNote: 'KEY ARBITRATOR: Innervated by MEDIAN nerve (T1). In Cubital Tunnel or Ulnar Neuropathy, APB is 100% SPARED. In C8/T1 Radiculopathy or Thoracic Outlet Syndrome, APB is severely weak/atrophic.'
  },
  {
    id: 'first_dorsal_interosseous',
    name: 'First Dorsal Interosseous (FDI)',
    commonName: 'Index Finger Abduction',
    region: 'cervical',
    roots: ['C8', 'T1'],
    primaryRoot: 'C8',
    peripheralNerve: 'ulnar_cubital_tunnel',
    peripheralNerveName: 'Deep branch of Ulnar Nerve',
    action: 'Abducts index finger toward radial side',
    isKeyArbitrator: true,
    arbitrationNote: 'Classic ulnar territory. Weak in both Ulnar entrapment and C8 root.'
  },
  {
    id: 'abductor_digiti_minimi',
    name: 'Abductor Digiti Minimi (ADM)',
    commonName: 'Little Finger Abduction',
    region: 'cervical',
    roots: ['C8', 'T1'],
    primaryRoot: 'C8',
    peripheralNerve: 'ulnar_cubital_tunnel',
    peripheralNerveName: 'Ulnar Nerve',
    action: 'Abducts fifth digit',
    isKeyArbitrator: false
  },
  {
    id: 'flexor_pollicis_longus',
    name: 'Flexor Pollicis Longus (FPL)',
    commonName: 'Thumb IP Joint Flexion',
    region: 'cervical',
    roots: ['C8', 'T1'],
    primaryRoot: 'C8',
    peripheralNerve: 'anterior_interosseous',
    peripheralNerveName: 'Anterior Interosseous Nerve (AIN)',
    action: 'Flexes interphalangeal joint of thumb',
    isKeyArbitrator: true,
    arbitrationNote: 'Median (AIN) C8 muscle. Spared in ulnar neuropathy; impaired in C8 radiculopathy or AIN syndrome (Kiloh-Nevin).'
  },

  // LUMBOSACRAL - L2 / L3 / L4 / FEMORAL CONFLICT
  {
    id: 'iliopsoas',
    name: 'Iliopsoas',
    commonName: 'Hip Flexion',
    region: 'lumbosacral',
    roots: ['L1', 'L2', 'L3'],
    primaryRoot: 'L2',
    peripheralNerve: 'femoral',
    peripheralNerveName: 'Lumbar Plexus / Femoral Nerve',
    action: 'Flexes thigh at hip joint',
    isKeyArbitrator: true,
    arbitrationNote: 'Innervated before inguinal ligament. Spared in distal femoral neuropathy, weak in high lumbar radiculopathy or retroperitoneal hematoma.'
  },
  {
    id: 'quadriceps_femoris',
    name: 'Quadriceps Femoris',
    commonName: 'Knee Extension',
    region: 'lumbosacral',
    roots: ['L2', 'L3', 'L4'],
    primaryRoot: 'L3',
    peripheralNerve: 'femoral',
    peripheralNerveName: 'Femoral Nerve',
    action: 'Extends leg at knee joint',
    isKeyArbitrator: false
  },
  {
    id: 'adductor_longus',
    name: 'Adductor Longus / Magnus',
    commonName: 'Thigh Adduction',
    region: 'lumbosacral',
    roots: ['L2', 'L3', 'L4'],
    primaryRoot: 'L3',
    peripheralNerve: 'obturator',
    peripheralNerveName: 'Obturator Nerve',
    action: 'Adducts thigh at hip',
    isKeyArbitrator: true,
    arbitrationNote: 'GOLD STANDARD L3/L4 ARBITRATOR: Non-femoral L2-L4 muscle (Obturator nerve). If Adductors are weak/denervated, lesion is L3/L4 ROOT or Lumbar Plexopathy, NEVER isolated Femoral nerve!'
  },

  // LUMBOSACRAL - L5 / COMMON PERONEAL CONFLICT (THE CLASSIC FOOT DROP)
  {
    id: 'tibialis_anterior',
    name: 'Tibialis Anterior',
    commonName: 'Ankle Dorsiflexion',
    region: 'lumbosacral',
    roots: ['L4', 'L5'],
    primaryRoot: 'L4',
    peripheralNerve: 'deep_peroneal',
    peripheralNerveName: 'Deep Peroneal (Fibular) Nerve',
    action: 'Dorsiflexes ankle and inverts foot',
    isKeyArbitrator: false
  },
  {
    id: 'extensor_hallucis_longus',
    name: 'Extensor Hallucis Longus (EHL)',
    commonName: 'Great Toe Extension',
    region: 'lumbosacral',
    roots: ['L5'],
    primaryRoot: 'L5',
    peripheralNerve: 'deep_peroneal',
    peripheralNerveName: 'Deep Peroneal (Fibular) Nerve',
    action: 'Extends great toe',
    isKeyArbitrator: false
  },
  {
    id: 'peroneus_longus',
    name: 'Peroneus (Fibularis) Longus/Brevis',
    commonName: 'Foot Eversion',
    region: 'lumbosacral',
    roots: ['L5', 'S1'],
    primaryRoot: 'L5',
    peripheralNerve: 'superficial_peroneal',
    peripheralNerveName: 'Superficial Peroneal Nerve',
    action: 'Everts foot and weakly plantarflexes',
    isKeyArbitrator: false
  },
  {
    id: 'tibialis_posterior',
    name: 'Tibialis Posterior',
    commonName: 'Foot Inversion',
    region: 'lumbosacral',
    roots: ['L4', 'L5'],
    primaryRoot: 'L5',
    peripheralNerve: 'tibial_tarsal_tunnel',
    peripheralNerveName: 'Tibial Nerve (Sciatic division)',
    action: 'Inverts foot in plantarflexion',
    isKeyArbitrator: true,
    arbitrationNote: 'THE SUPREME CLINICAL ARBITRATOR FOR FOOT DROP: Innervated by L5 via TIBIAL nerve. In Common Peroneal Neuropathy at fibular head, Tibialis Posterior is 100% NORMAL. In L5 Radiculopathy or Sciatic trunk injury, Foot Inversion is WEAK!'
  },
  {
    id: 'gluteus_medius',
    name: 'Gluteus Medius',
    commonName: 'Hip Abduction / Pelvic Leveling',
    region: 'lumbosacral',
    roots: ['L4', 'L5', 'S1'],
    primaryRoot: 'L5',
    peripheralNerve: 'sciatic_piriformis', // Superior Gluteal
    peripheralNerveName: 'Superior Gluteal Nerve',
    action: 'Abducts hip, prevents pelvic drop (Trendelenburg)',
    isKeyArbitrator: true,
    arbitrationNote: 'Proximal L5 muscle outside lower limb. Weakness indicates L5 radiculopathy or sacral plexus, ruling out peroneal or sciatic knee-level lesions.'
  },

  // LUMBOSACRAL - S1 / SCIATIC / TIBIAL CONFLICT
  {
    id: 'gastrocnemius_soleus',
    name: 'Gastrocnemius & Soleus',
    commonName: 'Ankle Plantarflexion (Toe Walking)',
    region: 'lumbosacral',
    roots: ['S1', 'S2'],
    primaryRoot: 'S1',
    peripheralNerve: 'tibial_tarsal_tunnel',
    peripheralNerveName: 'Tibial Nerve',
    action: 'Plantarflexes foot at ankle joint',
    isKeyArbitrator: true,
    arbitrationNote: 'Weak in S1 radiculopathy and tibial neuropathy. Spared in isolated peroneal nerve injury.'
  },
  {
    id: 'gluteus_maximus',
    name: 'Gluteus Maximus',
    commonName: 'Hip Extension',
    region: 'lumbosacral',
    roots: ['L5', 'S1', 'S2'],
    primaryRoot: 'S1',
    peripheralNerve: 'sciatic_piriformis',
    peripheralNerveName: 'Inferior Gluteal Nerve',
    action: 'Extends thigh at hip joint',
    isKeyArbitrator: true,
    arbitrationNote: 'Proximal S1 muscle. Spared in lower leg tibial/peroneal entrapment; weak in S1 radiculopathy or lumbosacral trunk injury.'
  }
];

export const SENSORY_ZONES: SensoryZone[] = [
  // CERVICAL
  {
    id: 'c5_deltoid_patch',
    name: 'Deltoid / Lateral Shoulder Patch (Regimental Badge)',
    region: 'cervical',
    rootLevel: 'C5',
    peripheralNerve: 'axillary',
    peripheralNerveName: 'Superior Lateral Cutaneous Nerve of Arm (Axillary)',
    anatomicalLocation: 'Lateral upper arm over the lower half of deltoid',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'Classic C5 dermatomal center'
  },
  {
    id: 'c6_radial_forearm_thumb',
    name: 'Thumb & Radial Hand (Dorsal & Volar)',
    region: 'cervical',
    rootLevel: 'C6',
    peripheralNerve: 'median_carpal_tunnel',
    peripheralNerveName: 'Digital cutaneous branch of Median Nerve (Volar) / Superficial Radial (Dorsal)',
    anatomicalLocation: 'Pad of thumb and index finger tip',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'C6 dermatome extends up lateral forearm; Median nerve is restricted distal to wrist crease'
  },
  {
    id: 'c6_palmar_cutaneous',
    name: 'Thenar Eminence Palm (Palmar Cutaneous Branch)',
    region: 'cervical',
    rootLevel: 'C6',
    peripheralNerve: 'median_pronator_teres',
    peripheralNerveName: 'Palmar Cutaneous Branch of Median Nerve',
    anatomicalLocation: 'Base of thenar eminence on palm',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'CRITICAL ARBITRATOR: Travels SUPERFICIAL to flexor retinaculum. 100% SPARED in Carpal Tunnel Syndrome. NUMB in C6 Radiculopathy or Pronator Syndrome.'
  },
  {
    id: 'c7_middle_finger',
    name: 'Middle Finger Pad',
    region: 'cervical',
    rootLevel: 'C7',
    peripheralNerve: 'median_carpal_tunnel',
    peripheralNerveName: 'Median Nerve (Palmar Digital)',
    anatomicalLocation: 'Volar tip of third digit',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'C7 central dermatome; shared with median distribution'
  },
  {
    id: 'c8_hypothenar_fifth_digit',
    name: 'Little Finger & Hypothenar Border',
    region: 'cervical',
    rootLevel: 'C8',
    peripheralNerve: 'ulnar_cubital_tunnel',
    peripheralNerveName: 'Palmar & Dorsal cutaneous branches of Ulnar Nerve',
    anatomicalLocation: 'Fifth digit and medial palmar margin',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'C8 dermatome continues proximally onto medial wrist and distal forearm'
  },
  {
    id: 't1_medial_forearm',
    name: 'Medial Forearm (Medial Antebrachial Cutaneous)',
    region: 'cervical',
    rootLevel: 'T1',
    peripheralNerve: 'thoracic_outlet_neurogenic',
    peripheralNerveName: 'Medial Antebrachial Cutaneous Nerve (Direct Medial Cord)',
    anatomicalLocation: 'Ulnar side of forearm between elbow and wrist',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'KEY ARBITRATOR: Spared in Ulnar Neuropathy at elbow/wrist. Involved in T1 Radiculopathy or True Neurogenic Thoracic Outlet Syndrome!'
  },

  // LUMBOSACRAL
  {
    id: 'l2_l3_anterior_thigh',
    name: 'Anterior & Medial Thigh',
    region: 'lumbosacral',
    rootLevel: 'L2',
    peripheralNerve: 'femoral',
    peripheralNerveName: 'Anterior Cutaneous branches of Femoral Nerve',
    anatomicalLocation: 'Mid-anterior thigh',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'L2/L3 dermatomes'
  },
  {
    id: 'lateral_femoral_meralgia',
    name: 'Anterolateral Thigh (Meralgia Paresthetica)',
    region: 'lumbosacral',
    rootLevel: 'L2',
    peripheralNerve: 'lateral_femoral_cutaneous',
    peripheralNerveName: 'Lateral Femoral Cutaneous Nerve (LFCN)',
    anatomicalLocation: 'Outer lateral thigh, pocket region, no motor involvement',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'Pure sensory entrapment under inguinal ligament. Quad strength and knee jerk are 100% NORMAL.'
  },
  {
    id: 'l4_medial_leg_malleolus',
    name: 'Medial Leg & Medial Malleolus (Saphenous)',
    region: 'lumbosacral',
    rootLevel: 'L4',
    peripheralNerve: 'femoral',
    peripheralNerveName: 'Saphenous Nerve (Terminal Femoral branch)',
    anatomicalLocation: 'Medial shin down to medial malleolus',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'L4 dermatome matches saphenous cutaneous field'
  },
  {
    id: 'l5_first_web_space',
    name: 'First Dorsal Web Space (Between 1st & 2nd Toe)',
    region: 'lumbosacral',
    rootLevel: 'L5',
    peripheralNerve: 'deep_peroneal',
    peripheralNerveName: 'Deep Peroneal (Fibular) Autonomous Zone',
    anatomicalLocation: 'Triangular skin patch between big toe and second toe',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'Pure autonomous sensory zone of Deep Peroneal Nerve'
  },
  {
    id: 'l5_dorsum_foot',
    name: 'Dorsum of Foot & Anterolateral Shin',
    region: 'lumbosacral',
    rootLevel: 'L5',
    peripheralNerve: 'superficial_peroneal',
    peripheralNerveName: 'Superficial Peroneal Nerve',
    anatomicalLocation: 'Mid and lateral dorsum of foot excluding first web space',
    isAutonomicAutonomousZone: false,
    dermatomeCoverage: 'L5 dermatome encompasses both deep and superficial peroneal fields'
  },
  {
    id: 's1_lateral_foot_heel',
    name: 'Lateral Foot & Plantar Heel / Sural Territory',
    region: 'lumbosacral',
    rootLevel: 'S1',
    peripheralNerve: 'sciatic_piriformis',
    peripheralNerveName: 'Sural Nerve (Sciatic/Tibial branch)',
    anatomicalLocation: 'Lateral border of foot, fifth digit, and posterior calf',
    isAutonomicAutonomousZone: true,
    dermatomeCoverage: 'S1 dermatome matches sural nerve autonomous zone'
  }
];

export const REFLEXES: ReflexTest[] = [
  {
    id: 'biceps_jerk',
    name: 'Biceps Reflex',
    tendon: 'Biceps tendon at antecubital fossa',
    root: 'C5',
    peripheralNerve: 'Musculocutaneous Nerve',
    normalGrade: 2
  },
  {
    id: 'brachioradialis_jerk',
    name: 'Brachioradialis (Supinator) Reflex',
    tendon: 'Styloid process of radius',
    root: 'C6',
    peripheralNerve: 'Radial Nerve',
    normalGrade: 2
  },
  {
    id: 'triceps_jerk',
    name: 'Triceps Reflex',
    tendon: 'Triceps tendon above olecranon',
    root: 'C7',
    peripheralNerve: 'Radial Nerve',
    normalGrade: 2
  },
  {
    id: 'patellar_jerk',
    name: 'Patellar (Knee) Reflex',
    tendon: 'Patellar tendon below inferior pole of patella',
    root: 'L4',
    peripheralNerve: 'Femoral Nerve',
    normalGrade: 2
  },
  {
    id: 'achilles_jerk',
    name: 'Achilles (Ankle) Reflex',
    tendon: 'Achilles tendon',
    root: 'S1',
    peripheralNerve: 'Tibial Nerve',
    normalGrade: 2
  }
];

export const PATHOGNOMONIC_TESTS: PathognomonicTest[] = [
  {
    id: 'spurlings_test',
    name: "Spurling's Maneuver (Neck Compression)",
    region: 'cervical',
    targets: ['root'],
    description: 'Provocative cervical foraminal compression test.',
    procedure: 'Extend cervical spine, laterally rotate head toward symptomatic side, and apply gentle axial downward compression on vertex.',
    positiveIndication: 'Sharp, electric radicular shooting pain radiating down ipsilateral arm matching dermatome.',
    specificityRate: '93% - 100% Specific for Cervical Nerve Root Compression',
    conflictingEntities: ['Carpal Tunnel Syndrome', 'Cubital Tunnel Syndrome', 'Rotator Cuff Pathology']
  },
  {
    id: 'phalens_tinel_cts',
    name: "Phalen's Maneuver & Tinel at Carpal Tunnel",
    region: 'cervical',
    targets: ['nerve'],
    description: 'Dynamic median nerve provocation at the wrist flexor retinaculum.',
    procedure: 'Hold wrists in maximum unforced flexion for 60 seconds (Phalen) or tap lightly over median nerve at volar wrist crease (Tinel).',
    positiveIndication: 'Paresthesia radiating into thumb, index, middle finger within 30-60 seconds. Note: Palmar thenar base is spared.',
    specificityRate: '88% - 92% Specific for Median Entrapment at Transverse Carpal Ligament',
    conflictingEntities: ['C6 Radiculopathy', 'Pronator Teres Syndrome']
  },
  {
    id: 'elbow_flexion_tinel_cubital',
    name: 'Elbow Flexion Test & Tinel at Retrocondylar Groove',
    region: 'cervical',
    targets: ['nerve'],
    description: 'Dynamic ulnar nerve provocation at the cubital tunnel.',
    procedure: 'Full elbow flexion with wrist extension for up to 3 minutes, plus percussion directly over retrocondylar groove behind medial epicondyle.',
    positiveIndication: 'Reproduction of numbness, tingling, or pain along little finger and medial half of ring finger.',
    specificityRate: '95% Specific for Cubital Tunnel Entrapment',
    conflictingEntities: ['C8 Radiculopathy', 'Thoracic Outlet Syndrome']
  },
  {
    id: 'straight_leg_raise',
    name: "Straight Leg Raise (Lasegue's Sign) & Braggard's",
    region: 'lumbosacral',
    targets: ['root'],
    description: 'Dural root traction test for lumbosacral radiculopathy.',
    procedure: 'Passive straight leg elevation from 30 to 70 degrees; lower 5 degrees and dorsiflex ankle (Braggard test).',
    positiveIndication: 'True lancinating radicular pain radiating below knee down along L5 or S1 dermatome.',
    specificityRate: '85% - 90% Sensitive/Specific for L5/S1 Disc Herniation',
    conflictingEntities: ['Common Peroneal Neuropathy', 'Piriformis Syndrome', 'Hamstring Tightness']
  },
  {
    id: 'fibular_neck_tinel',
    name: 'Fibular Head Percussion (Tinel at Fibular Neck)',
    region: 'lumbosacral',
    targets: ['nerve'],
    description: 'Direct superficial focal percussion of the common peroneal nerve as it winds around the fibular neck.',
    procedure: 'Firmly tap immediately posterior and inferior to the lateral fibular head.',
    positiveIndication: 'Electric shock tingling radiating down anterolateral lower leg and across dorsum of foot. SLR is completely negative.',
    specificityRate: '89% Specific for Common Peroneal Nerve Entrapment',
    conflictingEntities: ['L5 Radiculopathy']
  },
  {
    id: 'femoral_nerve_stretch',
    name: 'Femoral Nerve Stretch Test (Reverse Lasegue)',
    region: 'lumbosacral',
    targets: ['root'],
    description: 'High lumbar (L2-L4) nerve root dural traction maneuver.',
    procedure: 'Patient prone; examiner flexes knee to 90 degrees and gently extends hip upward.',
    positiveIndication: 'Sharp anterior thigh pain radiating down along L3/L4 distribution.',
    specificityRate: '88% Specific for L2/L3/L4 Upper Lumbar Radiculopathy',
    conflictingEntities: ['Meralgia Paresthetica', 'Hip Joint Pathology']
  }
];

export const CONFLICT_SCENARIOS: ConflictScenario[] = [
  {
    id: 'c6_vs_carpal_tunnel',
    region: 'cervical',
    title: 'C6 Radiculopathy vs. Carpal Tunnel Syndrome (CTS)',
    subtitle: 'Distinguishing 6th cervical root compression from median nerve entrapment at flexor retinaculum',
    rootCandidate: 'C6',
    nerveCandidate: 'median_carpal_tunnel',
    nerveCandidateName: 'Median Nerve (Carpal Tunnel)',
    primaryPresentation: 'Numbness, tingling, and paresthesias in the thumb, index finger, and radial hand with hand weakness.',
    keyDifferentiatorMuscle: 'Pronator Teres & Biceps / Brachioradialis',
    keyDifferentiatorExplanation: 'Pronator Teres is innervated by the Median Nerve in the proximal forearm (C6, C7) BEFORE entering the carpal tunnel. In Carpal Tunnel Syndrome, Pronator Teres is 100% SPARED (Grade 5/5). In C6 Radiculopathy, Pronator Teres, Biceps, and Brachioradialis are frequently weakened and Biceps/Brachioradialis jerks diminished. Crucially, the Palmar Cutaneous Branch of the Median Nerve branches 3cm PROXIMAL to the wrist and passes OVER the retinaculum: sensation over the thenar eminence palm is PRESERVED in CTS, but REDUCED in C6 radiculopathy.',
    pathognomonicTestId: 'spurlings_test',
    emgKeyDifferentiator: 'EMG demonstrates paraspinal denervation potentials in C6 radiculopathy; sensory nerve action potentials (SNAP) from thumb/index remain NORMAL in pre-ganglionic C6 root lesions, whereas median SNAP is delayed or absent in post-ganglionic CTS.',
    doubleCrushRiskExplanation: 'High frequency of tandem cervical C6 foraminal narrowing and carpal tunnel entrapment (Double-Crush Syndrome). Axoplasmic flow impaired at neck sensitizes distal median axons to subclinical compression.'
  },
  {
    id: 'c7_vs_radial_pin',
    region: 'cervical',
    title: 'C7 Radiculopathy vs. Radial Neuropathy / Posterior Interosseous (PIN)',
    subtitle: 'Distinguishing 7th cervical root compression from radial nerve entrapment at spiral groove or arcade of Frohse',
    rootCandidate: 'C7',
    nerveCandidate: 'radial_spiral_groove',
    nerveCandidateName: 'Radial Nerve / PIN',
    primaryPresentation: 'Wrist drop or finger extension weakness with middle finger sensory disturbance.',
    keyDifferentiatorMuscle: 'Triceps Brachii & Latissimus Dorsi',
    keyDifferentiatorExplanation: 'Triceps is innervated in the axilla before the spiral groove. In classic spiral groove palsy or PIN syndrome, Triceps strength (and reflex) is preserved. Furthermore, Latissimus Dorsi (thoracodorsal nerve) and Flexor Carpi Radialis (median nerve) are C7-innervated non-radial muscles. If Latissimus or FCR are weak/denervated, lesion is unequivocally at the C7 ROOT or cord level, NOT isolated radial nerve.',
    pathognomonicTestId: 'spurlings_test',
    emgKeyDifferentiator: 'C7 Radiculopathy spares the Superficial Radial SNAP (normal amplitude) due to pre-ganglionic lesion. Radial neuropathy at spiral groove exhibits reduced or absent radial SNAP.',
    doubleCrushRiskExplanation: 'C7 root irritation frequently coexists with lateral epicondylitis/radial tunnel syndrome due to hypertonicity in extensor carpi radialis brevis.'
  },
  {
    id: 'c8_t1_vs_cubital_tunnel',
    region: 'cervical',
    title: 'C8/T1 Radiculopathy vs. Ulnar Neuropathy at Cubital Tunnel',
    subtitle: 'Distinguishing lower trunk/C8-T1 root compression from retrocondylar ulnar nerve entrapment',
    rootCandidate: 'C8',
    nerveCandidate: 'ulnar_cubital_tunnel',
    nerveCandidateName: 'Ulnar Nerve (Cubital Tunnel)',
    primaryPresentation: 'Guttering and intrinsic hand weakness with numbness of the 4th and 5th digits.',
    keyDifferentiatorMuscle: 'Abductor Pollicis Brevis (APB) & Flexor Pollicis Longus (FPL)',
    keyDifferentiatorExplanation: 'Abductor Pollicis Brevis (APB) is innervated by T1 via the MEDIAN nerve. In Ulnar Neuropathy at the elbow, APB is completely normal (Grade 5/5) and medial antebrachial cutaneous sensation is intact. In C8/T1 Radiculopathy or Thoracic Outlet Syndrome, APB and FPL are weak and atrophic alongside FDI and hypothenars.',
    pathognomonicTestId: 'elbow_flexion_tinel_cubital',
    emgKeyDifferentiator: 'Ulnar SNAP across the elbow is abnormal in cubital tunnel syndrome. In C8 preganglionic root lesions, Ulnar sensory SNAP is normal, but cervical paraspinal musculature reveals acute denervation.',
    doubleCrushRiskExplanation: 'C8 root compromise weakens axonal transport, markedly increasing vulnerability to compression at Osborne ligament.'
  },
  {
    id: 'l5_vs_common_peroneal',
    region: 'lumbosacral',
    title: 'L5 Radiculopathy vs. Common Peroneal (Fibular) Neuropathy',
    subtitle: 'The ultimate foot drop conflict: 5th lumbar nerve root vs. fibular head nerve compression',
    rootCandidate: 'L5',
    nerveCandidate: 'common_peroneal_fibular_neck',
    nerveCandidateName: 'Common Peroneal (Fibular) Nerve',
    primaryPresentation: 'Acute or progressive Foot Drop, slap gait, inability to heel walk, dorsum foot paresthesias.',
    keyDifferentiatorMuscle: 'Tibialis Posterior (Foot Inversion) & Gluteus Medius',
    keyDifferentiatorExplanation: 'GOLD STANDARD CLINICAL TEST: Tibialis Posterior (inversion of plantarflexed foot) is innervated by L5 through the TIBIAL NERVE. In Common Peroneal Neuropathy at the fibular head, Tibialis Posterior is completely normal (5/5). If foot inversion or hip abduction (Gluteus Medius) is WEAK, the lesion is unequivocally an L5 ROOT or Sciatic nerve lesion, NEVER isolated peroneal nerve compression!',
    pathognomonicTestId: 'fibular_neck_tinel',
    emgKeyDifferentiator: 'Superficial Peroneal SNAP is normal in preganglionic L5 radiculopathy; abolished or delayed in postganglionic peroneal neuropathy at fibular head. Paraspinal fibrillations present in L5 root lesion.',
    doubleCrushRiskExplanation: 'L4/L5 disc herniation predisposing patient to heightened fibular head compressive neuropathy during leg crossing or hospitalization.'
  },
  {
    id: 'l4_vs_femoral_neuropathy',
    region: 'lumbosacral',
    title: 'L4 Radiculopathy vs. Femoral Neuropathy',
    subtitle: 'Distinguishing 4th lumbar root compression from femoral nerve palsy or hematoma',
    rootCandidate: 'L4',
    nerveCandidate: 'femoral',
    nerveCandidateName: 'Femoral Nerve',
    primaryPresentation: 'Knee buckling, quadriceps atrophy, diminished patellar reflex, anterior thigh/medial shin numbness.',
    keyDifferentiatorMuscle: 'Adductor Longus / Thigh Adductors',
    keyDifferentiatorExplanation: 'Thigh Adductors are innervated by the OBTURATOR nerve from roots L2-L4. In isolated Femoral Neuropathy, thigh adduction is 100% normal. In L3/L4 Radiculopathy or lumbar plexopathy, Adductor Longus is weak and denervated along with Quadriceps.',
    pathognomonicTestId: 'femoral_nerve_stretch',
    emgKeyDifferentiator: 'Saphenous SNAP is normal in preganglionic L4 radiculopathy; absent in femoral neuropathy. Lumbar paraspinal mapping confirms root localization.',
    doubleCrushRiskExplanation: 'Upper lumbar foraminal stenosis coupled with psoas sheath or inguinal ligament tightness.'
  }
];
