//
//  EdgesScrollTargetBehavior.swift
//  union-scroll
//
//  Created by Ben Sage on 8/24/25.
//

import SwiftUI

/// A scroll target behavior that snaps scrolling to the edges of the content.
///
/// This behavior analyzes the scroll velocity and position to determine whether to snap
/// to the appropriate edges of the scrollable content. It works with both horizontal
/// and vertical scrolling, snapping to top/bottom for vertical scrolling and left/right
/// for horizontal scrolling.
///
/// The snapping logic predicts where the scroll would naturally end based on velocity and deceleration, then snaps to the nearest edge.
///
/// ## Usage
/// ```swift
/// ScrollView {
///     // Your content here
/// }
/// .scrollTargetBehavior(.edges)
/// ```
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EdgesScrollTargetBehavior: ScrollTargetBehavior {
    
    /// Updates the scroll target to snap to the appropriate edges of the content.
    ///
    /// - Parameters:
    ///   - target: The scroll target to modify. The origin will be set to snap to edges.
    ///   - context: Provides information about the scroll context including velocity, content size, and container size.
    ///
    /// - Note: Handles both horizontal and vertical scrolling axes independently.
    public func updateTarget(_ target: inout ScrollTarget, context: ScrollTargetBehaviorContext) {
        if context.axes.contains(.vertical) {
            target.rect.origin.y = snapToEdge(
                predicted: target.rect.origin.y,
                contentSize: context.contentSize.height,
                containerSize: context.containerSize.height
            )
        }
        
        if context.axes.contains(.horizontal) {
            target.rect.origin.x = snapToEdge(
                predicted: target.rect.origin.x,
                contentSize: context.contentSize.width,
                containerSize: context.containerSize.width
            )
        }
    }
    
    private func snapToEdge(predicted: CGFloat, contentSize: CGFloat, containerSize: CGFloat) -> CGFloat {
        guard contentSize > containerSize else { return 0 }
        
        let maxOffset = contentSize - containerSize
        let distanceToStart = predicted
        let distanceToEnd = maxOffset - predicted
        
        return distanceToStart <= distanceToEnd ? 0 : maxOffset
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension ScrollTargetBehavior where Self == EdgesScrollTargetBehavior {
    /// A convenience property for creating an edges scroll target behavior.
    ///
    /// This static property provides a clean API for applying the behavior to scroll views:
    /// ```swift
    /// ScrollView {
    ///     // Content
    /// }
    /// .scrollTargetBehavior(.edges)
    /// ```
    ///
    /// - Returns: A new instance of `EdgesScrollTargetBehavior`.
    public static var edges: EdgesScrollTargetBehavior { .init() }
}
