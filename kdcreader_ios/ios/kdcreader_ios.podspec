#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint kdcreader_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'kdcreader_ios'
  s.version          = '2.0.2'
  s.summary          = 'Koamtac KDCReader SW Flutter plugin'
  s.description      = <<-DESC
Koamtac KDCReader SW Flutter plugin.
                       DESC
  s.homepage         = 'https://koamtac.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Koamtac' => 'support@koamtac.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*' , 'Library/**/*.h'
  s.public_header_files = 'Library/*.h'
  s.vendored_library = 'Library/Release-iphoneos/libKDCReader.a'
  s.ios.vendored_frameworks = 'Library/SwiftDecoder.xcframework' 
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
