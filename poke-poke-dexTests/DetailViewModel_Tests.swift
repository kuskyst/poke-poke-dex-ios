//
//  DetailViewModel_Tests.swift
//  poke-poke-dexTests
//
//  Created by kohsaka on 2023/11/21.
//

import XCTest
@testable import poke_poke_dex

final class DetailViewModel_Tests: XCTestCase {

    var viewModel: DetailViewModel!

    override func setUp() {
        self.viewModel = DetailViewModel()
        super.setUp()
    }

    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchDetailSuccess() {
        self.viewModel.fetchPokeDetail(id: 700)
        XCTAssertNotNil(self.viewModel.pokemon)
    }

    func testFetchDataFailure() {

    }

}
