import Foundation

public final class Provider {
  var translations: [String: Data] = [:]

  // MARK: - Locale data

  public func dataForLocale(_ locale: String) -> Data? {
    var translation: Data?

    if let translationData = translations[locale] {
      translation = translationData
    } else {


      if let path = path(for: locale) {
        let fileURL = URL(fileURLWithPath: path)

        if let data = try? Data(contentsOf: fileURL) {
          translation = data
          translations[locale] = data
        }
      }
    }

    return translation
  }
  
  private func path(for locale: String) -> String? {
    if !Config.dirResourcePath.isEmpty {
      return "\(Config.dirResourcePath)/\(locale).\(Config.pathExtension)"
    }

    let bundle = Bundle(for: Provider.self)
    
    var path = bundle.path(forResource: locale,
                           ofType: Config.pathExtension,
                           inDirectory: Config.dirPath) ??
      bundle.path(forResource: locale,
                  ofType: Config.pathExtension,
                  inDirectory: Config.dirFrameworkPath)
    
    if let resourcePath = Bundle(for: Provider.self).resourcePath {
      let bundlePath = resourcePath + "/Faker.bundle"
      
      if let bundle = Bundle(path: bundlePath) {
        path = bundle.path(forResource: locale, ofType: Config.pathExtension)
      }
    }
    
    return path
  }

}
