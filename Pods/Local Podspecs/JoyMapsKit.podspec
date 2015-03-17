Pod::Spec.new do |s|
  s.name         = 'JoyMapsKit'
  s.version      = '0.1.6'

  s.homepage     = 'http://gitlab.alibaba-inc.com/jiandong.ljd/joymapskit'
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE.txt' }
  s.author       = { 'jiandong.ljd' => 'jiandong.ljd@alibaba-inc.com' }

  s.summary      = 'iOS开发中常用的工具类，自定义UI组件，扩展类别'
  s.description  = 'JoyMapsKit包含了日常开发整理的工具类和部分自定义UI组件，支持ARC，' \
                   '同时暂无帮助文档，后期需要完善文档部分的工作。目前只要包含常用Foundation类的扩展，' \
                   '实现基于URL导航的简单版本。' 
  s.platform     = :ios
  s.ios.deployment_target = '5.0'
  s.requires_arc = true  

  s.source       = { :git => 'git@gitlab.alibaba-inc.com:jiandong.ljd/joymapskit.git'}
  s.source_files = 'JoyMapsKit/Classes/**/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
  s.prefix_header_contents = '#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>'
  
  s.subspec 'Core' do |core|
    core.source_files = 'JoyMapsCore/Classes/**/*{h,m}'
    core.requires_arc = true
  end

  s.subspec 'Navigator' do |navigator|
    navigator.source_files = 'JoyMapsNavigator/Classes/**/*{h,m}'
    navigator.requires_arc = true
    navigator.dependency 'JoyMapsKit/Core'
    navigator.dependency 'SOCKit', '~> 1.1'

    navigator.prefix_header_contents = '#import <SOCKit/SOCKit.h>'
  end

  s.subspec 'Networking' do |networking|
    networking.source_files = 'JoyMapsNetworking/Classes/**/*{h,m}'

    networking. exclude_files = 'JoyMapsNetworking/Classes/Taobao/Auth/SSO/*'
    networking.requires_arc = true
    networking.dependency 'JoyMapsKit/Core'
	
    networking.dependency 'OpenSSL'
    networking.dependency 'Reachability'

    networking.dependency 'TBSecuritySDK'
    networking.dependency 'NetworkSDK'
    networking.dependency 'MtopSDK'
    networking.dependency 'aliSPDY'
    networking.dependency 'UserTrack'
    networking.dependency 'TBJSONModel'

    networking.prefix_header_file = 'JoyMapsNetworking/JoyMapsNetworking-Prefix.pch'
    networking.xcconfig = {'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/TBSecuritySDK/"'}
  end

  s.subspec 'Extension' do |extension|
    extension.source_files = 'JoyMapsExtension/JMExtensions.h'
    extension.requires_arc = true

    extension.subspec 'NimbusCore' do |nimbuscore|
      nimbuscore.source_files = 'JoyMapsExtension/Vendor/Nimbus/core/**/*{h,m}'
      nimbuscore.requires_arc = true
    end

    extension.subspec 'NimbusPagingScrollView' do |pagingscrollview|
      pagingscrollview.source_files = 'JoyMapsExtension/Vendor/Nimbus/pagingscrollview/**/*{h,m}'
      pagingscrollview.requires_arc = true
    end
  end

end
