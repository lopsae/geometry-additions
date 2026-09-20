//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


import GeometryAdditions

import CoreGraphics
import Testing


struct CGPointAdditionsTests {

    @Test func arrayLiteral() {
        let point: CGPoint = [5, 7]

        #expect(point.x == 5)
        #expect(point.y == 7)
    }

    @Test func offsetComponents() {
        let point: CGPoint = [5, 7]

        #expect(point.offset()             == [5, 7])
        #expect(point.offset(x: 3)         == [8, 7])
        #expect(point.offset(y: 4)         == [5, 11])
        #expect(point.offset(x: 3, y: 4)   == [8, 11])
        #expect(point.offset(x: -8, y: -9) == [-3, -2])
    }

    @Test func offsetByPoint() {
        let point: CGPoint = [5, 7]

        #expect(point.offset(by: .zero)    == [5, 7])
        #expect(point.offset(by: [3, 4])   == [8, 11])
        #expect(point.offset(by: [-8, -9]) == [-3, -2])
    }

    @Test func offsetBySize() {
        let point: CGPoint = [5, 7]

        #expect(point.offset(bySize: .zero) == [5, 7])
        #expect(point.offset(bySize: [6, 8]) == [11, 15])
    }


    @Test func multiplying() {
        let point: CGPoint = [5, 7]

        #expect(point.multiplying(by: 1)     == [5, 7])
        #expect(point.multiplying(by: 2)     == [10, 14])
        #expect(point.multiplying(by: 0.5)   == [2.5, 3.5])
        #expect(point.multiplying(by: -1)    == [-5, -7])
        #expect(point.multiplying(by: .zero) == .zero)
    }

    @Test func hadamardByPoint() {
        let point: CGPoint = [5, 7]

        #expect(point.hadamard(by: .zero)  == .zero)
        #expect(point.hadamard(by: [0, 1]) == [0, 7])
        #expect(point.hadamard(by: [1, 0]) == [5, 0])

        #expect(point.hadamard(by: [1, 1])   == [5, 7])
        #expect(point.hadamard(by: [2, 3])   == [10, 21])
        #expect(point.hadamard(by: [0.5, 2]) == [2.5, 14])
        #expect(point.hadamard(by: [-1, -2]) == [-5, -14])
    }

    @Test func hadamardBySize() {
        let point: CGPoint = [5, 7]

        #expect(point.hadamard(bySize: .zero)    == .zero)
        #expect(point.hadamard(bySize: [0, 1]) == [0, 7])
        #expect(point.hadamard(bySize: [1, 0]) == [5, 0])

        #expect(point.hadamard(bySize: [1, 1])   == [5, 7])
        #expect(point.hadamard(bySize: [2, 3])   == [10, 21])
        #expect(point.hadamard(bySize: [0.5, 2]) == [2.5, 14])
        #expect(point.hadamard(bySize: [-1, -2]) == [-5, -14])
    }

}
