import Foundation

public final class Internet: Generator {
  private let lorem: Lorem

  public required init(parser: Parser) {
    self.lorem = Lorem(parser: parser)
    super.init(parser: parser)
  }

  public func username(separator: String? = nil) -> String {
    var components: [String] = [
      generate("name.first_name"),
      generate("name.last_name"),
      "\(Int.random(in: 0...10000))"
    ]

    let randomCount = Int(components.count) - 1
    let count =  Int.random(in: 0...randomCount) + randomCount

    var gap = ""
    if let sep = separator {
      gap = sep
    }

    return components[0..<count].joined(separator: gap)
      .replacingOccurrences(of: "'", with: "")
      .lowercased()
  }

  public func domainName(_ alphaNumericOnly: Bool = true) -> String {
    return domainWord(alphaNumericOnly: alphaNumericOnly) + "." + domainSuffix()
  }

  public func domainWord(alphaNumericOnly: Bool = true) -> String {
    let nameParts = generate("company.name").components(separatedBy: " ")
    var name = ""

    if let first = nameParts.first {
      name = first
    } else {
      name = letterify("?????")
    }

    let result = alphaNumericOnly ? alphaNumerify(name) : name

    return result.lowercased()
  }

  public func domainSuffix() -> String {
    return generate("internet.domain_suffix")
  }

  public func email() -> String {
    return [username(), domainName()].joined(separator: "@")
  }

  public func freeEmail() -> String {
    return [username(), generate("internet.free_email")].joined(separator: "@")
  }

  public func safeEmail() -> String {
    let topLevelDomains = ["org", "com", "net"]
    let topLevelDomain = topLevelDomains.random()!

    return [username(), "example." + topLevelDomain].joined(separator: "@")
  }

  public func password(minimumLength: Int = 8, maximumLength: Int = 16) -> String {
    var temp = lorem.characters(amount: minimumLength)
    let diffLength = maximumLength - minimumLength

    if diffLength > 0 {
      let diffRandom = Int.random(in: 0...diffLength)
      temp += lorem.characters(amount: diffRandom)
    }

    return temp
  }

  public func ipV4Address() -> String {
    let ipRand = {
      Int.random(in: 2...253)
    }

    return String(format: "%d.%d.%d.%d", ipRand(), ipRand(), ipRand(), ipRand())
  }

  public func ipV6Address() -> String {
    var components: [String] = []

    for _ in 0..<8 {
      components.append(String(format: "%X", Int.random(in: 0...65536) ))
    }

    return components.joined(separator: ":")
  }

  public func url() -> String {
    return "https://\(domainName())/\(username())"
  }

  public func image(width: Int = 320, height: Int = 200) -> String {
    return "https://lorempixel.com/\(width)/\(height)"
  }

  public func templateImage(width: Int = 320, height: Int = 200,
                            backColorHex: String = "000000", frontColorHex: String = "ffffff") -> String {
      return "https://dummyimage.com/\(width)x\(height)/\(backColorHex)/\(frontColorHex)"
  }

  public func hashtag() -> String {
    return generate("internet.hashtag")
  }

  // @ToDo - slug
}
