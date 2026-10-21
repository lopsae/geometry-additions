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

    @Test func addingComponents() {
        let point: CGPoint = [5, 7]

        #expect(point.adding()             == [5, 7])
        #expect(point.adding(x: 3)         == [8, 7])
        #expect(point.adding(y: 4)         == [5, 11])
        #expect(point.adding(x: 3, y: 4)   == [8, 11])
        #expect(point.adding(x: -8, y: -9) == [-3, -2])
    }

    @Test func addingPoint() {
        var point: CGPoint = [5, 7]

        #expect(point.adding(point: .zero)    == [5, 7])
        #expect(point.adding(point: [3, 4])   == [8, 11])
        #expect(point.adding(point: [-8, -9]) == [-3, -2])

        point.add(point: [3, 4])
        #expect(point == [8, 11])
    }

    @Test func addingSize() {
        let point: CGPoint = [5, 7]

        #expect(point.adding(size: .zero) == [5, 7])
        #expect(point.adding(size: [6, 8]) == [11, 15])
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
