Pod::Spec.new do |s|
    s.name = 'MaterialX'
    s.version = '0.0.2'
    s.license = 'BSD-3-Clause'
    s.summary = 'A unidirectional data flow for iOS & macOS.'
    s.homepage = 'http://graphswift.io'
    s.social_media_url = 'https://www.facebook.com/cosmicmindcom'
    s.authors = { 'CosmicMind, Inc.' => 'support@cosmicmind.com' }
    s.source = { :git => 'https://github.com/CosmicMind/MaterialX.git', :tag => s.version }
    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'
    s.source_files = 'Sources/*.swift'
    s.requires_arc = true
end
