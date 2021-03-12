
Pod::Spec.new do |s|
  s.name             = 'LZAddressPicker'
  s.version          = '0.1.1'
  s.summary          = 'LZAddressPicker.'
  s.description      = <<-DESC
  地址选择器:
  1.支持外观配置
  DESC
  s.homepage         = 'https://github.com/liLeiBest/LZAddressPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lilei' => 'lilei_hapy@163.com' }
  s.source           = { :git => 'https://github.com/liLeiBest/LZAddressPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/liLeiBest'

  s.ios.deployment_target = '9.0'
  s.frameworks                 = 'UIKit', 'Foundation'
  s.source_files = 'LZAddressPicker/Classes/**/*'
  
  s.ios.deployment_target   = '9.0'
  s.frameworks              = 'Foundation','UIKit'
  s.source_files            = 'LZAddressPicker/Classes/**/*'
  s.public_header_files     = 'LZAddressPicker/Classes/**/*.h'
  s.source_files            =
  'LZAddressPicker/Classes/**/*.{h,m}',
#  'LZAddressPicker/Classes/Core/**/*.storyboard',
  ''
  s.resource_bundles        = {
      'LZAddressPickerResourceBundle' => ['LZAddressPicker/Classes/Resources/*']
  }
  
  s.dependency 'LZDependencyToolkit'
  
  pch_AF = <<-EOS
  
  static NSString * const LZAddressPickerBundle = @"LZAddressPickerResourceBundle";
  
  #import <LZAddressPicker/LZAddressPickerConfigurationModel.h>
  #import <LZAddressPicker/LZAddressPickerModelDelegate.h>
  #import <LZDependencyToolkit/LZDependencyToolkit.h>
  
  EOS
  s.prefix_header_contents = pch_AF
  
end
