
Pod::Spec.new do |spec|

  spec.name         = "CollectionConcurrencyKit"
  spec.version      = "0.2.0"
  spec.summary      = "asynchronous and concurrent versions of the standard map, flatMap, compactMap, and forEach APIs"
  spec.license      = "MIT License"

  spec.homepage     = "https://github.com/JohnSundell/CollectionConcurrencyKit"
  spec.author       = { "John Sundell" => "https://twitter.com/johnsundell" }

  spec.source       = { :git => "https://github.com/JohnSundell/CollectionConcurrencyKit.git", :tag => '0.2.0' }
  spec.source_files = "Sources/CollectionConcurrencyKit.swift"

  spec.ios.deployment_target   = "13.0"

end
