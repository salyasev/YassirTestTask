import XCTest

// No expirience with Apple XCTest for UI tests
// Always used other SDKs instead (like Mixbox from AvitoTech)
final class MovieDetailsUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    func testMovieDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()

        // given
        app.tables.cells.firstMatch.tap()
        
        let movieDatailsView = app.otherElements["MovieDatailsViewController.view"]
        let taglineLabel = app.staticTexts["taglineLabel"]
        let overviewLabel = app.staticTexts["overviewLabel"]
        let exists = NSPredicate(format: "exists == 1")

        // then
        expectation(for: exists, evaluatedWith: movieDatailsView, handler: nil)
        expectation(for: exists, evaluatedWith: taglineLabel, handler: nil)
        expectation(for: exists, evaluatedWith: overviewLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // TODO ... add other tests
}
