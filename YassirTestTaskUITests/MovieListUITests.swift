import XCTest

// No expirience with Apple XCTest for UI tests
// Always used other SDKs instead (like Mixbox from AvitoTech)
final class MovieListUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testMovieListScreen() throws {
        let app = XCUIApplication()
        app.launch()

        // given
        let tableView = app.tables["MovieListViewController.tableView"]
        let cells = tableView.cells.element
        let cellStaticText = cells.staticTexts.element
        let cell = tableView.cells["MovieCell_787699"]
        let title = cell.staticTexts["nameLabel"].label
        let vote = cell.staticTexts["voteLabel"].label
        let year = cell.staticTexts["yearLabel"].label

        // then
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(cells.exists)
        XCTAssertTrue(cellStaticText.exists)
        XCTAssertTrue(cell.exists)
        XCTAssertEqual(title, "Wonka")
        XCTAssertEqual(vote, "Score: 7.3 (386)")
        XCTAssertEqual(year, "2023")

        // TODO ... add other checks for equality etc
    }
    
    // TODO ... add other tests
}
