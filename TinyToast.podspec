Pod::Spec.new do |s|
  s.name = "TinyToast"
  s.version = "1.5.0"
  s.summary = "TinyToast is simple toast library in Swift."
  s.homepage = "https://github.com/keygx/TinyToast"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "keygx" => "y.kagiyama@gmail.com" }
  s.social_media_url = "http://twitter.com/keygx"
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source = { :git => "https://github.com/keygx/TinyToast.git", :tag => "#{s.version}" }
  s.source_files = "TinyToast/**/*"
  s.requires_arc = true
end
