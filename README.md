# UnionScroll

A SwiftUI package that provides custom scroll target behaviors for enhanced scrolling experiences.

## Features

- **Smart Scroll Behaviors**: Collection of scroll target behaviors for different use cases
- **Velocity-Aware Logic**: Intelligent snapping decisions based on scroll velocity and position
- **iOS 17+ Compatible**: Built using the latest ScrollTargetBehavior APIs
- **Easy Integration**: Simple one-line modifiers to enhance any ScrollView

## Installation

### Swift Package Manager

Add this package to your project using Xcode:

1. File → Add Package Dependencies
2. Enter the repository URL
3. Select the version range or branch
4. Add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-scroll.git", from: "1.0.0")
]
```

## Available Behaviors

### Edge Snapping

The `.edges` behavior snaps scrolling to the edges of content based on scroll velocity and position. Works with both horizontal and vertical scrolling.

```swift
import SwiftUI
import UnionScroll

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50, id: \.self) { index in
                    Text("Item \(index)")
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .scrollTargetBehavior(.edges)
    }
}
```

#### How It Works

The behavior analyzes scroll interactions and determines snapping based on:

- **Predicted End Location**: Calculates where the scroll would naturally end based on current velocity and deceleration
- **Nearest Edge Snapping**: Snaps to whichever edge (top/bottom or left/right) is closest to the predicted end location
- **Dual Axis Support**: Handles vertical scrolling (top/bottom edges) and horizontal scrolling (left/right edges) independently

This creates an intuitive user experience that feels natural and responsive to user gestures, similar to native iOS scroll behaviors.

## Requirements

- iOS 17.0+, macOS 14.0+, tvOS 17.0+, watchOS 10.0+
- Swift 6.1+
- Xcode 16.0+

**Note**: The package deployment target supports iOS 13.0+ for flexibility, but the `ScrollTargetBehavior` API requires iOS 17.0+ at runtime.

## License

This project is available under the MIT license.