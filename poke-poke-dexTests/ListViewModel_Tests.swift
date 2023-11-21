//
//  ListViewModel_Tests.swift
//  poke-poke-dexTests
//
//  Created by kohsaka on 2023/11/21.
//

import XCTest
@testable import poke_poke_dex

final class ListViewModel_Tests: XCTestCase {

    var viewModel: ListViewModel!

    override func setUp() {
        self.viewModel = ListViewModel()
        super.setUp()
    }

    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchDataSuccess() {
        self.viewModel.fetchPokeList(param: AppConstant.paramList.first!)
        XCTAssertNotNil(self.viewModel.pokemons)
    }

    func testFetchDataFailure() {
        
    }

}
