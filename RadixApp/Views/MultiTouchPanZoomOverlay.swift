import SwiftUI
import UIKit

// MARK: - Multi-Touch Hardware Pan & Pinch-Zoom Overlay
// Provides true dual-touch (2-finger) and single-touch (1-finger) hardware gesture tracking on iOS:
// 1. Simultaneous 2-finger pinch magnification (1.0x to 5.0x).
// 2. Continuous 2-finger panning/movement of the image side-to-side and vertically BEFORE zoom (1.0x) AND after zoom.
// 3. 1-finger horizontal sliding navigation (slide side-to-side to advance or go back a plate when unzoomed).
// 4. 1-finger panning of the magnified canvas when zoomed in (> 1.05x).
// 5. Two-finger tap detection (recenter / toggle zoom).
// 6. Double-tap quick-zoom toggle (2.5x <-> 1.0x).

public struct MultiTouchPanZoomOverlay: UIViewRepresentable {
    @Binding var scale: CGFloat
    @Binding var offset: CGSize
    var maxScale: CGFloat = 5.0
    var allowHorizontalSwipe: Bool = true
    var onSwipeNext: (() -> Void)? = nil
    var onSwipePrevious: (() -> Void)? = nil
    var onTwoFingerTap: (() -> Void)? = nil
    var onDoubleTap: (() -> Void)? = nil

    public init(
        scale: Binding<CGFloat>,
        offset: Binding<CGSize>,
        maxScale: CGFloat = 5.0,
        allowHorizontalSwipe: Bool = true,
        onSwipeNext: (() -> Void)? = nil,
        onSwipePrevious: (() -> Void)? = nil,
        onTwoFingerTap: (() -> Void)? = nil,
        onDoubleTap: (() -> Void)? = nil
    ) {
        self._scale = scale
        self._offset = offset
        self.maxScale = maxScale
        self.allowHorizontalSwipe = allowHorizontalSwipe
        self.onSwipeNext = onSwipeNext
        self.onSwipePrevious = onSwipePrevious
        self.onTwoFingerTap = onTwoFingerTap
        self.onDoubleTap = onDoubleTap
    }

    public func makeCoordinator() -> MultiTouchCoordinator {
        MultiTouchCoordinator(self)
    }

    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isMultipleTouchEnabled = true

