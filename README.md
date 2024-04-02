# SwiftyREX 🦖

NSRegularExpression wrapper.

## Usage

Replace:

```swift
var string = "Check out the new iPhone 15"

guard
    let regex = try? SwiftyREX(#"\d+"#),
    let match = regex.matches(in: string).first
else {
    return
}

string.replaceSubrange(match.range, with: "16")
print(string)

// Output: 
// Check out the new iPhone 16
```

Capturing:

```swift
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
    return
}

regex.matches(in: string).forEach {
    guard
        let username = $0.captures[safe: 0]?.value,
        let password = $0.captures[safe: 1]?.value
    else { 
        return 
    }

    print("\(username): \(password)")
}

// Output: 
// root: fh6Cf&Tt
// admin: 4SB&FNYc
// guest: tvsa4Lg,
// info: Mk-dAd8D
```

Switch statement:

```swift
let string = "m1k3@github.com"

guard
    let email = try? SwiftyREX(#"^\w+@\w+.\w+$"#)
else {
    return
}

switch string {
    case email: 
        print("Looks like an email")
    default: 
        print("Looks like NOT an email")
}

// Output: 
// Looks like an email
```

## Installation

#### Swift Package Manager

Add a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mshershnev/SwiftyREX")
]
```

## License

Regex is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
