//
//  convertInput.swift
//  CoordinateCalculator
//
//  Created by 김장수 on 20/10/2018.
//  Copyright © 2018 Codesquad Inc. All rights reserved.
//

import Foundation

// ConvertInput 구조체의 역할
// 입력 형태에 따라 정수형 좌표로 변환하고 전달

struct FigureCreator {
    private let rawPoints: String
    
    // 에러처리를 거친 입력이므로 correctInput으로 변수네이밍
    init(rawPoints: String) {
        self.rawPoints = rawPoints
    }
    
    // 초기 입력을 '-'을 기준으로 분리해주는 메소드
    // "(10,10)-(10,10)" -> ["(10,10)", "(10,10)"]
    // "(10,10)-(10,10)-(14,15)" -> ["(10,10)", "(10,10)", "(14,15)"]
    private func separate(_ input: String) -> [String] {
        return input.split(separator: "-").map {String($0)}
    }
    
    // 분리된 초기 입력 배열의 요소를 다시 ','을 기준으로 분리해주는 메소드
    // "(10,10)" -> ["10","10"]
    private func transform(_ point: String) -> [String] {
        return point.trimmingCharacters(in: ["(",")"]).split(separator: ",").map {String($0)}
    }
    
    // 분리된 배열의 요소들로 이중배열을 만들어주는 메소드
    // ["(10,10)", "(10,10)"] -> [["10","10"], ["10","10"]]
    // ["(10,10)", "(10,10)", "(14,15)"] -> [["10","10"], ["10","10"], ["14","15"]]
    private func makeRawPointsUsing(_ separatedCoordinates: [String]) -> [[String]] {
        var rawPoints: [[String]] = []
        
        separatedCoordinates.forEach {
            rawPoints.append(transform($0))
        }
        return rawPoints
    }
    
    // 배열의 요소들을 MyPoint에 구조체에 넣어 좌표를 리턴하는 메소드
    // ["10", "10"] -> MyPoint(x: 10, y: 10)
    private func makeSinglePoint(_ rawPoint: [String]) -> MyPoint {
        return MyPoint(x: Int(rawPoint[0]) ?? -1, y: Int(rawPoint[1]) ?? -1)
    }

    // 초기 입력값을 튜플로 좌표쌍으로 리턴하는 메소드
    // "(10,10)-(10,10)" -> [MyPoint(x: 10, y: 10),MyPoint(x: 10, y: 10)]
    private func makeMultiPoints(_ rawPoint: String) -> [MyPoint] {
        let separated = separate(rawPoint)
        let rawPoints = makeRawPointsUsing(separated)    // ["(10,10)", "(10,10)"] -> [["10","10"], ["10","10"]]
        var points: [MyPoint] = []
        
        rawPoints.forEach {
            points.append(makeSinglePoint($0))           // ["10", "10"]           -> MyPoint(x: 10, y: 10)
        }
        
        return points
    }
    
    // 생성된 도형(Figure)을 전달해주는 메소드
    // "(10,10)"                    -> MyPoint
    // "(10,10)-(14,15)"            -> MyLine
    // "(10,10)-(14,15)-(20,21)"    -> MyTriangle
    public func makeFigure() -> Figure {
        let separated = separate(rawPoints)
        let transformed = transform(rawPoints)
        
        switch separated.count {
        case 2:
            let line = makeMultiPoints(rawPoints)
            return MyLine(pointA: line[0], pointB: line[1]) // MyLine를 리턴
        case 3:
            let triangle = makeMultiPoints(rawPoints)
            return MyTriangle(pointA: triangle[0], pointB: triangle[1], pointC: triangle[2])
        default:
            return makeSinglePoint(transformed)     // MyPoint를 리턴
        }
    }
}