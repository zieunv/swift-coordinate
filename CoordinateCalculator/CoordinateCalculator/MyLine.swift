//
//  MyLine.swift
//  CoordinateCalculator
//
//  Created by JieunKim on 14/05/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

struct MyLine: Drawable {
    private var pointA = MyPoint(x: 0, y: 0)
    private var pointB = MyPoint(x: 0, y: 0)
    private var length: Double {
        return sqrt(pow(Double(pointA.x - pointB.x),2) + pow(Double(pointA.y - pointB.y),2))
    }
    var points: [MyPoint] {
        return [pointA, pointB]
    }
    
    init(pointA: MyPoint, pointB: MyPoint) {
        self.pointA = pointA
        self.pointB = pointB
    }
}

extension MyLine: Explanation {
    var explanation: String {
        return ExplanationType.line.description
    }
    var shapeValue: Double {
        return self.length
    }
}
