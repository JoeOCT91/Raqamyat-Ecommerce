// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add to Cart
  internal static let addToCart = L10n.tr("Localizable", "addToCart", fallback: "Add to Cart")
  /// All Reviews
  internal static let allReviews = L10n.tr("Localizable", "allReviews", fallback: "All Reviews")
  /// by: 
  internal static let by = L10n.tr("Localizable", "by", fallback: "by: ")
  /// DESCRIPTION
  internal static let description = L10n.tr("Localizable", "description", fallback: "DESCRIPTION")
  ///  EGP
  internal static let egyptianPound = L10n.tr("Localizable", "EgyptianPound", fallback: " EGP")
  /// Filter by
  internal static let filterBy = L10n.tr("Localizable", "filterBy", fallback: "Filter by")
  ///   off
  internal static let percentageOff = L10n.tr("Localizable", "percentageOff", fallback: "  off")
  /// 0 Result
  internal static let result = L10n.tr("Localizable", "result", fallback: "0 Result")
  /// REVIEWS
  internal static let reviews = L10n.tr("Localizable", "reviews", fallback: "REVIEWS")
  /// Select Color
  internal static let selectColor = L10n.tr("Localizable", "selectColor", fallback: "Select Color")
  /// Select your Size
  internal static let selectSize = L10n.tr("Localizable", "selectSize", fallback: "Select your Size")
  /// Size Guide
  internal static let sizeGuide = L10n.tr("Localizable", "sizeGuide", fallback: "Size Guide")
  /// Sort by
  internal static let sortBy = L10n.tr("Localizable", "sortBy", fallback: "Sort by")
  /// YOU MAY ALSO LIKE
  internal static let suggestedProductsHeaderTitle = L10n.tr("Localizable", "suggestedProductsHeaderTitle", fallback: "YOU MAY ALSO LIKE")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
