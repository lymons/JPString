//
//  JPStringTests.swift
//  JPStringTests
//
//  Created by デニス on 8/18/28 H.
//  Copyright © 28 Heisei Dennis Russell. All rights reserved.
//

import XCTest
@testable import JPString

class JPStringTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testExample() {

    let jps = JPString()

	XCTAssertEqual("ネコヲタベタ", jps.hiraToKata("ねこをたべた"))
	XCTAssertEqual("ネコヲdon't do itタベタ", jps.hiraToKata("ねこをdon't do itたべた"))
	XCTAssertEqual("ねこをたべた", jps.kataToHira("ネコヲタベタ"))
	XCTAssertEqual("ねこをwhy would you do thisたべた", jps.kataToHira("ネコヲwhy would you do thisタベタ"))
	XCTAssertEqual("nekowotabeta", jps.hiraToRomaji("ねこをたべた"))
	XCTAssertEqual("nekowotabeta@", jps.hiraToRomaji("ねこをたべた@"))
	XCTAssertEqual("nihonniikimashita", jps.hiraToRomaji("にほんにいきました"))
    XCTAssertEqual("nekowotabeta", jps.kataToRomaji("ネコヲタベタ"))
	XCTAssertEqual("ねこをたべた", jps.romajiToHira("nekowotabeta"))
	XCTAssertEqual("だいがくいんはすっごくたいへんだった", jps.romajiToHira("daigakuinhasuggokutaihendatta"))
	XCTAssertEqual("ネコヲタベタ", jps.romajiToKata("nekowotabeta"))
    XCTAssertEqual("我輩猫。", jps.stripScripts("我輩は猫である。", [.KANA]))

  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
