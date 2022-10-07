
Pod::Spec.new do |spec|

  spec.name         = "WebSockets"
  spec.version      = "0.5.0"
  spec.summary      = "An implementation of WebSockets (RFC 6455) for Swift 5.5 and above"
  spec.license      = "MIT License"

  spec.homepage     = "https://github.com/bhsw/concurrent-ws"
  spec.author       = { "Blue Hill Software" => "http://ocsoft.com" }

  spec.source       = { :git => "https://github.com/bhsw/concurrent-ws.git", :tag => 'v0.5.0' }
  spec.source_files = "Sources/WebSockets/*.swift"

  spec.ios.deployment_target   = "15.0"

end
