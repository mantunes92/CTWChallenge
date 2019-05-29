//
//  Data_NetworkTests.swift
//  Data_NetworkTests
//
//  Created by Marcelo Antunes on 5/29/19.
//  Copyright © 2019 Marcelo Antunes. All rights reserved.
//

@testable import Data_Network
import XCTest
import RxSwift

class Data_NetworkTests: XCTestCase {

    var sut: NetworkProvider = Network()
    var disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        disposeBag = DisposeBag()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSuggestions() {
        let pos = PositionDto(latitude: 38.743961, longitude: -9.148526)
        let request = SuggestionsRequest(query: "Portugal", prox: (pos, nil))
        sut.getSuggestions(request: request)
            .subscribe(onSuccess: { response in
                XCTAssert(!response.suggestions.isEmpty)
            },
                       onError: { error in
                        XCTAssert(false, error.localizedDescription)
            })
    }

}
