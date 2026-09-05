//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


@testable import GeometryAdditions

import CoreGraphics
import Testing


struct CGRectAdditionsTests {

    @Test func centerSize() async throws {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])
        let centered = rect.center(size: [60, 40])
        #expect(centered == .init(origin: [75, 37], size: [60, 40]))
    }


    @Test func centerPoint() async throws {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])
        #expect(rect.centerPoint == [105, 57])
    }


    @Test func cornerPoints() async throws {
        let rect: CGRect = .init(origin: [5, 7], size: [200, 100])

        #expect(rect.minPoint == [5, 7])
        #expect(rect.maxPoint == [205, 107])

        #expect(rect.topLeadingPoint     == [5,   7])
        #expect(rect.topTrailingPoint    == [205, 7])
        #expect(rect.bottomTrailingPoint == [205, 107])
        #expect(rect.bottomLeadingPoint  == [5,   107])
    }


    @Test func align() async throws {
        let rect: CGRect = .init(origin: [5, 7], size: [90, 80])
        let toAlign: CGRect = .init(origin: [30, 20], size: [60, 40])

        #expect(rect.align(rect: toAlign, to: .top)      == .init(origin: [30,  7], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .leading)  == .init(origin: [5,  20], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .bottom)   == .init(origin: [30, 47], size: [60, 40]))
        #expect(rect.align(rect: toAlign, to: .trailing) == .init(origin: [35, 20], size: [60, 40]))

        #expect(toAlign.aligned(to: .top,      of: rect) == .init(origin: [30,  7], size: [60, 40]))
        #expect(toAlign.aligned(to: .leading,  of: rect) == .init(origin: [5,  20], size: [60, 40]))
        #expect(toAlign.aligned(to: .bottom,   of: rect) == .init(origin: [30, 47], size: [60, 40]))
        #expect(toAlign.aligned(to: .trailing, of: rect) == .init(origin: [35, 20], size: [60, 40]))
    }

}
