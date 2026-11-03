//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


public import CoreFoundation

// TODO: Could some of these extensions be optional if `canImport(SwiftUI)`?
public import SwiftUI


// MARK: - ArrayLiteral


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


// MARK: - Initializers


extension CGPoint {

    /// Creates a point with components along and across a given axis.
    ///
    /// - Parameters:
    ///   - axis: The axis along which the components are interpreted.
    ///   - along: The component along `axis`.
    ///   - across: The component across `axis`.
    @inlinable nonisolated
    public init(on axis: Axis, along: CGFloat, across: CGFloat) {
        switch axis {
        case .horizontal: self.init(x: along,  y: across)
        case .vertical:   self.init(x: across, y: along)
        }
    }

}


// MARK: - Operations


extension CGPoint {

    /// Sets the given components.
    ///
    /// Updates only the components for the provided parameters. Any parameters that are omitted,
    /// or where `nil` is passed, keep the value of `self`.
    ///
    /// - Parameters:
    ///   - newX: The new value for _x_.
    ///   - newY: The new value for _y_.
    /// - Returns: `self` with the given components updated.
    @inlinable nonisolated
    public func setting(
        x newX: CGFloat? = nil,
        y newY: CGFloat? = nil,
    ) -> Self {
        var mutablePoint = self
        if let newX { mutablePoint.x = newX }
        if let newY { mutablePoint.y = newY }
        return mutablePoint
    }


    /// Adds the given components.
    ///
    /// - Parameters:
    ///   - x: The value to add to the _x_ component; defaults to zero.
    ///   - y: The value to add to the _y_ component; defaults to zero.
    /// - Returns: `self` offset by the given components.
    @inlinable nonisolated
    public func adding(x: CGFloat = .zero, y: CGFloat = .zero) -> Self {
        .init(
            x: self.x + x,
            y: self.y + y
        )
    }


    /// Adds the components of the given `CGPoint`.
    ///
    /// - Parameter other: A point which components are added to `self`.
    /// - Returns: `self` offset by the given point.
    @inlinable nonisolated
    public func adding(point other: Self) -> Self {
        .init(
            x: self.x + other.x,
            y: self.y + other.y
        )
    }


    /// Adds the components of the given `CGSize`.
    ///
    /// Adds the corresponding axial components: the size's width is added to _x_, and its height
    /// to _y_.
    ///
    /// - Parameter size: The size which components are added to `self`.
    /// - Returns: `self` offset by the given size.
    @inlinable nonisolated
    public func adding(size: CGSize) -> Self {
        .init(
            x: self.x + size.width,
            y: self.y + size.height
        )
    }


    /// Adds to the components along and orthogonal a given axis.
    ///
    /// - Parameters:
    ///   - value: The value to add to the component along `axis`.
    ///   - orthogonal: The value to add the component orthogonal to `axis`.
    ///   - axis: The axis along which the components are interpreted.
    /// - Returns: `self` offset along the given axis.
    @inlinable nonisolated
    public func adding(
        _ value: CGFloat,
        orthogonal: CGFloat = .zero,
        along axis: Axis
    ) -> Self {
        switch axis {
        case .horizontal: self.adding(x: value,      y: orthogonal)
        case .vertical:   self.adding(x: orthogonal, y: value)
        }
    }

    /// Updates `self` by adding the components of the given `CGPoint`.
    ///
    /// - Parameter other: A point which components are added to `self`.
    @inlinable nonisolated
    public mutating func add(point other: CGPoint) {
        self = self.adding(point: other)
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
    /// That is, the returned _x_ component will have the value `self.x * multiplier.x`; and for
    /// _y_ the value `self.y * multiplier.y`.
    ///
    /// See [Hadamard product](https://en.wikipedia.org/wiki/Hadamard_product_(matrices)) in
    /// Wikipedia.
    ///
    /// - Parameter multiplier: The point by which to produce the Hadamard product with `self`.
    /// - Returns: The Hadamard product of `self` and `multiplier`.
    @inlinable nonisolated
    public func hadamard(by multiplier: Self) -> Self {
        .init(
            x: self.x * multiplier.x,
            y: self.y * multiplier.y
        )
    }


    /// Produces the Hadamard product with the given size.
    ///
    /// The Hadamard product (or element-wise product) produces a point where each component is
    /// the result of the operands' corresponding axial components, multiplied together.
    ///
    /// That is, the returned _x_ component will have the value `self.x * multiplier.width`; and for
    /// _y_ the value `self.y * multiplier.height`.
    ///
    /// See [Hadamard product](https://en.wikipedia.org/wiki/Hadamard_product_(matrices)) in
    /// Wikipedia.
    ///
    /// - Parameter multiplier: The size by which to produce the Hadamard product with `self`.
    /// - Returns: The Hadamard product of `self` and `multiplier`.
    @inlinable nonisolated
    public func hadamard(bySize multiplier: CGSize) -> Self {
        .init(
            x: self.x * multiplier.width,
            y: self.y * multiplier.height
        )
    }

}
