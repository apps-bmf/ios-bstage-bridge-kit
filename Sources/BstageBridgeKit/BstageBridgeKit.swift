// BstageBridgeKit
// 이 패키지는 MLKit Translate와 필요한 리소스 번들을 포함합니다.
// 다른 프로젝트에서 이 패키지만 추가하면 MLKit Translate를 사용할 수 있습니다.

import Foundation
import MLKitCommon
import MLKitLanguageID
import MLKitTranslate

// 리소스 번들이 제대로 로드되는지 확인하는 유틸리티
public struct BstageBridgeKit {
    public static func verifyResourceBundle() -> Bool {
        // 리소스 번들이 메인 번들에서 찾을 수 있는지 확인
        if let bundlePath = Bundle.main.path(forResource: "MLKitTranslate_resource", ofType: "bundle") {
            return FileManager.default.fileExists(atPath: bundlePath)
        }
        
        // 모듈 번들에서도 확인
        if let moduleBundle = Bundle(for: BstageBridgeKit.self),
           let bundlePath = moduleBundle.path(forResource: "MLKitTranslate_resource", ofType: "bundle") {
            return FileManager.default.fileExists(atPath: bundlePath)
        }
        
        return false
    }
}

