//
//  ListViewModel_Tests.swift
//  poke-poke-dexTests
//
//  Created by kohsaka on 2023/11/21.
//

import XCTest
import RxSwift
import RxTest
import Moya
@testable import poke_poke_dex

final class ListViewModel_Tests: XCTestCase {

    private var viewModel: ListViewModel!
    private var provider: MoyaProvider<PokeApi>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        self.setUpMock()
    }

    override func tearDown() {
        self.viewModel = nil
        self.disposeBag = nil
        self.provider = nil
        self.scheduler = nil
        super.tearDown()
    }

    private func setUpMock(stub: Bool = false) {
        self.provider = stub ?
            MoyaProvider<PokeApi>(stubClosure: MoyaProvider.immediatelyStub)
                : MoyaProvider<PokeApi>()
        self.viewModel = ListViewModel(provider: self.provider)
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }

    func testFetchListSuccess() {
        self.setUpMock()
        let ex = expectation(description: "success")
        self.scheduler.scheduleAt(0) {
            self.viewModel.pokemons.subscribe(onNext: { pokemons in
                XCTAssertNotNil(pokemons)
                XCTAssertEqual(pokemons.count, 151)
                ex.fulfill()
            }).disposed(by: self.disposeBag)
        }
        self.scheduler.scheduleAt(100) {
            self.viewModel.fetchPokeList(param: AppConstant.paramList.first!)
        }
        self.scheduler.start()
        self.wait(for: [ex], timeout: 0.1)
    }

    func testFetchListFailure() {
        self.setUpMock(stub: true)
        let ex = expectation(description: "failure")
        self.scheduler.scheduleAt(0) {
            self.viewModel.pokemons.subscribe(onError: { error in
                XCTAssertNotNil(error)
                ex.fulfill()
            }).disposed(by: self.disposeBag)
        }
        self.scheduler.scheduleAt(100) {
            self.viewModel.fetchPokeList(param: AppConstant.paramList.first!)
        }
        self.scheduler.start()
        self.wait(for: [ex], timeout: 0.1)
    }

}
