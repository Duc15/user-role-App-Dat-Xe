import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GMSPlacesClient.provideAPIKey("AIzaSyDk4fssOnC_UtZ2bGu8LzWAPw3HT39-22M")
    GMSServices.provideAPIKey("AIzaSyDk4fssOnC_UtZ2bGu8LzWAPw3HT39-22M")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
