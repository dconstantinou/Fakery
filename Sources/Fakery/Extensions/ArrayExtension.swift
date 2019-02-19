import Foundation

extension Array {
  func at(_ index: Int?) -> Element? {
    guard let index = index, index >= 0 && index < endIndex else {
      return nil
    }

    return self[index]
  }

  func random() -> Element? {
    // swiftlint:disable empty_count
    guard count > 0 else {
      return nil
    }

    return self[Int.random(in: 0..<count)]
  }
}
