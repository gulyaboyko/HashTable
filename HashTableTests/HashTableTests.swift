//
//  HashTableTests.swift
//  HashTableTests
//
//  Created by Gulya Boiko on 7/31/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest
@testable import HashTable

final class HashTableTests: XCTestCase {
    
    func test_performance() {
        var array: [Int] = []
        let sut = HashTable<Int, String>()
        (0...100_000).forEach { v in
            sut.put(key: v, value: String(v))
            array.append(v)
        }
        let startTime0 = Date()
        sut.get(key: 1) == "1"
        let endTime0 = Date().second(from: startTime0)
        print(endTime0)
        let startTime00 = Date()
        _ = array.first { $0 == 1 }
        let endTime00 = Date().second(from: startTime00)
        print(endTime00)
        let startTime1 = Date()
        sut.get(key: 50_000) == "50000"
        let endTime1 = Date().second(from: startTime1)
        print(endTime1)
        let startTime10 = Date()
        _ = array.first { $0 == 50000 }
        let endTime10 = Date().second(from: startTime10)
        print(endTime10)
        let startTime2 = Date()
        sut.get(key: 100_000) == "100000"
        let endTime2 = Date().second(from: startTime2)
        print(endTime2)
        let startTime20 = Date()
        _ = array.first { $0 == 100000 }
        let endTime20 = Date().second(from: startTime20)
        print(endTime20)
    }

    func test_put_get() {
        let sut = HashTable<Int, String>()
        XCTAssertNil(sut.get(key: 0))
        sut.put(key: 0, value: "0")
        sut.put(key: 1, value: "1")
        sut.put(key: 2, value: "2")
        sut.put(key: 3, value: "3")
        sut.put(key: 4, value: "4")
        sut.put(key: 5, value: "5")
        sut.put(key: 6, value: "6")
        sut.put(key: 7, value: "7")
        sut.put(key: 8, value: "8")
        sut.put(key: 9, value: "9")
        sut.put(key: 10, value: "10")
        sut.put(key: 11, value: "11")
        sut.put(key: 12, value: "12")
        XCTAssert(sut.get(key: 0) == "0")
        XCTAssert(sut.get(key: 1) == "1")
        XCTAssert(sut.get(key: 2) == "2")
        XCTAssert(sut.get(key: 3) == "3")
        XCTAssert(sut.get(key: 4) == "4")
        XCTAssert(sut.get(key: 5) == "5")
        XCTAssert(sut.get(key: 6) == "6")
        XCTAssert(sut.get(key: 7) == "7")
        XCTAssert(sut.get(key: 8) == "8")
        XCTAssert(sut.get(key: 9) == "9")
        XCTAssert(sut.get(key: 10) == "10")
        XCTAssert(sut.get(key: 11) == "11")
        XCTAssertNil(sut.remove(key: 100))
        
        XCTAssert(sut.remove(key: 11) == "11")
        XCTAssertNil(sut.get(key: 11))
    }
    
}

extension Date {
    func second(from date: Date) -> Double {
        Double(Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond!) / 1000000000
    }
}
