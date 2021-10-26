//
//  RecipeServiceTest.swift
//  RecipleaseTests
//
//  Created by Jihed Agrebaoui on 21/10/2021.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeServiceTest: XCTestCase {
    
    func testGetRecipeShouldPostFailedCallbackIfError() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken", "cheese"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken","cheese"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.quoteIncorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken", "cheese"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfResponseKO() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.quoteCorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken", "cheese"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken", "cheese"]) { success, recipes in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetRecipShouldPostSuccessCallbackIfNoErrorWithCorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.quoteCorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(edamamSession: edamamSessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(ingredients: ["chicken", "cheese"]) { success, recipes in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            XCTAssertEqual(recipes?[0].label, "Salsa Chicken & Cheese Tortillas")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
