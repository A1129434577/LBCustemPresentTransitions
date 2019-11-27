Pod::Spec.new do |spec|
  spec.name         = "LBPresentTransitions"
  spec.version      = "1.1.3"
  spec.summary      = "自定义Present转场效果"
  spec.description  = "自定义Present转场效果，可以从上、左、下、右、中五个位置Present，是抽屉式弹出View和中间弹窗alertView样式的首选。"
  spec.homepage     = "https://github.com/A1129434577/LBCustemPresentTransitions"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBCustemPresentTransitions.git', :tag => spec.version.to_s }
  spec.source_files = "LBPresentTransitions/**/*.{h,m}"
  spec.requires_arc = true
end
