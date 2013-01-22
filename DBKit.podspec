Pod::Spec.new do |s|
  s.name         = "DBKit"
  s.version      = "0.2.2"
  s.summary      = "A collection of code I use across all of my apps."
  s.homepage     = "https://github.com/DavidBarry/DBKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "David Barry" => "david@softdiesel.com" }
  s.source       = { :git => "https://github.com/DavidBarry/DBKit.git", :tag => "0.2.2"}
  s.platform     = :ios, '5.0'
  s.source_files = '{DBKit,DBCoreData}/*.{h,m}'
  s.resources = "DBKitResources/**/*.{png,xib}"
  s.frameworks = 'QuartzCore', 'CoreGraphics', 'CoreData'
  s.prefix_header_contents = "#import \"DBMacros.h\""
  s.requires_arc = true
end
