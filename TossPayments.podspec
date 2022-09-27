Pod::Spec.new do |spec|
  spec.name         = "TossPayments"
  spec.version      = "0.0.1"
  spec.summary      = "이 레포지토리는 토스페이먼츠 iOS SDK를 위한 모노레포입니다."
  spec.description  = <<-DESC
  자세한 사용 방법은 [토스페이먼츠 개발 연동 가이드](https://docs.tosspayments.com/reference/ios-sdk)를 참고해주세요.  
                   DESC
  spec.homepage     = "https://tosspayments.com"
  spec.license      = "MIT"
  spec.author             = { "김진규" => "mqz@toss.im" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/tosspayments/payment-sdk-ios.git", :tag => "#{spec.version}" }

  spec.swift_version = '5.0'
  spec.source_files  = 'Sources/**/*.swift', 'Sources/**/*.{h,m}'
end
