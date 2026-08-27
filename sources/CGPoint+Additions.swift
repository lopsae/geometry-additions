//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


public import CoreFoundation


extension CGPoint {

    @inlinable nonisolated
    func adding(size: CGSize) -> Self {
        .init(
            x: self.x + size.width,
            y: self.y + size.height
        )
    }

    /// Multiplies both components by a given multiplier.
    ///
    /// - Parameter multiplier: The value to multiply both components by.
    /// - Returns: `self` with both components multiplied by `multiplier`.
    @inlinable nonisolated
    public func multiplying(by multiplier: CGFloat) -> Self {
        .init(
            x: self.x * multiplier,
            y: self.y * multiplier
        )
    }


    /// Produces the Hadamard product with the given point.
    ///
    /// The Hadamard product (or element-wise product) produces a point where each component is
    /// the result of the operands' corresponding components, multiplied together.
    ///
    /// That is, the returned _x_ component will have the value `self.x * multiplier.x`; and its
    /// corresponding for _y_.
    ///
    /// https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
    ///
    /// - Parameter multiplier: The point by which to produce the Hadamard product with `self`.
    /// - Returns: The Hadamard product of `self` and `multiplier`.
    @inlinable nonisolated
    func hadamart(by multiplier: Self) -> Self {
        .init(
            x: self.x * multiplier.x,
            y: self.y * multiplier.y
        )
    }


    /// Returns the Hadamard product of `self` and `multiplier`, where `x` is multiplied by
    /// `width`, and `y` by `height`.
    ///
    /// https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
    @inlinable nonisolated
    func hadamart(bySize multiplier: CGSize) -> Self {
        .init(
            x: self.x * multiplier.width,
            y: self.y * multiplier.height
        )
    }


    // TODO: Add adding.


    /// Offsets by the given components.
    ///
    /// Equivalent to adding the given components to `self`.
    ///
    /// - Parameters:
    ///   - x: The value to offset the _x_ component; defaults to zero.
    ///   - y: The value to offset the _y_ component; defaults to zero.
    /// - Returns: `self` offset by the given components.
    @inlinable nonisolated
    public func offset(x: CGFloat = .zero, y: CGFloat = .zero) -> Self {
        .init(
            x: self.x + x,
            y: self.y + y
        )
    }


    /// Offsets by the given `CGPoint`.
    ///
    /// Equivalent to adding the corresponding components of `other`.
    ///
    /// - Parameter other: A point to offset `self` by.
    /// - Returns: `self` offset by the given point.
    @inlinable nonisolated
    public func offset(by other: Self) -> Self {
        .init(
            x: self.x + other.x,
            y: self.y + other.y
        )
    }

}


extension CGPoint: @retroactive ExpressibleByArrayLiteral {

    
    /// Creates a point from a two-element array literal.
    ///
    /// Uses the first element of the array as the _x_ component, and the second as _y_.
    ///
    /// - Parameter elements: A two-element array literal containing the point components.
    ///
    /// - Note:
    /// The array literal **must** contain two elements; otherwise the call will trigger a
    /// precondition failure.
    public init(arrayLiteral elements: CGFloat...) {
        precondition(
            elements.count == 2,
            "CGPoint expressed as an array literal must have exactly 2 elements: \(elements)"
        )
        self.init(x: elements[0], y: elements[1])
    }

}
