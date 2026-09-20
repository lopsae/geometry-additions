//
//  GeometryAdditions
//  Created by Maic Lopez Saenz.
//


import GeometryAdditions

import CoreGraphics
import Testing


struct CGSizeAdditionsTests {

    @Test func arrayLiteral() {
        let size: CGSize = [5, 7]

        #expect(size.width  == 5)
        #expect(size.height == 7)
    }

    @Test func squareInitializers() {
        #expect(CGSize(squareOf: .zero) == .zero)

        #expect(CGSize(squareOf: 5)  == [5, 5])
        #expect(CGSize.square(of: 5) == [5, 5])
    }

    @Test func setting() {
        let size: CGSize = [5, 7]

        #expect(size.setting()          == [5, 7])
        #expect(size.setting(width: 6)  == [6, 7])
        #expect(size.setting(height: 8) == [5, 8])

        #expect(size.setting(width: 6, height: 8) == [6, 8])
    }

    @Test func settingAlong() {
        let size: CGSize = [5, 7]

        #expect(size.setting(length: 6, along: .horizontal) == [6, 7])
        #expect(size.setting(length: 8, along: .vertical)   == [5, 8])
    }

    @Test func addingComponents() {
        let size: CGSize = [5, 7]

        #expect(size.adding()          == [5, 7])
        #expect(size.adding(width:  3) == [8, 7])
        #expect(size.adding(height: 4) == [5, 11])

        #expect(size.adding(width: 3,  height: 4)  == [8, 11])
        #expect(size.adding(width: -8, height: -9) == [-3, -2])
    }

    @Test func addingSize() {
        let size: CGSize = [5, 7]

        #expect(size.adding(size: .zero)    == [5, 7])
        #expect(size.adding(size: [3, 4])   == [8, 11])
        #expect(size.adding(size: [-3, -6]) == [2, 1])
    }

    @Test func subtractingComponents() {
        let size: CGSize = [5, 7]

        #expect(size.subtracting()          == [5, 7])
        #expect(size.subtracting(width:  3) == [2, 7])
        #expect(size.subtracting(height: 4) == [5, 3])

        #expect(size.subtracting(width: 3, height: 6) == [2, 1])
        #expect(size.subtracting(width: 8, height: 9) == [-3, -2])
    }

    @Test func subtractingSize() {
        let size: CGSize = [5, 7]

        #expect(size.subtracting(size: .zero)  == [5, 7])
        #expect(size.subtracting(size: [3, 6]) == [2, 1])
        #expect(size.subtracting(size: [8, 9]) == [-3, -2])
        #expect(size.subtracting(size: [5, 7]) == .zero)
    }

    @Test func enveloping() {
        let size: CGSize = [5, 7]

        #expect(size.enveloping(.zero)  == [5, 7])
        #expect(size.enveloping([5, 7]) == [5, 7])
        #expect(size.enveloping([3, 9]) == [5, 9])
        #expect(size.enveloping([8, 2]) == [8, 7])
        #expect(size.enveloping([8, 9]) == [8, 9])
    }

    @Test func envelop() {
        var size: CGSize = [5, 7]

        size.envelop(.zero)
        #expect(size == [5, 7])

        size.envelop([3, 9])
        #expect(size == [5, 9])

        size.envelop([8, 2])
        #expect(size == [8, 9])
    }

    @Test func transposed() {
        let size: CGSize = [5, 7]

        #expect(size.transposed            == [7, 5])
        #expect(size.transposed.transposed == [5, 7])

        let square: CGSize = .square(of: 5)
        #expect(square.transposed == [5, 5])
    }

    @Test func rounded() {
        let size: CGSize = [5.4, 7.6]

        #expect(size.rounded(.down)                    == [5, 7])
        #expect(size.rounded(.up)                      == [6, 8])
        #expect(size.rounded(.towardZero)              == [5, 7])
        #expect(size.rounded(.toNearestOrAwayFromZero) == [5, 8])

        let negative: CGSize = [-5.4, -7.6]

        #expect(negative.rounded(.down)                    == [-6, -8])
        #expect(negative.rounded(.up)                      == [-5, -7])
        #expect(negative.rounded(.towardZero)              == [-5, -7])
        #expect(negative.rounded(.toNearestOrAwayFromZero) == [-5, -8])
    }

