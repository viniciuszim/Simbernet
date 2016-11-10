Pod::Spec.new do |s|
  s.name             = "Simbernet"
  s.version          = "1.0.0"
  s.summary          = "The open source fonts for Artsy apps + UIFont categories."
  s.homepage         = "https://github.com/viniciuszim/Simbernet"
  s.license          = 'Code is MIT, then custom font licenses.'
  s.author           = { "Orta" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/viniciuszim/Simbernet.git", :tag => s.version }
  s.source_files     = 'Simbernet/Simbernet/*/.{h,m}'
end