        // 1. Pinch Gesture (1.0x to maxScale)
        let pinch = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(MultiTouchCoordinator.handlePinch(_:)))
        pinch.cancelsTouchesInView = false
        pinch.delaysTouchesBegan = false
        pinch.delegate = context.coordinator
        view.addGestureRecognizer(pinch)

        // 2. Dedicated Two-Finger Pan Gesture: Continuous side-to-side and 2D translation BEFORE & AFTER zoom
        let twoFingerPan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(MultiTouchCoordinator.handleTwoFingerPan(_:)))
        twoFingerPan.minimumNumberOfTouches = 2
        twoFingerPan.maximumNumberOfTouches = 2
        twoFingerPan.cancelsTouchesInView = false
        twoFingerPan.delaysTouchesBegan = false
        twoFingerPan.delegate = context.coordinator
        view.addGestureRecognizer(twoFingerPan)

        // 3. Dedicated One-Finger Pan Gesture: Horizontal slide to advance/retreat plate (unzoomed) or pan (zoomed)
        let oneFingerPan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(MultiTouchCoordinator.handleOneFingerPan(_:)))
        oneFingerPan.minimumNumberOfTouches = 1
        oneFingerPan.maximumNumberOfTouches = 1
        oneFingerPan.cancelsTouchesInView = false
        oneFingerPan.delaysTouchesBegan = false
        oneFingerPan.delegate = context.coordinator
        view.addGestureRecognizer(oneFingerPan)

        // 4. Two-Finger Tap Gesture
        let twoFingerTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(MultiTouchCoordinator.handleTwoFingerTap(_:)))
        twoFingerTap.numberOfTouchesRequired = 2
        twoFingerTap.numberOfTapsRequired = 1
        twoFingerTap.cancelsTouchesInView = false
        twoFingerTap.delaysTouchesBegan = false
        twoFingerTap.delegate = context.coordinator
        view.addGestureRecognizer(twoFingerTap)

        // 5. Double Tap (1-Finger) Quick-Zoom Toggle
        let doubleTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(MultiTouchCoordinator.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.cancelsTouchesInView = false
        doubleTap.delaysTouchesBegan = false
        doubleTap.delegate = context.coordinator
        view.addGestureRecognizer(doubleTap)

        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.parent = self
    }

    public class MultiTouchCoordinator: NSObject, UIGestureRecognizerDelegate {
        var parent: MultiTouchPanZoomOverlay
        var initialScale: CGFloat = 1.0

        init(_ parent: MultiTouchPanZoomOverlay) {
            self.parent = parent
        }

        // Allow simultaneous pinch and two-finger pan!
        public func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            if gestureRecognizer is UIPinchGestureRecognizer && otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
            if gestureRecognizer is UIPanGestureRecognizer && otherGestureRecognizer is UIPinchGestureRecognizer {
                return true
            }
            return false
        }

        @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
            switch recognizer.state {
            case .began:
                initialScale = parent.scale
            case .changed:
                let newScale = initialScale * recognizer.scale
                parent.scale = min(max(newScale, 1.0), parent.maxScale)
            case .ended, .cancelled:
                if parent.scale <= 1.05 {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        parent.scale = 1.0
                    }
                }
            default:
                break
            }
        }

        // Dedicated Two-Finger Pan: Moves image side-to-side and 2D space BEFORE zoom and AFTER zoom
        @objc func handleTwoFingerPan(_ recognizer: UIPanGestureRecognizer) {
            guard let view = recognizer.view else { return }
            let translation = recognizer.translation(in: view)
            
            parent.offset.width += translation.x
            parent.offset.height += translation.y
            recognizer.setTranslation(.zero, in: view)
        }

        // Dedicated One-Finger Pan: Navigates side-to-side when unzoomed; pans when zoomed
        @objc func handleOneFingerPan(_ recognizer: UIPanGestureRecognizer) {
            guard let view = recognizer.view else { return }
            let translation = recognizer.translation(in: view)

            if parent.scale > 1.05 {
                // Continuous 1-finger panning of magnified image
                parent.offset.width += translation.x
                parent.offset.height += translation.y
                recognizer.setTranslation(.zero, in: view)
            } else if parent.allowHorizontalSwipe && recognizer.state == .ended {
                // 1-finger slide side-to-side to advance or go back to adjacent plate
                let velocity = recognizer.velocity(in: view)
                if abs(translation.x) > 35 && abs(translation.x) > abs(translation.y) * 1.1 {
                    HapticManager.impact(style: .medium)
                    if translation.x < 0 || velocity.x < -300 {
                        parent.onSwipeNext?()
                    } else if translation.x > 0 || velocity.x > 300 {
                        parent.onSwipePrevious?()
                    }
                }
            }
        }

        @objc func handleTwoFingerTap(_ recognizer: UITapGestureRecognizer) {
            if recognizer.state == .ended {
                HapticManager.impact(style: .medium)
                if let onTwoFingerTap = parent.onTwoFingerTap {
                    onTwoFingerTap()
                } else {
                    // Default two-finger tap: smooth recenter or toggle
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        if parent.scale > 1.05 || parent.offset != .zero {
                            parent.offset = .zero
                        } else {
                            parent.scale = 2.5
                            parent.offset = .zero
                        }
                    }
                }
            }
        }

        @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
            if recognizer.state == .ended {
                HapticManager.impact(style: .medium)
                if let onDoubleTap = parent.onDoubleTap {
                    onDoubleTap()
                } else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        if parent.scale > 1.05 || parent.offset != .zero {
                            parent.scale = 1.0
                            parent.offset = .zero
                        } else {
                            parent.scale = 2.5
                            parent.offset = .zero
                        }
                    }
                }
            }
        }
    }
}
