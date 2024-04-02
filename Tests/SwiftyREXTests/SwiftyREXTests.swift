import XCTest
@testable import SwiftyREX

final class SwiftyREXTests: XCTestCase {
    func replace() {
        var string = "Check out the new iPhone 15"

        guard let regex = try? SwiftyREX(#"(\d+)"#) else {
            return XCTFail("SwiftyREX could not be created")
        }

        guard let match = regex.matches(in: string).first else {
            return XCTFail("Match not found")
        }

        string.replaceSubrange(match.range, with: "16")

        XCTAssertEqual(string, "Check out the new iPhone 16")
    }
    
    func parsing() {
        let string = """
        [
            {username: "root", password: "fh6Cf&Tt"},
            {username: "admin", password: "4SB&FNYc"},
            {username: "guest", password: "tvsa4Lg,"},
            {username: "info", password: "Mk-dAd8D"},
        ]
        """

        guard
            let regex = try? SwiftyREX(#"username: "([^"]+)", password: "([^"]+)""#)
        else {
            return XCTFail("SwiftyREX could not be created")
        }

        typealias Credential = (username: String, password: String)

        let credentials: [Credential] = regex.matches(in: string).compactMap {
            guard
                let username = $0.captures[safe: 0]?.value,
                let password = $0.captures[safe: 1]?.value
            else {
                return nil
            }

            return (username: username, password: password)
        }

        XCTAssertEqual(credentials.count, 4)

        guard let adminCredential = credentials.filter({ $0.username == "admin" }).first else {
            return XCTFail("Admin credential not found")
        }

        XCTAssertEqual(adminCredential.password, "4SB&FNYc")
    }

    func email() {
        let string = "m1k3@github.com"

        guard
            let email = try? SwiftyREX(#"^\w+@\w+.\w+$"#)
        else {
            return XCTFail("SwiftyREX could not be created")
        }

        guard case email = string else {
            return XCTFail("Email could not be parsed")
        }
    }
}
