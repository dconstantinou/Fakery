import Foundation

public class Generator {
  public struct Constants {
    public static let uppercaseLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    public static let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    public static let numbers = Array("0123456789")
  }

  let parser: Parser
  let dateFormatter: DateFormatter

  public required init(parser: Parser) {
    self.parser = parser
    dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
  }

  public func generate(_ key: String) -> String {
    return parser.fetch(key)
  }

  // MARK: - Filling

  public func numerify(_ string: String) -> String {
    return String(string.enumerated().map { (index, item) in
      let char = Constants.numbers.random()!
      return String(item) == "#" ? char : item
      })
  }

  public func letterify(_ string: String) -> String {
    return String(string.enumerated().map { _, item in
      let char = Constants.uppercaseLetters.random()!
      return String(item) == "?" ? char : item
      })
  }

  public func bothify(_ string: String) -> String {
    return letterify(numerify(string))
  }

  public func alphaNumerify(_ string: String) -> String {
    return string.replacingOccurrences(of: "[^A-Za-z0-9_]",
      with: "",
      options: .regularExpression,
      range: nil)
  }

  public func randomWordsFromKey(_ key: String) -> String {
    var string = ""

    var list = [String]()
    if let wordsList = parser.fetchRaw(key) as? [[String]] {
      for words in wordsList {
        if let item = words.random() {
          list.append(item)
        }
      }

      string = list.joined(separator: " ")
    }

    return string
  }
}
