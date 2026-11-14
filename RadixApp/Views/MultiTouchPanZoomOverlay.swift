import SwiftUI
import UIKit

// MARK: - Multi-Touch Hardware Pan & Pinch-Zoom Overlay
// Provides true dual-touch (2-finger) and single-touch (1-finger) hardware gesture tracking on iOS:
// 1. Simultaneous 2-finger pinch magnification (1.0x to 5.0x).
// 2. Continuous 2-finger or 1-finger panning/movement of the magnified image in all directions.
// 3. Two-finger tap detection (recenter, toggle zoom, or pan toward tap).
// 4. Double-tap quick-zoom toggle (2.5x <-> 1.0x).
// 5. Horizontal swipe navigation when unzoomed (1.0x).

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

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isMultipleTouchEnabled = true

        // 1. Pinch Gesture (1.0x to maxScale)
        let pinch = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch(_:)))
        pinch.delegate = context.coordinator
        view.addGestureRecognizer(pinch)

        // 2. Pan Gesture: Accepts 1 or 2 fingers!
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 2
        pan.delegate = context.coordinator
        view.addGestureRecognizer(pan)

        // 3. Two-Finger Tap Gesture
        let twoFingerTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTwoFingerTap(_:)))
        twoFingerTap.numberOfTouchesRequired = 2
        twoFingerTap.numberOfTapsRequired = 1
        twoFingerTap.delegate = context.coordinator
        view.addGestureRecognizer(twoFingerTap)

        // 4. Double Tap (1-Finger) Quick-Zoom
        let doubleTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = context.coordinator
        view.addGestureRecognizer(doubleTap)

        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.parent = self
    }

    public class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var parent: MultiTouchPanZoomOverlay
        var initialScale: CGFloat = 1.0

        init(_ parent: MultiTouchPanZoomOverlay) {
            self.parent = parent
        }

        // Allow simultaneous pinch and pan!
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
                        parent.offset = .zero
                    }
                }
            default:
                break
            }
        }

        @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
            guard let view = recognizer.view else { return }
            let translation = recognizer.translation(in: view)

            if parent.scale > 1.05 {
                // Continuous 2-finger or 1-finger movement of magnified image
                parent.offset.width += translation.x
                parent.offset.height += translation.y
                recognizer.setTranslation(.zero, in: view)
            } else if parent.allowHorizontalSwipe && recognizer.state == .ended {
                // Horizontal navigation when unzoomed
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
                        if parent.scale > 1.05 {
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
                        if parent.scale > 1.05 {
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
