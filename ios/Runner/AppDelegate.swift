import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController


  let usernameChannel = FlutterMethodChannel(name: "username",
                                                    binaryMessenger: controller.binaryMessenger)


      let batteryLevelChannel = FlutterMethodChannel(name: "batteryLevel", binaryMessenger: controller.binaryMessenger)




      batteryLevelChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in

        guard call.method == "getBatteryLevel" else{
          result(FlutterMethodNotImplemented)
          return
        }

        self?.getBatteryLevel(result: result)
      })
      usernameChannel.setMethodCallHandler({
          [weak self]  (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
          guard call.method == "getUserName" else{
              result(FlutterMethodNotImplemented)
                  return
          }
          self?.getUserName(result: result)

          })  
          

      GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


    private func getUserName(result: FlutterResult){
        result("ramkumarshukla00000@gmail.com")
    }

    
    private func getBatteryLevel(result: FlutterResult){
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true

        print("Battery Monitoring Enabled: \(device.isBatteryMonitoringEnabled)")
        print("Current Battery State: \(device.batteryState.rawValue)")
        print("Current Battery Level: \(device.batteryLevel)")

        if device.batteryState == .unknown || device.batteryLevel < 0 {
            // Logging the case when battery details can't be fetched
            print("Battery state is unknown, or battery level is invalid")
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery level not available.",
                                details: "Battery state is \(device.batteryState.rawValue), battery level is \(device.batteryLevel)"))
        } else {
            let batteryPercentage = Int(device.batteryLevel * 100)
            result(batteryPercentage)
        }
    }


}
