Pod::Spec.new do |s|
  s.name = 'Pesamoni'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.version = '0.0.1'
  s.source = https://pesamoni.com/about%20us
  s.authors = 'Pesamoni'
  s.docset_url = 'https://pesamoni.com'
  s.license = Apache 2.0
  s.homepage = 'https://github.com/Pesamoni/pesamoni_swift'
  s.summary = 'Automate mobile money payments, bank transfers and more..'
  s.description = 'Automate mobile money payments, bank transfers and more..'
  s.documentation_url = 'https://github.com/Pesamoni/pesamoni_swift'
  s.source_files = 'Pesamoni/Classes/**/*.swift'
  s.dependency 'Alamofire', '~> 3.5.1'
end
