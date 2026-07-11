//
//  ProductsListTests.swift
//  ProductsListTests
//
//  Created by Pujitha Kadiyala on 6/29/26.
//

import XCTest
@testable import ProductsList
@MainActor
final class ProductsListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadProductsSuccess() async {
        let mockService = MockService()
        
        let viewModel = ProductsViewModel(
            service: mockService
        )
        
        await viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.productsList.count, 1)
        
        XCTAssertEqual(viewModel.productsList.first?.title, "iPhone")
        
        XCTAssertNil(viewModel.errorString)
        
        XCTAssertFalse(viewModel.loadingState)
    }
    
    func testLoadProductsFailure() async {
        let mockService = MockService()
        
        let viewModel = ProductsViewModel(
            service: mockService
        )

        mockService.shouldThrowError = true

        await viewModel.fetchProducts()

        XCTAssertTrue(viewModel.productsList.isEmpty)

        XCTAssertNotNil(viewModel.errorString)

        XCTAssertFalse(viewModel.loadingState)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
