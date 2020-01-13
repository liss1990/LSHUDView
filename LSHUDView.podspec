
Pod::Spec.new do |spec|

  spec.name         = "LSHUDView"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of LSHUDView."

  spec.homepage     = "https://github.com/liss1990/LSHUDView"

  spec.author             = { "lisisi" => "nilongls@126.com" }
 

  # spec.platform     = :ios
  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/liss1990/LSHUDView.git", :tag => "0.0.1" }


  spec.source_files  = "LSHUDView/*.{h,m}"
  spec.requires_arc = true
  spec.dependency 'Masonry'
  spec.dependency 'DGActivityIndicatorView' 
end
