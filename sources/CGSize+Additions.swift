//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


public import CoreFoundation
public import SwiftUI


extension CGSize: @retroactive ExpressibleByArrayLiteral {

    /// Creates a size from a two-element array literal.
    ///
    /// Uses the first element of the array as the _width_ component, and the second as _height_.
    ///
    /// - Parameter elements: A two-element array literal containing the size components.
    ///
    /// - Note:
    /// The array literal **must** contain two elements; otherwise the call will trigger a
    /// precondition failure.
    public init(arrayLiteral elements: CGFloat...) {
        precondition(
            elements.count == 2,
            "CGSize expressed as an array literal must have exactly 2 elements: \(elements)"
        )
        self.init(width: elements[0], height: elements[1])
    }

}


extension CGSize {

    @inlinable nonisolated
    init(all length: CGFloat) {
        self.init(width: length, height: length)
    }

    
    /// Creates a square size with the given length.
    /// 
    /// - Parameter length: The length for both width and height.
    @inlinable nonisolated
    public init(squareOf length: CGFloat) {
        self.init(all: length)
    }

    
    /// Creates a size with both components set to the given length.
    ///
    /// - Parameter length: The length for both width and height.
    /// - Returns: A size with both components set to the same value.
    @inlinable nonisolated
    public static func all(_ length: CGFloat) -> Self {
        .init(all: length)
    }


    /// Creates a square size with both components set to the given length.
    ///
    /// Equivalent to ``all(_:)``.
    ///
    /// - Parameter length: The length for both width and height.
    /// - Returns: A square size with both components set to the given length.
    @inlinable nonisolated
    public static func square(of length: CGFloat) -> Self {
        .init(all: length)
    }


    // TODO: replace with two separate functions without conditional.

    /// Sets the given components in a copy of `self`.
    ///
    /// Updates in a copy of `self` only the components for the provided parameters. Any parameters
    /// that are omitted, or where `nil` is passed, keep the value of `self`.
    ///
    /// - Parameters:
    ///   - newWidth: The new value for `width`.
    ///   - newHeight: The new value for `height`.
    /// - Returns: A copy of `self` with the given components updated.
    @inlinable nonisolated
    public func setting(
        width newWidth: CGFloat? = nil,
        height newHeight: CGFloat? = nil
    ) -> Self {
        var mutableSize = self
        if let newWidth {  mutableSize.width  = newWidth }
        if let newHeight { mutableSize.height = newHeight }
        return mutableSize
    }


    /// Sets the component along an axis to the given length.
    ///
    /// Updates `width` when the `horizontal` axis is provided, and `height` for the `vertical` axis.
    ///
    /// - Parameters:
    ///   - length: The length for the component along the given axis.
    ///   - axis: The axis of the component to update.
    /// - Returns: `self` with the component along `axis` updated to the given length.
    @inlinable nonisolated
    public func setting(
        length: CGFloat,
        along axis: Axis
    ) -> Self {
        var mutableSize = self
        switch axis {
        case .horizontal: mutableSize.width  = length
        case .vertical:   mutableSize.height = length
        }
        return mutableSize
    }

    
    /// Adds the given components.
    ///
    /// - Parameters:
    ///   - width: The value to add to width; defaults to zero.
    ///   - height: The value to add to height; defaults to zero.
    /// - Returns: `self` with the given components added.
    @inlinable nonisolated
    public func adding(width: CGFloat = .zero, height: CGFloat = .zero) -> Self {
        .init(width: self.width + width, height: self.height + height)
    }


    /// Adds the given size.
    ///
    /// Adds to each component the corresponding component of `other`.
    ///
    /// - Parameter other: The size to add.
    /// - Returns: `self` with the given size added.
    @inlinable nonisolated
    public func adding(size other: CGSize) -> Self {
        .init(width: width + other.width, height: height + other.height)
    }


    /// Subtracts the given components.
    ///
    /// - Parameters:
    ///   - width: The value to subtract from width; defaults to zero.
    ///   - height: The value to subtract from height; defaults to zero.
    /// - Returns: `self` with the given components subtracted.
    @inlinable nonisolated
    public func subtracting(width: CGFloat = .zero, height: CGFloat = .zero) -> Self {
        .init(width: self.width - width, height: self.height - height)
    }


    /// Subtracts the given size.
    ///
    /// Subtracts to each component the corresponding component of `other`.
    ///
    /// - Parameter other: The size to subtract.
    /// - Returns: `self` with the given size subtracted.
    @inlinable nonisolated
    public func subtracting(size other: CGSize) -> Self {
        .init(width: width - other.width, height: height - other.height)
    }


    /// Size that can contain both `self` and the given size.
    ///
    /// The returned size uses the largest of each component from both sizes.
    ///
    /// - Parameter other: The size to envelop.
    /// - Returns: A size that can contain both `self` and the given size.
    @inlinable nonisolated
    public func enveloping(_ other: CGSize) -> Self {
        .init(
            width: Swift.max(width, other.width),
            height: Swift.max(height, other.height)
        )
    }


