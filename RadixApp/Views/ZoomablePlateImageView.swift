import SwiftUI

// MARK: - Zoomable Plate Image View
// Reusable high-definition radiographic & anatomic plate viewer with smooth 1.0x to 5.0x pinch-to-zoom,
// drag panning, double-tap to reset, and persistent zero-glitch aspect ratio bounds.

public struct ZoomablePlateImageView: View {
    public let imageName: String
    public var contentHeight: CGFloat = 290
    public var onExpand: (() -> Void)? = nil
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    public init(imageName: String, contentHeight: CGFloat = 290, onExpand: (() -> Void)? = nil) {
        self.imageName = imageName
        self.contentHeight = contentHeight
        self.onExpand = onExpand
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
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
                                        withAnimation(.spring()) {
                                            scale = 1.0
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                },
                            DragGesture()
                                .onChanged { value in
                                    if scale > 1.05 {
                                        offset = CGSize(
                                            width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height
                                        )
                                    }
                                }
                                .onEnded { _ in
                                    if scale > 1.05 {
                                        lastOffset = offset
                                    } else {
                                        withAnimation(.spring()) {
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    }
                                }
                        )
                    )
                
                // Double tap to reset
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        HapticManager.impact(style: .medium)
                        withAnimation(.spring()) {
                            scale = 1.0
                            offset = .zero
                            lastOffset = .zero
                        }
                    }
                    .allowsHitTesting(scale > 1.05)
                
                // Reset button overlay if zoomed
                if scale > 1.05 {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                HapticManager.impact(style: .light)
                                withAnimation(.spring()) {
                                    scale = 1.0
                                    offset = .zero
                                    lastOffset = .zero
                                }
                            }) {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.black.opacity(0.75))
                                    .clipShape(Circle())
                            }
                            .padding(8)
                        }
                        Spacer()
                    }
                }
            }
            .clipped()
        }
        .frame(height: contentHeight)
    }
}
