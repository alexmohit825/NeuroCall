import SwiftUI

// MARK: - Zoomable & Swipe-Navigable Plate Image View
// Reusable high-definition radiographic & surgical plate viewer with:
// 1. Smooth 1.0x to 5.0x pinch-to-zoom (MagnificationGesture).
// 2. Full 2-finger or 1-finger panning in any direction (including side-to-side) when zoomed.
// 3. Side-to-side horizontal swipe navigation (ahead / back) when at normal zoom (1.0x).
// 4. Double-tap quick-zoom (2.5x toggle) and reset.
// 5. Floating side chevrons and counterclockwise reset button.

public struct ZoomablePlateImageView: View {
    public let imageName: String
    public var contentHeight: CGFloat = 320
    public var onSwipeNext: (() -> Void)? = nil
    public var onSwipePrevious: (() -> Void)? = nil
    public var panelLabel: String? = nil
    public var onExpand: (() -> Void)? = nil
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var dragTranslation: CGFloat = 0
    
    public init(
        imageName: String,
        contentHeight: CGFloat = 320,
        onSwipeNext: (() -> Void)? = nil,
        onSwipePrevious: (() -> Void)? = nil,
        panelLabel: String? = nil,
        onExpand: (() -> Void)? = nil
    ) {
        self.imageName = imageName
        self.contentHeight = contentHeight
        self.onSwipeNext = onSwipeNext
        self.onSwipePrevious = onSwipePrevious
        self.panelLabel = panelLabel
        self.onExpand = onExpand
    }
    
    private var isZoomed: Bool {
        scale > 1.05
    }
    
    private func resetZoom() {
        HapticManager.impact(style: .light)
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            scale = 1.0
            lastScale = 1.0
            offset = .zero
            lastOffset = .zero
            dragTranslation = 0
        }
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                
                // Image Canvas with Pinch & Drag Gestures
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            // 1. Pinch to Zoom Gesture (1.0x to 5.0x)
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / lastScale
                                    lastScale = value
                                    let newScale = scale * delta
                                    scale = min(max(newScale, 1.0), 5.0)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                    if scale <= 1.05 {
                                        resetZoom()
                                    }
                                },
                            // 2. Drag Gesture: Pan when zoomed, Swipe when unzoomed
                            DragGesture(minimumDistance: 10)
                                .onChanged { value in
                                    if isZoomed {
                                        // Panning zoomed image side-to-side and up/down
                                        let maxOffsetX = (geo.size.width * (scale - 1)) / 2 + 50
                                        let maxOffsetY = (geo.size.height * (scale - 1)) / 2 + 50
                                        let proposedX = lastOffset.width + value.translation.width
                                        let proposedY = lastOffset.height + value.translation.height
                                        offset = CGSize(
                                            width: min(max(proposedX, -maxOffsetX), maxOffsetX),
                                            height: min(max(proposedY, -maxOffsetY), maxOffsetY)
                                        )
                                    } else {
                                        // Slight dynamic resistance when dragging unzoomed
                                        dragTranslation = value.translation.width
                                    }
                                }
                                .onEnded { value in
                                    if isZoomed {
                                        lastOffset = offset
                                    } else {
                                        // Side-to-side horizontal swipe navigation
                                        let dx = value.translation.width
                                        let dy = value.translation.height
                                        if abs(dx) > 35 && abs(dx) > abs(dy) * 1.1 {
                                            if dx < 0 {
                                                // Swiped Left -> Navigate Ahead
                                                if let onSwipeNext = onSwipeNext {
                                                    HapticManager.impact(style: .medium)
                                                    onSwipeNext()
                                                }
                                            } else {
                                                // Swiped Right -> Navigate Back
                                                if let onSwipePrevious = onSwipePrevious {
                                                    HapticManager.impact(style: .medium)
                                                    onSwipePrevious()
                                                }
                                            }
                                        }
                                        dragTranslation = 0
                                    }
                                }
                        )
                    )
                    // Double Tap Gesture: Toggle 2.5x Zoom vs Reset
                    .onTapGesture(count: 2) {
                        HapticManager.impact(style: .medium)
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            if isZoomed {
                                resetZoom()
                            } else {
                                scale = 2.5
                                lastScale = 2.5
                                offset = .zero
                                lastOffset = .zero
                            }
                        }
                    }
                
                // Persistent Side Chevron Navigation Buttons (when unzoomed and callbacks provided)
                if !isZoomed && (onSwipePrevious != nil || onSwipeNext != nil) {
                    HStack {
                        if let onSwipePrevious = onSwipePrevious {
                            Button(action: {
                                HapticManager.impact(style: .light)
                                onSwipePrevious()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 13, weight: .black))
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                                    .background(Color.black.opacity(0.65))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(ObsidianTheme.neonAmber.opacity(0.4), lineWidth: 1))
                            }
                            .padding(.leading, 8)
                        }
                        
                        Spacer()
                        
                        if let onSwipeNext = onSwipeNext {
                            Button(action: {
                                HapticManager.impact(style: .light)
                                onSwipeNext()
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .black))
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                                    .background(Color.black.opacity(0.65))
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(ObsidianTheme.neonAmber.opacity(0.4), lineWidth: 1))
                            }
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                // Top-Right Quick Reset Button (Visible when zoomed)
                if isZoomed {
                    VStack {
                        HStack {
                            Text("\(String(format: "%.1f", scale))x")
                                .font(.system(size: 11, weight: .black, design: .monospaced))
                                .foregroundColor(ObsidianTheme.neonAmber)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.85))
                                .cornerRadius(6)
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            Button(action: resetZoom) {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.system(size: 11, weight: .bold))
                                    Text("Reset")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Color.black.opacity(0.85))
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(ObsidianTheme.neonAmber.opacity(0.5), lineWidth: 1))
                            }
                            .padding(.trailing, 10)
                        }
                        .padding(.top, 8)
                        Spacer()
                    }
                }
                
                // Bottom Subtle Navigation / Zoom Hint
                VStack {
                    Spacer()
                    HStack {
                        if isZoomed {
                            Text("Drag to pan â€¢ Double-tap or tap Reset to exit zoom")
                                .font(.system(size: 9, weight: .medium))
                                .foregroundColor(ObsidianTheme.textMuted)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(4)
                        } else if onSwipeNext != nil || onSwipePrevious != nil {
                            Text("Slide finger â—€ â–¶ to navigate â€¢ Pinch to zoom")
                                .font(.system(size: 9, weight: .medium))
                                .foregroundColor(ObsidianTheme.textMuted)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.black.opacity(0.75))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.bottom, 6)
                }
            }
            .clipped()
        }
        .frame(height: contentHeight)
    }
}
