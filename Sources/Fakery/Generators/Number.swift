import Foundation

public final class Number {
  fileprivate var lastUsedId: Int64 = 0

  public func randomBool() -> Bool {
    return randomInt() % 2 == 0
  }

  public func randomInt(min: Int = 0, max: Int = 1000) -> Int {
    return Int.random(in: min...max)
  }

  public func randomFloat(min: Float = 0, max: Float = 1000) -> Float {
    return Float.random(in: min...max)
  }

  public func randomDouble(min: Double = 0, max: Double = 1000) -> Double {
    return Double.random(in: min...max)
  }

  // (todo): Fix this implementation so that it works in Linux
//  public func increasingUniqueId() -> Int {
//    OSAtomicIncrement64(&lastUsedId)
//    return Int(lastUsedId)
//  }
}
