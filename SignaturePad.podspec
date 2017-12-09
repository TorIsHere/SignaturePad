#
#  Be sure to run `pod spec lint SwiftSignature.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SignaturePad"
  s.version      = "1.1.0"
  s.summary      = "A smooth signature pad with uibezierpath"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                    A Smooth Signature Pad written in Swift. Utilizing UIBezierPath.
                   DESC

  s.homepage     = "https://github.com/TorIsHere/SignaturePad"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "TorIsHere" => "kittikorn.a@gmail.com" }
  s.source       = { :git => "https://github.com/TorIsHere/SignaturePad.git", :tag => "#{s.version}" }
  s.source_files  = "SignaturePad", "SignaturePad/**/*.{h,m}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.ios.deployment_target  = '9.0'

end
