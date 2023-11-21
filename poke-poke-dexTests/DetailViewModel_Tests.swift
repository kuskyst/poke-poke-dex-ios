//
//  DetailViewModel_Tests.swift
//  poke-poke-dexTests
//
//  Created by kohsaka on 2023/11/21.
//

import XCTest
import RxSwift
import RxTest
import Moya
@testable import poke_poke_dex

final class DetailViewModel_Tests: XCTestCase {

    private var viewModel: DetailViewModel!
    private var pokeProvider: MoyaProvider<PokeApi>!
    private var imageProvider: MoyaProvider<ImageApi>!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        self.setUpMock(stub: false)
    }

    override func tearDown() {
        self.viewModel = nil
        self.disposeBag = nil
        self.pokeProvider = nil
        self.imageProvider = nil
        self.scheduler = nil
        super.tearDown()
    }

    private func setUpMock(stub: Bool = false) {
        self.pokeProvider = stub ?
            MoyaProvider<PokeApi>(stubClosure: MoyaProvider.immediatelyStub)
                : MoyaProvider<PokeApi>()
        self.imageProvider = stub ?
            MoyaProvider<ImageApi>(stubClosure: MoyaProvider.immediatelyStub)
                : MoyaProvider<ImageApi>()
        self.viewModel = DetailViewModel(pokeProvider: self.pokeProvider, imageProvider: self.imageProvider)
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }

    func testFetchDetailSuccess() {
        self.setUpMock()
        let ex = expectation(description: "sylveon-detail")
        self.scheduler.scheduleAt(0) {
            self.viewModel.pokemon.subscribe(onNext: { pokemon in
                XCTAssertNotNil(pokemon)
                XCTAssertEqual(pokemon.id, 700)
                XCTAssertEqual(pokemon.name, "sylveon")
                ex.fulfill()
            }).disposed(by: self.disposeBag)
        }
        self.scheduler.scheduleAt(100) {
            self.viewModel.fetchPokeDetail(id: 700)
        }
        self.scheduler.start()
        self.wait(for: [ex], timeout: 1)
    }

    func testFetchSpeciesSuccess() {
        self.setUpMock()
        let ex = expectation(description: "weavile-species")
        self.scheduler.scheduleAt(0) {
            self.viewModel.species.subscribe(onNext: { species in
                XCTAssertNotNil(species)
                XCTAssertEqual(species.id, 461)
                ex.fulfill()
            }).disposed(by: self.disposeBag)
        }
        self.scheduler.scheduleAt(100) {
            self.viewModel.fetchPokeSpecies(id: 461)
        }
        self.scheduler.start()
        self.wait(for: [ex], timeout: 1)
    }

    func testFetchImageSuccess() {
        self.setUpMock()
        let ex1 = expectation(description: "floatzel-front-default-image")
        let ex2 = expectation(description: "floatzel-front-shiny-image")
        let ex3 = expectation(description: "floatzel-back-default-image")
        let ex4 = expectation(description: "floatzel-back-shiny-image")
        self.scheduler.scheduleAt(0) {
            self.viewModel.fr_def_img.subscribe(onNext: { image in
                XCTAssertNotNil(image)
                ex1.fulfill()
            }).disposed(by: self.disposeBag)
            self.viewModel.fr_shi_img.subscribe(onNext: { image in
                XCTAssertNotNil(image)
                ex2.fulfill()
            }).disposed(by: self.disposeBag)
            self.viewModel.bk_def_img.subscribe(onNext: { image in
                XCTAssertNotNil(image)
                ex3.fulfill()
            }).disposed(by: self.disposeBag)
            self.viewModel.bk_shi_img.subscribe(onNext: { image in
                XCTAssertNotNil(image)
                ex4.fulfill()
            }).disposed(by: self.disposeBag)
        }
        self.scheduler.scheduleAt(100) {
            self.viewModel.fetchImage(type: ImageApi.front_default(419))
            self.viewModel.fetchImage(type: ImageApi.front_shiny(419))
            self.viewModel.fetchImage(type: ImageApi.back_default(419))
            self.viewModel.fetchImage(type: ImageApi.back_shiny(419))
        }
        self.scheduler.start()
        self.wait(for: [ex1, ex2, ex3, ex4], timeout: 10)
    }
}
