Pod::Spec.new do |s|
  s.name     = 'xiaosan'
  s.version  = '0.1.2'
  s.summary  = 'xiaosan.'
  s.homepage = 'http://gitlab.alibaba-inc.com/duanshuai.fzh/xiaosan'
  s.license      = { :type => 'juhusuan.com', }
  s.author   = { '断帅' => 'duanshuai.fzh@taobao.com',
                 '射天' => 'chunyi.zhoucy@taobao.com',
                 '子循' => 'paiqiu.cyl@alibaba-inc.com',
                 '彦昊' => 'jiandong.ljd@alibaba-inc.com' }

  s.source   = { :git => 'git@gitlab.alibaba-inc.com:duanshuai.fzh/xiaosan.git' }

  s.description = <<-DESC
                   xiaosan description
                   DESC

  s.platform = :ios, '5.0'
  s.requires_arc = false

  s.subspec 'Common' do |common|
    common.source_files = 'xiaosan/xiaosan.h', 'xiaosan/xiaosan-def.h'
    common.prefix_header_file = 'xiaosan/xiaosan-Prefix.pch'
	common.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
  	common.xcconfig = {'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/UserTrack/"'}
  end
							
  s.subspec 'Utility' do |utility|
    utility.source_files = 'xiaosan/util/**/*.{h,m}', 'xiaosan/DataSignal/**/*.{h,m}'
    utility.frameworks = 'Foundation'

    utility.dependency 'xiaosan/Common'
	utility.dependency 'CocoaLumberjack'
	utility.dependency 'JoyMapsKit'
  end

 # s.subspec 'BaseLine' do |baseline|
 #	baseline.source_files = 'xiaosan/BaseLine/*.{h,m}'
 #	baseline.frameworks = 'Foundation'

 #	baseline.dependency 'xiaosan/Common'
 #	baseline.dependency 'UserTrack'
 # end

  s.subspec 'Summer' do |summer|
	summer.source_files = 'xiaosan/Summer/*.{h,m}'
	summer.frameworks = 'Foundation'
	
	summer.dependency 'xiaosan/Common'
  end

  s.subspec 'FMDB' do |fmdb|
	fmdb.requires_arc = false
	fmdb.source_files = 'xiaosan/FMDB/*.{h,m}'
	fmdb.framework = 'Foundation'
	fmdb.library = 'sqlite3'
	
	fmdb.dependency 'xiaosan/Common'
  end

  s.subspec 'MBProgressHUD' do |hud|
    hud.requires_arc = false
    hud.source_files = 'xiaosan/MBProgressHUD/**/*.{h,m}'
	hud.resource = 'Resources/Xibs/*.xib'
	
	hud.dependency 'xiaosan/Common'
    hud.dependency 'xiaosan/Utility'
  end

  s.subspec 'EGOImageCache' do |egocache|
    egocache.source_files = 'xiaosan/EGOImageLoading/**/*.{h,m}'
    egocache.frameworks = 'ImageIO', 'QuartzCore'

	egocache.dependency 'xiaosan/Common'
    egocache.dependency 'xiaosan/Utility'
    egocache.dependency 'DDProgressView'
  end	

end
