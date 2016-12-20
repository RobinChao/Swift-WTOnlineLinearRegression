//
//  LinearRegressionEquationTests.swift
//  WTOnlineLinearRegression
//
//  Created by Wagner Truppel on 2016.12.07.
//
//  Copyright (c) 2016 Wagner Truppel. All rights reserved.
//

import UIKit
import XCTest

import WTOnlineLinearRegression

class LinearRegressionEquationTests: XCTestCase
{
    var slope: UncertainValue<Double>!
    var interceptY: UncertainValue<Double>!
    var interceptX: Double!

    var linEq1: LinearRegressionEquation<Double>!
    var linEq2: LinearRegressionEquation<Double>!
    var linEq3: LinearRegressionEquation<Double>!

    override func setUp()
    {
        super.setUp()

        slope = try! UncertainValue<Double>(value: 3, variance: 5)
        interceptY = try! UncertainValue<Double>(value: -4, variance: 2)
        interceptX = 7

        linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope,
                                                              interceptY: interceptY)

        linEq2 = LinearRegressionEquation<Double>.infiniteSlope(interceptX: interceptX)

        linEq3 = LinearRegressionEquation<Double>.degenerate(interceptX: interceptX,
                                                             interceptY: interceptY.value)
    }

    // MARK: -

    func testIsDegenerate1()
    {
        XCTAssertFalse(linEq1.isDegenerate)
    }

    func testIsDegenerate2()
    {
        XCTAssertFalse(linEq2.isDegenerate)
    }

    func testIsDegenerate3()
    {
        XCTAssertTrue(linEq3.isDegenerate)
    }

    // MARK: -

    func testHasFiniteSlope1()
    {
        XCTAssertTrue(linEq1.hasFiniteSlope)
    }

    func testHasFiniteSlope2()
    {
        XCTAssertFalse(linEq2.hasFiniteSlope)
    }

    func testHasFiniteSlope3()
    {
        XCTAssertFalse(linEq3.hasFiniteSlope)
    }

    // MARK: -

    func testHasZeroSlope0()
    {
        slope = try! UncertainValue<Double>(value: 0, variance: 5)

        linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope,
                                                              interceptY: interceptY)

        XCTAssertTrue(linEq1.hasZeroSlope)
    }

    func testHasZeroSlope1()
    {
        XCTAssertFalse(linEq1.hasZeroSlope)
    }

    func testHasZeroSlope2()
    {
        XCTAssertFalse(linEq2.hasZeroSlope)
    }

    func testHasZeroSlope3()
    {
        XCTAssertFalse(linEq3.hasZeroSlope)
    }

    // MARK: -

    func testSlope1()
    {
        let expected = slope
        let resulted = linEq1.slope
        XCTAssertEqual(resulted, expected)
    }

    func testSlope2()
    {
        let expected: UncertainValue<Double>? = nil
        let resulted = linEq2.slope
        XCTAssertEqual(resulted, expected)
    }

    func testSlope3()
    {
        let expected: UncertainValue<Double>? = nil
        let resulted = linEq3.slope
        XCTAssertEqual(resulted, expected)
    }

    // MARK: -

    func testInterceptY1()
    {
        let expected = interceptY
        let resulted = linEq1.interceptY
        XCTAssertEqual(resulted, expected)
    }

    func testInterceptY2()
    {
        let expected: UncertainValue<Double>? = nil
        let resulted = linEq2.interceptY
        XCTAssertEqual(resulted, expected)
    }

    func testInterceptY3()
    {
        let expected = try! UncertainValue<Double>(value: -4, variance: 0)
        
        let resulted = linEq3.interceptY
        XCTAssertEqual(resulted, expected)
    }

    // MARK: -

    func testInterceptX0()
    {
        slope = try! UncertainValue<Double>(value: 0, variance: 5)

        linEq1 = LinearRegressionEquation<Double>.finiteSlope(
            slope: slope,
            interceptY: interceptY)

        XCTAssertEqual(linEq1.interceptX, nil)
    }

    func testInterceptX1()
    {
        let expected = -(interceptY.value / slope.value)
        let resulted = linEq1.interceptX
        XCTAssertEqual(resulted, expected)
    }

    func testInterceptX2()
    {
        let expected = interceptX
        let resulted = linEq2.interceptX
        XCTAssertEqual(resulted, expected)
    }

    func testInterceptX3()
    {
        let expected = interceptX
        let resulted = linEq3.interceptX
        XCTAssertEqual(resulted, expected)
    }

    // MARK: -

    func testConformanceToEquatable11a()
    {
        XCTAssertTrue(linEq1 == linEq1)
    }

    func testConformanceToEquatable11b()
    {
        let s1: Double = 10
        let s2: Double = 1

        let sv1: Double = 2
        let sv2: Double = 2

        let iy1: Double = 3
        let iy2: Double = 3

        let viy1: Double = 4
        let viy2: Double = 4

        let slope1 = try! UncertainValue<Double>(value: s1, variance: sv1)
        let slope2 = try! UncertainValue<Double>(value: s2, variance: sv2)

        let intcptY1 = try! UncertainValue<Double>(value: iy1, variance: viy1)
        let intcptY2 = try! UncertainValue<Double>(value: iy2, variance: viy2)

        let linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope1,
                                                                  interceptY: intcptY1)

        let linEq2 = LinearRegressionEquation<Double>.finiteSlope(slope: slope2,
                                                                  interceptY: intcptY2)
        
        XCTAssertTrue(linEq2 != linEq1)
    }

    func testConformanceToEquatable11c()
    {
        let s1: Double = 1
        let s2: Double = 1

        let sv1: Double = 20
        let sv2: Double = 2

        let iy1: Double = 3
        let iy2: Double = 3

        let viy1: Double = 4
        let viy2: Double = 4

        let slope1 = try! UncertainValue<Double>(value: s1, variance: sv1)
        let slope2 = try! UncertainValue<Double>(value: s2, variance: sv2)

        let intcptY1 = try! UncertainValue<Double>(value: iy1, variance: viy1)
        let intcptY2 = try! UncertainValue<Double>(value: iy2, variance: viy2)

        let linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope1,
                                                                  interceptY: intcptY1)

        let linEq2 = LinearRegressionEquation<Double>.finiteSlope(slope: slope2,
                                                                  interceptY: intcptY2)
        
        XCTAssertTrue(linEq2 != linEq1)
    }

    func testConformanceToEquatable11d()
    {
        let s1: Double = 1
        let s2: Double = 1

        let sv1: Double = 2
        let sv2: Double = 2

        let iy1: Double = 30
        let iy2: Double = 3

        let viy1: Double = 4
        let viy2: Double = 4

        let slope1 = try! UncertainValue<Double>(value: s1, variance: sv1)
        let slope2 = try! UncertainValue<Double>(value: s2, variance: sv2)

        let intcptY1 = try! UncertainValue<Double>(value: iy1, variance: viy1)
        let intcptY2 = try! UncertainValue<Double>(value: iy2, variance: viy2)

        let linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope1,
                                                                  interceptY: intcptY1)

        let linEq2 = LinearRegressionEquation<Double>.finiteSlope(slope: slope2,
                                                                  interceptY: intcptY2)
        
        XCTAssertTrue(linEq2 != linEq1)
    }

    func testConformanceToEquatable11e()
    {
        let s1: Double = 1
        let s2: Double = 1

        let sv1: Double = 2
        let sv2: Double = 2

        let iy1: Double = 3
        let iy2: Double = 3

        let viy1: Double = 40
        let viy2: Double = 4

        let slope1 = try! UncertainValue<Double>(value: s1, variance: sv1)
        let slope2 = try! UncertainValue<Double>(value: s2, variance: sv2)

        let intcptY1 = try! UncertainValue<Double>(value: iy1, variance: viy1)
        let intcptY2 = try! UncertainValue<Double>(value: iy2, variance: viy2)

        let linEq1 = LinearRegressionEquation<Double>.finiteSlope(slope: slope1,
                                                                  interceptY: intcptY1)

        let linEq2 = LinearRegressionEquation<Double>.finiteSlope(slope: slope2,
                                                                  interceptY: intcptY2)
        
        XCTAssertTrue(linEq2 != linEq1)
    }

    func testConformanceToEquatable12()
    {
        XCTAssertTrue(linEq1 != linEq2)
    }

    func testConformanceToEquatable13()
    {
        XCTAssertTrue(linEq1 != linEq3)
    }

    func testConformanceToEquatable22a()
    {
        XCTAssertTrue(linEq2 == linEq2)
    }

    func testConformanceToEquatable22b()
    {
        let ix1: Double = 10
        let ix2: Double = 1

        let linEq1 = LinearRegressionEquation<Double>.infiniteSlope(interceptX: ix1)
        let linEq2 = LinearRegressionEquation<Double>.infiniteSlope(interceptX: ix2)

        XCTAssertTrue(linEq2 != linEq1)
    }
    
    func testConformanceToEquatable23()
    {
        XCTAssertTrue(linEq2 != linEq3)
    }
    
    func testConformanceToEquatable33a()
    {
        XCTAssertTrue(linEq3 == linEq3)
    }

    func testConformanceToEquatable33b()
    {
        let ix1: Double = 10
        let ix2: Double = 1

        let iy: Double = 2

        let linEq1 = LinearRegressionEquation<Double>.degenerate(interceptX: ix1,
                                                                 interceptY: iy)
        let linEq2 = LinearRegressionEquation<Double>.degenerate(interceptX: ix2,
                                                                 interceptY: iy)

        XCTAssertTrue(linEq2 != linEq1)
    }

    func testConformanceToEquatable33c()
    {
        let ix: Double = 1

        let iy1: Double = 20
        let iy2: Double = 2

        let linEq1 = LinearRegressionEquation<Double>.degenerate(interceptX: ix,
                                                                 interceptY: iy1)
        let linEq2 = LinearRegressionEquation<Double>.degenerate(interceptX: ix,
                                                                 interceptY: iy2)

        XCTAssertTrue(linEq2 != linEq1)
    }
}

