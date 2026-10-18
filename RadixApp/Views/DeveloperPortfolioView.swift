import SwiftUI
import StoreKit

// MARK: - Developer Portfolio & Discoverability View
// Direct 1-Tap Navigation to All Apps by Dr. A. Alex Mohit
// Solves App Store Search Damping & Discoverability (ref: 1a371fae-7f7f-47fd-9757-e414e576c055)

public struct DeveloperPortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @Environment(\.requestReview) var requestReview
    
    @State private var hasRequestedReview = false
    
    struct PublishedApp: Identifiable {
        let id: String
        let name: String
        let subtitle: String
        let category: String
        let icon: String
        let accentColor: Color
        let appStoreUrl: String
        let priceTier: String
    }
    
    let publishedApps: [PublishedApp] = [
        PublishedApp(
            id: "neurocall",
            name: "NeuroCall",
            subtitle: "Neurosurgery Atlas & ER Triage",
            category: "Medical & Surgical Education",
            icon: "cross.case.fill",
            accentColor: ObsidianTheme.neonCyan,
            appStoreUrl: "https://apps.apple.com/app/id6809026331",
            priceTier: "Clinical Master Edition"
        ),
        PublishedApp(
            id: "lingo",
            name: "Hands-Free Lingo",
            subtitle: "Automated Language Audio Tutor",
            category: "Education & Productivity",
            icon: "waveform.badge.microphone",
            accentColor: ObsidianTheme.neonGreen,
            appStoreUrl: "https://apps.apple.com/app/id6799755633",
            priceTier: "Free Download"
        ),
        PublishedApp(
            id: "somnalux",
            name: "SomnaLux",
            subtitle: "Predictive Sleep & Circadian Recovery",
            category: "Health & Vitality",
            icon: "moon.stars.fill",
            accentColor: ObsidianTheme.neonPurple,
            appStoreUrl: "https://apps.apple.com/app/id6804514882",
            priceTier: "$1.99"
        ),
        PublishedApp(
            id: "pjkpredict",
            name: "PJKPredict",
            subtitle: "Proximal Junctional Kyphosis Risk",
            category: "Spine Surgery Risk Radar",
            icon: "figure.walk",
            accentColor: ObsidianTheme.neonAmber,
            appStoreUrl: "https://apps.apple.com/app/id6809026331",
            priceTier: "$3.99"
        ),
        PublishedApp(
            id: "bioradar",
            name: "BioRadar",
            subtitle: "Oura & Apple Health Biomarker Sync",
            category: "Biometric Longevity",
            icon: "heart.text.square.fill",
            accentColor: ObsidianTheme.neonRose,
            appStoreUrl: "https://apps.apple.com/app/id6790217249",
            priceTier: "$3.99"
        )
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Banner
                    VStack(spacing: 6) {
                        Image(systemName: "person.crop.circle.badge.checkmark")
                            .font(.system(size: 44))
                            .foregroundColor(ObsidianTheme.neonCyan)
                            .padding(.top, 10)
                        
                        Text("Dr. A. Alex Mohit Apps")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(ObsidianTheme.textPrimary)
                        
                        Text("Physician-Engineered iOS Applications")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(ObsidianTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    
                    // Search Tip Card (Solves Family Discoverability Issue)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .foregroundColor(ObsidianTheme.neonAmber)
                            Text("APP STORE DISCOVERY TIP")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(ObsidianTheme.neonAmber)
                        }
                        
                        Text("To find all apps by Dr. Mohit on any iPhone, search his registered developer name directly in the App Store search bar:")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        
                        HStack {
                            Text("ABDI ALEX MOHIT")
                                .font(.system(size: 14, weight: .black, design: .monospaced))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(6)
                            
                            Spacer()
                            
                            Button(action: {
                                UIPasteboard.general.string = "ABDI ALEX MOHIT"
                                HapticManager.impact(style: .medium)
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "doc.on.doc")
                                    Text("Copy")
                                }
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(ObsidianTheme.neonCyan)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(ObsidianTheme.neonCyan.opacity(0.15))
                                .cornerRadius(6)
                            }
                        }
                    }
                    .padding(14)
                    .background(Color(red: 0.12, green: 0.15, blue: 0.22))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.neonAmber.opacity(0.4), lineWidth: 1))
                    .padding(.horizontal)
                    
                    // Rate NeuroCall Action (Unlocks 5-Rating Search Algorithm Multiplier)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("SUPPORT APP DISCOVERABILITY")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(.yellow)
                        }
                        
                        Text("Apple requires an initial cohort of 5-star ratings before newly published apps index prominently in search results. Please rate NeuroCall:")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(ObsidianTheme.textSecondary)
                        
                        Button(action: {
                            HapticManager.impact(style: .heavy)
                            requestReview()
                            hasRequestedReview = true
                        }) {
                            HStack {
                                Image(systemName: hasRequestedReview ? "checkmark.circle.fill" : "star.leadinghalf.filled")
                                Text(hasRequestedReview ? "Thank You for Rating!" : "Leave a 5-Star Rating")
                            }
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.yellow)
                            .cornerRadius(10)
                        }
                    }
                    .padding(14)
                    .background(Color(red: 0.14, green: 0.16, blue: 0.18))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
                    .padding(.horizontal)
                    
                    // Published Apps List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("PORTFOLIO OF LIVE APPLICATIONS")
                            .font(.system(size: 11, weight: .black))
                            .tracking(1.5)
                            .foregroundColor(ObsidianTheme.textTertiary)
                            .padding(.horizontal)
                        
                        ForEach(publishedApps) { app in
                            Button(action: {
                                HapticManager.impact(style: .medium)
                                if let url = URL(string: app.appStoreUrl) {
                                    openURL(url)
                                }
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: app.icon)
                                        .font(.system(size: 20))
                                        .foregroundColor(app.accentColor)
                                        .frame(width: 44, height: 44)
                                        .background(app.accentColor.opacity(0.15))
                                        .cornerRadius(10)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        HStack {
                                            Text(app.name)
                                                .font(.system(size: 15, weight: .bold))
                                                .foregroundColor(ObsidianTheme.textPrimary)
                                            Spacer()
                                            Text(app.priceTier)
                                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                                .foregroundColor(app.accentColor)
                                        }
                                        
                                        Text(app.subtitle)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(ObsidianTheme.textSecondary)
                                        
                                        Text(app.category)
                                            .font(.system(size: 10, weight: .regular))
                                            .foregroundColor(ObsidianTheme.textTertiary)
                                    }
                                    
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(ObsidianTheme.textTertiary)
                                }
                                .padding(12)
                                .background(Color(red: 0.10, green: 0.12, blue: 0.16))
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(ObsidianTheme.borderSubtle, lineWidth: 1))
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Copyright Footer
                    VStack(spacing: 4) {
                        Text("Copyright © 2026 A. Alex Mohit")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(ObsidianTheme.textTertiary)
                        Text("All Rights Reserved • Native SwiftUI iOS 18+")
                            .font(.system(size: 10, weight: .regular))
                            .foregroundColor(ObsidianTheme.textTertiary.opacity(0.7))
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
            .obsidianCockpitBackground()
            .navigationTitle("Developer Portfolio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(ObsidianTheme.neonCyan)
                }
            }
        }
    }
}
