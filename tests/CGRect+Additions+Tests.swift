//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


import GeometryAdditions

import CoreGraphics
import Foundation
import SwiftUI
import Testing


struct CGRectAdditionsTests {

    @Test func centerPoint() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])
        #expect(rect.centerPoint == [105, 57])
    }


    @Test func cornerPoints() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        #expect(rect.minPoint == [5, 7])
        #expect(rect.maxPoint == [205, 107])

        #expect(rect.topLeadingPoint     == [5,   7])
        #expect(rect.topTrailingPoint    == [205, 7])
        #expect(rect.bottomTrailingPoint == [205, 107])
        #expect(rect.bottomLeadingPoint  == [5,   107])
    }


    @Test func setting() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        #expect(rect.setting() == rect)

        #expect(rect.setting(x: 1)       == .init(origin: [1, 7], size: [200, 100]))
        #expect(rect.setting(y: 2)       == .init(origin: [5, 2], size: [200, 100]))
        #expect(rect.setting(width: 60)  == .init(origin: [5, 7], size: [60, 100]))
        #expect(rect.setting(height: 40) == .init(origin: [5, 7], size: [200, 40]))

        #expect(
            rect.setting(x: 1, y: 2, width: 60, height: 40)
                == .init(origin: [1, 2], size: [60, 40])
        )
    }


    @Test func centerSize() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])
        let centered = rect.center(size: [60, 40])
        #expect(centered == .init(origin: [75, 37], size: [60, 40]))
    }


    @Test func align() {
        let rect: CGRect = .init(origin: [5, 7], size: [90, 80])
        let toAlign: CGRect = .init(origin: [30, 20], size: [60, 40])

        #expect(rect.align(rect: toAlign, to: .top)      == .init(origin: [30,  7], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .leading)  == .init(origin: [5,  20], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .bottom)   == .init(origin: [30, 47], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .trailing) == .init(origin: [35, 20], size: [60, 40]))
    }

    @Test func aligned() {
        let rect: CGRect = .init(origin: [5, 7], size: [90, 80])
        let toAlign: CGRect = .init(origin: [30, 20], size: [60, 40])

        #expect(toAlign.aligned(to: .top,      of: rect) == .init(origin: [30,  7], size: [60, 40]))
        #expect(toAlign.aligned(to: .leading,  of: rect) == .init(origin: [5,  20], size: [60, 40]))
        #expect(toAlign.aligned(to: .bottom,   of: rect) == .init(origin: [30, 47], size: [60, 40]))
        #expect(toAlign.aligned(to: .trailing, of: rect) == .init(origin: [35, 20], size: [60, 40]))
    }

    @Test func offset() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        #expect(rect.offset()             == rect)
        #expect(rect.offset(x: 3)         == .init(origin: [8, 7],   size: [200, 100]))
        #expect(rect.offset(y: 4)         == .init(origin: [5, 11],  size: [200, 100]))
        #expect(rect.offset(x: 3, y: 4)   == .init(origin: [8, 11],  size: [200, 100]))
        #expect(rect.offset(x: -8, y: -9) == .init(origin: [-3, -2], size: [200, 100]))
    }


    @Test func insetOutset() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        #expect(rect.inset(by: 10)  == .init(origin: [15, 17], size: [180, 80]))
        #expect(rect.outset(by: 10) == .init(origin: [-5, -3], size: [220, 120]))

        #expect(rect.inset(by: 0)  == rect)
        #expect(rect.outset(by: 0) == rect)

        // Insetting and outsetting by the same value are inverses of each other.
        #expect(rect.inset(by: 10).outset(by: 10) == rect)
        #expect(rect.outset(by: 10).inset(by: 10) == rect)
    }


    @Test func debugDescriptionFormat() {
        // Locale fixes the decimal separator independent of the test environment.
        let locale = Locale(identifier: "en_US_POSIX")

        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])
        let oneFraction = FloatingPointFormatStyle<Double>(locale: locale)
            .precision(.fractionLength(1))

        #expect(rect.debugDescription(format: oneFraction) == "(5.0, 7.0, 200.0, 100.0)")

        let fractional: CGRect = .init(origin: [-1.25, 2.5], size: [3.75, 4.5])
        let twoFractions = FloatingPointFormatStyle<Double>(locale: locale)
            .precision(.fractionLength(2))

        #expect(fractional.debugDescription(format: twoFractions) == "(-1.25, 2.50, 3.75, 4.50)")
    }


    @Test func addToPath() {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        var path = Path()
        #expect(path.isEmpty)

        let returned = rect.addToPath(&path)

        #expect(returned == rect)
        #expect(path.isEmpty == false)
        #expect(path.boundingRect == rect)
    }

}
