import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var googleMapsKey = ""
    if let envPath = Bundle.main.path(forResource: ".env", ofType: nil) {
        if let envContent = try? String(contentsOfFile: envPath) {
            let lines = envContent.components(separatedBy: .newlines)
            for line in lines {
                if line.contains("GOOGLE_MAPS_API_KEY") {
                    googleMapsKey = line.components(separatedBy: "=").last?.trimmingCharacters(in: .whitespaces) ?? ""
                }
            }
        }
    }
    GMSServices.provideAPIKey(googleMapsKey)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
