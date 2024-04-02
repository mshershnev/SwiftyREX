import Foundation

public struct SwiftyREX {
    internal let regex: NSRegularExpression

    public init(_ pattern: String) throws {
        regex = try NSRegularExpression(pattern: pattern)
    }
    
    public func matches(in string: String) -> [Match] {
        regex
            .matches(
                in: string,
                range: .init(string.startIndex..., in: string)
            )
            .map { match in
                (0..<match.numberOfRanges).map {
                    match.range(at: $0)
                }
            }
            .compactMap { ranges -> [Capture] in
                ranges.compactMap {
                    guard let range = Range($0, in: string) else {
                        return nil
                    }
                    
                    return .init(value: String(string[range]), range: range)
                }
            }
            .compactMap { captures in
                guard let match = captures.first else {
                    return nil
                }

                return .init(
                    value: match.value,
                    range: match.range,
                    captures: Array(captures[1 ..< captures.count])
                )
            }
    }
}

extension SwiftyREX {
    public struct Capture {
        let value: String
        let range: Range<String.Index>
    }
}

extension SwiftyREX {
    public struct Match {
        let value: String
        let range: Range<String.Index>

        let captures: [Capture]
    }
}

extension SwiftyREX {
    public static func ~=(regex: Self, string: String) -> Bool {
        !regex.matches(in: string).isEmpty
    }
}
