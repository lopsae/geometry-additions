//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


public import CoreFoundation
public import SwiftUI


extension CGRect {

    /// Sets the given properties in a copy of `self`.
    ///
    /// Updates in a copy of `self` only the properties for the provided parameters. Any parameters
    /// that are omitted, or where `nil` is passed, keep the value of `self`.
    ///
    /// - Parameters:
    ///   - newX: The new value for `origin.x`.
    ///   - newY: The new value for `origin.y`.
    ///   - newWidth: The new value for `size.width`.
    ///   - newHeight: The new value for `size.height`.
    /// - Returns: A copy of `self` with the given properties updated.
    @inlinable nonisolated
    public func setting(
        x newX: CGFloat? = nil,
        y newY: CGFloat? = nil,
        width newWidth: CGFloat? = nil,
        height newHeight: CGFloat? = nil
    ) -> Self {
        var mutableRect = self
        if let newX { mutableRect.origin.x = newX }
        if let newY { mutableRect.origin.y = newY }
        if let newWidth  { mutableRect.size.width  = newWidth }
        if let newHeight { mutableRect.size.height = newHeight }
        return mutableRect
    }


    /// The point at the center of `self`.
    @inlinable nonisolated
    public var center: CGPoint {
        size.toPoint
            .multiplying(by: 0.5)
            .offset(by: origin)
    }


    /// Centers a rectangle of the given size.
    ///
    /// - Parameter size: The size of the rectangle to center.
    /// - Returns: A rectangle with the given size, centered in `self`.
    @inlinable nonisolated
    public func center(size: CGSize) -> Self {
        let centeredRect = CGRect(
            x: (width - size.width) / 2 + origin.x,
            y: (height - size.height) / 2 + origin.y,
            width: size.width,
            height: size.height
        )
        return centeredRect
    }


    /// Aligns the given rectangle to an edge of `self`.
    ///
    /// Returns a copy of `other` with either `origin.x` or `origin.y` updated to align with the
    /// specified edge of `self`.
    ///
    /// - Parameters:
    ///   - other: The rectangle to align to `self`.
    ///   - edge: The edge to align to.
    /// - Returns: `other` aligned to the given edge of `self`.
    @inlinable nonisolated
    public func align(rect other: CGRect, to edge: Edge) -> Self {
        var alignedRect = other
        switch edge {
        case .top:
            alignedRect.origin.y = origin.y
        case .leading:
            alignedRect.origin.x = origin.x
        case .bottom:
            alignedRect.origin.y = origin.y + height - other.height
        case .trailing:
            alignedRect.origin.x = origin.x + width - other.width
        }
        return alignedRect
    }


    /// Aligns `self` to an edge of the given rectangle.
    ///
    /// Returns a copy of `self` with either `origin.x` or `origin.y` updated to align with the
    /// specified edge of `other`.
    ///
    /// - Parameters:
    ///   - edge: The edge to align to.
    ///   - other: The rectangle to align `self` to.
    /// - Returns: `self` aligned to the given edge of `other`.
    @inlinable nonisolated
    public func aligned(to edge: Edge, of other: CGRect) -> Self {
        other.align(rect: self, to: edge)
    }


    /// Offsets by the given coordinate components.
    ///
    /// Equivalent to adding the given coordinate components to `origin`.
    ///
    /// - Parameters:
    ///   - x: The value to offset `origin.x`; defaults to zero.
    ///   - y: The value to offset `origin.y`; defaults to zero.
    /// - Returns: `self` offset by the given coordinate components.
    @inlinable nonisolated
    public func offset(x: CGFloat = .zero, y: CGFloat = .zero) -> Self {
        self.offsetBy(dx: x, dy: y)
    }


    /// String description using the given `FormatStyle` to format all rectangle's properties.
    ///
    /// - Parameter format: The format style for all the rectangle's properties.
    /// - Returns: The formatted string description of `self`.
    nonisolated
    public func debugDescription<Style>(format: Style) -> String
    where Style: FormatStyle, Style.FormatInput == Double, Style.FormatOutput == String {
        let xString = origin.x.formatted(format)
        let yString = origin.y.formatted(format)
        let widthString  = size.width.formatted(format)
        let heightString = size.height.formatted(format)
        return "(\(xString), \(yString), \(widthString), \(heightString))"
    }

}


#if canImport(UIKit)

import UIKit

extension CGRect {

    /// Insets in both axis by the same given value.
    ///
    /// - Parameter value: The value to inset in both axis.
    /// - Returns: `self` inset by the given value in both axis.
    @inlinable nonisolated
    public func inset(by value: CGFloat) -> Self {
        inset(by: UIEdgeInsets.all(value))
    }


    /// Outsets in both axis by the same given value.
    ///
    /// - Parameter value: The value to outset in both axis.
    /// - Returns: `self` outset by the given value in both axis.
    @inlinable nonisolated
    public func outset(by value: CGFloat) -> Self {
        inset(by: UIEdgeInsets.all(-value))
    }

}

#endif


#if os(macOS)

extension CGRect {
    
    /// Insets in both axis by the same given value.
    /// - Parameter value: The value to inset in both axis.
    /// - Returns: `self` inset by the given value in both axis.
    @inlinable nonisolated
    func inset(by value: CGFloat) -> Self {
        self.insetBy(dx: value, dy: value)
    }

}

#endif


// MARK: - Path Interactions

extension CGRect {
    
    /// Adds `self` to the given path.
    ///
    /// - Parameter path: The path to add `self` into.
    /// - Returns: The given path after the addition.
    @discardableResult
    @inlinable nonisolated
    public func addToPath(_ path: inout Path) -> Self {
        path.addRect(self)
        return self
    }

}
