
Pod::Spec.new do |s|

  s.name         = "KTCommonKit"
  s.version      = "0.0.1"
  s.summary      = "A public library."
  s.description  = <<-DESC
			A public library for iOS.
                   DESC
  s.homepage     = "https://github.com/KetilDeng/KTCommonKit"
  s.license      = "MIT"
  s.author             = { "KerryDeng" => "dkts47@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/KetilDeng/KTCommonKit.git", :tag => "#{s.version}" }
  s.source_files  = "Common/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true

end
