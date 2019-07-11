Pod::Spec.new do |s|
  s.name         = "UEIoTBLEKit"
  s.version      = "0.0.1"
  s.summary      = "A kit allow you control Urbane's scooters by BLE."
  s.homepage     = "https://github.com/janlionly/Urbane_IoTBLE_iOS_SDK"
  s.license      = { :type => "MIT"}
  s.author             = { "janlionly" => "812167414@qq.com" }
  s.source       = { :http => "https://github.com/janlionly/Urbane_IoTBLE_iOS_SDK/raw/master/UEIoTBLEKit.framework.zip", :tag => s.version }
  s.source_files  = "Urbane_IoTBLE_iOS_SDK/Urbane_IoTBLE_iOS_SDK/UEIoTBLEKit.framework.zip"
  s.requires_arc = true
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.vendored_frameworks ='UEIoTBLEKit.framework'
  s.static_framework = true
end