    /// Updates to a size that can contain both `self` and the given size.
    ///
    /// The updated size uses the largest of each component from both sizes.
    ///
    /// - Parameter other: The size to envelop.
    @inlinable nonisolated
    public mutating func envelop(_ other: CGSize) {
        width = Swift.max(width, other.width)
        height = Swift.max(height, other.height)
    }

    
    /// Transposes the size components.
    ///
    /// Exchanges `width` and `height` for each other.
    @inlinable nonisolated
    public var transposed: Self {
        .init(width: height, height: width)
    }


    /// Rounds both components to an integer using the given rule.
    ///
    /// - Parameter rule: The rounding rule to apply to both components.
    /// - Returns: `self` with both components rounded to an integer value by the given rule.
    @inlinable nonisolated
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        .init(
            width:  width .rounded(rule),
            height: height.rounded(rule)
        )
    }


    /// Multiplies both components by a given multiplier.
    ///
    /// - Parameter multiplier: The value to multiply both components by.
    /// - Returns: `self` with both components multiplied by `multiplier`.
    @inlinable nonisolated
    public func multiplying(by multiplier: CGFloat) -> Self {
        .init(
            width:  width  * multiplier,
            height: height * multiplier
        )
    }


    /// Multiplies the component along an axis by the given multiplier.
    ///
    /// Updates `width` when the `horizontal` axis is provided, and `height` for the `vertical` axis.
    ///
    /// - Parameters:
    ///   - multiplier: The value to multiply a component by.
    ///   - axis: The axis of the component to update.
    /// - Returns: `self` with the component along `axis` multiplied by the `multiplier`.
    @inlinable nonisolated
    public func multiplying(
        by multiplier: CGFloat,
        along axis: Axis
    ) -> Self {
        var mutableSize = self
        switch axis {
        case .horizontal: mutableSize.width  *= multiplier
        case .vertical:   mutableSize.height *= multiplier
        }
        return mutableSize
    }


    /// Produces the Hadamard product with the given size.
    ///
    /// The Hadamard product (or element-wise product) produces a size where each component is
    /// the result of the operands' corresponding components, multiplied together.
    ///
    /// That is, the returned _width_ component will have the value `self.width * multiplier.width`;
    /// and its corresponding for _height_.
    ///
    /// https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
    ///
    /// - Parameter multiplier: The size by which to produce the Hadamard product with `self`.
    /// - Returns: The Hadamard product of `self` and `multiplier`.
    @inlinable nonisolated
    func hadamard(bySize multiplier: CGSize) -> Self {
        .init(
            width:  width  * multiplier.width,
            height: height * multiplier.height
        )
    }


    // TODO: Add tests, include scaling to fill zero sizes.

    /// Scales to fill the given size, while keeping the original aspect ratio.
    ///
    /// The resulting size will have at least one component match with the given size, while the
    /// other will be larger.
    ///
    /// - Parameter size: The size to fill.
    /// - Returns: `self` scaled to fill the given size, while keeping its aspect ratio.
    @inlinable nonisolated
    public func scaled(toFill size: CGSize) -> Self {
        let fillScale: CGFloat

        if width == .zero {
            if height == .zero { return .zero }
            fillScale = size.height / height
        } else if height == .zero {
            fillScale = size.width / width
        } else {
            fillScale = Swift.max(size.width / width, size.height / height)
        }

        return multiplying(by: fillScale)
    }


    /// The lesser of the size components.
    @inlinable nonisolated
    public var min: CGFloat {
        Swift.min(width, height)
    }


    /// The greater of the size components.
    @inlinable nonisolated
    public var max: CGFloat {
        Swift.max(width, height)
    }


    /// A point with matching component values.
    ///
    /// The resulting point uses `width` as its _x_ component, and `height` as _y_.
    @inlinable nonisolated
    public var toPoint: CGPoint {
        .init(x: width, y: height)
    }


    /// Rectangle with `self` as size and the given origin point.
    ///
    /// - Parameter origin: The origin point for the resulting rectangle; defaults to a zero value point.
    /// - Returns: A rectangle with `self` as size and the given origin point.
    @inlinable nonisolated
    public func rect(origin: CGPoint = .zero) -> CGRect {
        .init(origin: origin, size: self)
    }


    /// Centers a rectangle in the given size.
    ///
    /// Produces a rectangle the size of `self` centered in a rectangle of size `other` with origin
    /// at the zero value point.
    ///
    /// - Parameter other: The size to center `self` in.
    /// - Returns: A rectangle of size `self` centered in the given size.
    @inlinable nonisolated
    public func centered(in other: CGSize) -> CGRect {
        let rect = CGRect(origin: .zero, size: other)
        return rect.center(size: self)
    }


    /// Centers a rectangle in the given rectangle.
    ///
    /// Produces a rectangle of size of `self` centered in the given rectangle.
    ///
    /// - Parameter rect: The rectangle to center `self` in.
    /// - Returns: A rectangle of size `self` centered in the given rectangle.
    @inlinable nonisolated
    public func centered(in rect: CGRect) -> CGRect {
        rect.center(size: self)
    }

}
