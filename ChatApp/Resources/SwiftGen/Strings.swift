// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Chat app
  internal static let chatApp = L10n.tr("Localizable", "chat_app")
  /// Log in
  internal static let logIn = L10n.tr("Localizable", "log_in")
  /// Log out
  internal static let logOut = L10n.tr("Localizable", "log_out")
  /// password
  internal static let password = L10n.tr("Localizable", "password")
  /// send
  internal static let send = L10n.tr("Localizable", "send")
  /// Sign up
  internal static let signUp = L10n.tr("Localizable", "sign_up")
  /// Start a new message
  internal static let startANewMessage = L10n.tr("Localizable", "start_a_new_message")
  /// By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. Others will be able to find you by searching for your email address or phone number when provided.
  internal static let terms = L10n.tr("Localizable", "terms")
  /// User name
  internal static let username = L10n.tr("Localizable", "username")
  /// Value is incorrect
  internal static let valueIsIncorrect = L10n.tr("Localizable", "value_is_incorrect")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
