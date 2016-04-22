Pod::Spec.new do |s|
  s.name         = 'maskCircle'
  s.version      = '1.0'
  s.summary      = 'image mask Circle Progress Bar'
  s.homepage     = 'https://github.com/silpmomo/MaskCircleView'
  s.license      = 'MIT'
  s.author       = { 'silpmomo' => 'silpmomo@divecat.me' }
  s.source       = { :git => 'https://github.com/silpmomo/MaskCircleView.git', :tag => s.version }

  s.source_files  = 'maskCircle/MaskCircleView/*.{h,m}'
  s.requires_arc = false
  s.ios.deployment_target = '8.0'
end