    @Test func multiplying() {
        let size: CGSize = [5, 7]

        #expect(size.multiplying(by: .zero) == .zero)

        #expect(size.multiplying(by: 1)   == [5, 7])
        #expect(size.multiplying(by: 2)   == [10, 14])
        #expect(size.multiplying(by: 0.5) == [2.5, 3.5])
        #expect(size.multiplying(by: -1)  == [-5, -7])
    }

    @Test func multiplyingAlong() {
        let size: CGSize = [5, 7]

        #expect(size.multiplying(by: .zero, along: .horizontal) == [0, 7])
        #expect(size.multiplying(by: .zero, along: .vertical)   == [5, 0])

        #expect(size.multiplying(by: 2, along: .horizontal) == [10, 7])
        #expect(size.multiplying(by: 2, along: .vertical)   == [5, 14])
    }

    @Test func hadamardBySize() {
        let size: CGSize = [5, 7]

        #expect(size.hadamard(by: .zero) == .zero)

        #expect(size.hadamard(by: [0, 1]) == [0, 7])
        #expect(size.hadamard(by: [1, 0]) == [5, 0])

        #expect(size.hadamard(by: [1, 1])   == [5, 7])
        #expect(size.hadamard(by: [2, 3])   == [10, 21])
        #expect(size.hadamard(by: [0.5, 2]) == [2.5, 14])
        #expect(size.hadamard(by: [-1, -2]) == [-5, -14])
    }

    @Test func scaledToFill() {
        // With one zero component the aspect ratio is undefined.
        // The non-zero component determines the scale.
        let zeroWidth: CGSize = [0, 10]
        #expect(zeroWidth.scaled(toFill: [20, 40]) == [0, 40])

        let zeroHeight: CGSize = [10, 0]
        #expect(zeroHeight.scaled(toFill: [20, 40]) == [20, 0])

        // Zero does not scale in any direction.
        #expect(CGSize.zero.scaled(toFill: [20, 40]) == .zero)

        let square: CGSize = .square(of: 10)
        #expect(square.scaled(toFill: [20, 40]) == [40, 40])
        #expect(square.scaled(toFill: [50, 30]) == [50, 50])
        #expect(square.scaled(toFill: [10, 10]) == [10, 10])
        #expect(square.scaled(toFill: .zero)    == .zero)

        let tall: CGSize = [10, 20]
        #expect(tall.scaled(toFill: [30, 30]) == [30, 60])

        // FIXME: add wide.
    }

    @Test func minMaxComponent() {
        let square: CGSize = .square(of: 5)
        #expect(square.minComponent == 5)
        #expect(square.maxComponent == 5)

        let tall: CGSize = [5, 7]
        #expect(tall.minComponent == 5)
        #expect(tall.maxComponent == 7)

        let wide: CGSize = [7, 5]
        #expect(wide.minComponent == 5)
        #expect(wide.maxComponent == 7)

        let negative: CGSize = [-5, 7]
        #expect(negative.minComponent == -5)
        #expect(negative.maxComponent == 7)
    }

    @Test func toPoint() {
        let size: CGSize = [5, 7]

        #expect(size.toPoint == [5, 7])
        #expect(CGSize.zero.toPoint == .zero)
    }

    @Test func rectWithOrigin() {
        let size: CGSize = [5, 7]

        #expect(size.rect()               == CGRect(origin: .zero,  size: [5, 7]))
        #expect(size.rect(origin: [3, 4]) == CGRect(origin: [3, 4], size: [5, 7]))
    }

    @Test func centeredInSize() {
        let size: CGSize = [60, 40]
        let container: CGSize = [200, 100]

        #expect(size.centered(in: container) == CGRect(origin: [70, 30], size: [60, 40]))
    }

    @Test func centeredInRect() {
        let size: CGSize = [60, 40]
        let container = CGRect(origin: [5, 7], size: [200, 100])

        #expect(size.centered(in: container) == CGRect(origin: [75, 37], size: [60, 40]))
    }

}
