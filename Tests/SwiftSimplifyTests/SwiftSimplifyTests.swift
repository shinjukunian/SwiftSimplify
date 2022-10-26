//
//  SwiftSimplifyTests.swift
//  SwiftSimplify
//
//  Created by Daniele Margutti on 28/06/2019.
//  Copyright © 2019 SwiftSimplify. All rights reserved.
//

import Foundation
import XCTest
import SwiftSimplify


struct TestCase:Decodable{
    let tolerance:Float
    let points:[[Float]]
    let simplified:[[Float]]
    
    func cgPoints(pointsArray:[[Float]])->[CGPoint]{
        return pointsArray.map({return CGPoint(x: Double($0[0]), y: Double($0[1]))})
    }
    
}


class SwiftSimplifyTests: XCTestCase {
   
    /// The following test ensure simplification works as expected.
    /// The original version was in JS and can be found:
    /// https://mourner.github.io/simplify-js/
    func testSimplifyPoints() throws {
        let url = Bundle.module.url(forResource: "SimplifyTestPoints", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let cases=try JSONDecoder().decode([TestCase].self, from: data)

        for test in cases {
            let points = test.cgPoints(pointsArray: test.points)
            let simplifiedPoints = test.cgPoints(pointsArray: test.simplified)
            let tolerance = test.tolerance
            executeTestForPoints(points, simplified: simplifiedPoints, tolerance: tolerance)
        }
        
    }
    
    func executeTestForPoints(_ initialPoints: [CGPoint], simplified: [CGPoint], tolerance: Float) {
        let algorithmResult = SwiftSimplify.simplify(initialPoints, tolerance: tolerance)
        guard algorithmResult.count == simplified.count else {
            XCTFail("Failed to simplify; algorithm return \(algorithmResult.count) points, expected \(simplified.count) points")
            return
        }
        
        for i in 0..<algorithmResult.count {
            guard algorithmResult[i] == simplified[i] else {
                XCTFail("Failed to simplify; expected point \(algorithmResult[i]), expected \(simplified[i])")
                return
            }
        }
    }
    
}
