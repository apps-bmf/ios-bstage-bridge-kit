import SwiftUI

import BstageBridgeKit
import MLKitCommon
import MLKitLanguageID
import MLKitTranslate

public struct ContentView: View {
    
    let mlkitModelDownloadDidSucceed = NotificationCenter
        .default
        .publisher(for: NSNotification.Name.mlkitModelDownloadDidSucceed)
    
    let mlkitModelDownloadDidFail = NotificationCenter
        .default
        .publisher(for: NSNotification.Name.mlkitModelDownloadDidFail)
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            
            Button("Translate") {
                Task {
                    await translateText()
                }
            }
            .padding()

            Button("Detect Language") {
                Task {
                    await detectLanguage()
                }
            }
            .padding()
        }
        .onAppear {
            checkResourceBundles()
        }
        .onReceive(mlkitModelDownloadDidSucceed) { notification in
            print("mlkitModelDownloadDidSucceed >>> ", notification)
        }
        .onReceive(mlkitModelDownloadDidFail) { notification in
            print("mlkitModelDownloadDidFail >>> ", notification)
        }
    }
    
    
    private func translateText() async {
        // Note: Some language pairs may not be available in MLKit Translate
        // If Korean doesn't work, you may need to check supported language pairs
        let targetLanguage = TranslateLanguage.french
        let sourceLanguage = TranslateLanguage.english
        
        let options = TranslatorOptions(
            sourceLanguage: sourceLanguage,
            targetLanguage: targetLanguage
        )
        
        let translator = MLKitTranslate.Translator.translator(options: options)
        
        // Check if model is downloaded first
        let modelManager = ModelManager.modelManager()
        
        // Create model for target language
        // Note: MLKit Translate requires both source and target languages to be set in TranslatorOptions
        // The model download uses the target language, but internally pairs with source
        let model = TranslateRemoteModel.translateRemoteModel(language: targetLanguage)
        
        if modelManager.isModelDownloaded(model) {
            print("Model already downloaded >>> ")
            do {
                let message = try await translator.translate("Hello, World!")
                print("Translation result >>> \(message)")
            } catch {
                print("Translation error >>> \(error.localizedDescription)")
            }
        } else {
            try? await modelManager.deleteDownloadedModel(model)
            
            let conditions = ModelDownloadConditions(
                allowsCellularAccess: true,
                allowsBackgroundDownloading: true
            )
            
            // Start download - completion will be handled via notification
            print("Start download >>> ", model, conditions)
            modelManager.download(model, conditions: conditions)
        }
    }
    
    private func checkResourceBundles() {
        print("\n=== MLKit 리소스 번들 디버깅 ===\n")
        
        // 1. 메인 번들에서 리소스 번들 찾기
        print("1. 메인 번들에서 리소스 번들 찾기:")
        if let bundlePath = Bundle.main.path(forResource: "MLKitTranslate_resource", ofType: "bundle") {
            print("   ✅ 찾음: \(bundlePath)")
            
            // profiles_r29.json 확인
            if let profilesPath = Bundle(path: bundlePath)?.path(forResource: "profiles_r29", ofType: "json") {
                print("   ✅ profiles_r29.json 찾음: \(profilesPath)")
            } else {
                print("   ❌ profiles_r29.json 못 찾음")
            }
        } else {
            print("   ❌ MLKitTranslate_resource.bundle 못 찾음")
        }
        
        // 2. 프레임워크 번들에서 찾기
        print("\n2. 프레임워크 번들에서 찾기:")
        if let frameworkBundle = Bundle(identifier: "com.google.firebase.mlkit.translate") {
            print("   ✅ MLKitTranslate 프레임워크 번들 찾음")
            print("   번들 경로: \(frameworkBundle.bundlePath)")
            
            if let resourcePath = frameworkBundle.path(forResource: "MLKitTranslate_resource", ofType: "bundle") {
                print("   ✅ 리소스 번들 찾음: \(resourcePath)")
                
                if let resourceBundle = Bundle(path: resourcePath) {
                    if let profilesPath = resourceBundle.path(forResource: "profiles_r29", ofType: "json") {
                        print("   ✅ profiles_r29.json 찾음: \(profilesPath)")
                        
                        // 파일 내용 일부 읽기
                        if let data = try? Data(contentsOf: URL(fileURLWithPath: profilesPath)),
                           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            print("   ✅ JSON 파싱 성공")
                            if let enKo = json["en_ko"] as? [String: Any] {
                                print("   ✅ en_ko 모델 프로필 존재")
                            } else {
                                print("   ❌ en_ko 모델 프로필 없음")
                            }
                        }
                    } else {
                        print("   ❌ profiles_r29.json 못 찾음")
                    }
                }
            } else {
                print("   ❌ 리소스 번들 못 찾음")
            }
        } else {
            print("   ❌ MLKitTranslate 프레임워크 번들 못 찾음")
        }
        
        // 3. 모든 번들 검색
        print("\n3. 모든 로드된 번들 검색:")
        var foundBundles: [String] = []
        for bundle in Bundle.allBundles {
            if bundle.bundlePath.contains("MLKit") || bundle.bundlePath.contains("mlkit") {
                print("   발견: \(bundle.bundleIdentifier ?? "unknown") - \(bundle.bundlePath)")
                foundBundles.append(bundle.bundlePath)
            }
        }
        
        if foundBundles.isEmpty {
            print("   ❌ MLKit 관련 번들 없음")
        }
        
        // 4. xcframework 경로에서 직접 확인
        print("\n4. xcframework 경로 확인:")
        let possiblePaths = [
            Bundle.main.bundlePath + "/Frameworks/MLKitTranslate.framework",
            Bundle.main.bundlePath + "/Frameworks/MLKitTranslate.xcframework",
        ]
        
        for path in possiblePaths {
            if FileManager.default.fileExists(atPath: path) {
                print("   ✅ 경로 존재: \(path)")
                
                let resourceBundlePath = path + "/MLKitTranslate_resource.bundle"
                if FileManager.default.fileExists(atPath: resourceBundlePath) {
                    print("   ✅ 리소스 번들 존재: \(resourceBundlePath)")
                } else {
                    print("   ❌ 리소스 번들 없음: \(resourceBundlePath)")
                }
            }
        }
        
        // 5. 앱 번들 내부 구조 확인
        print("\n5. 앱 번들 내부 구조:")
        let appBundlePath = Bundle.main.bundlePath
        print("   앱 번들 경로: \(appBundlePath)")
        
        if let frameworksContents = try? FileManager.default.contentsOfDirectory(atPath: appBundlePath + "/Frameworks") {
            print("   Frameworks 폴더 내용:")
            for item in frameworksContents {
                print("     - \(item)")
            }
        } else {
            print("   ❌ Frameworks 폴더 없음 또는 접근 불가")
        }
        
        print("\n=== 디버깅 완료 ===\n")
    }
    
    private func detectLanguage() async {
        // Test sentences in different languages
        let testSentences = [
            "Hello, World!",
            "안녕하세요",
            "Bonjour le monde",
            "Hola mundo",
            "こんにちは世界"
        ]
        
        // Create Language Identification instance
        let languageIdentifier = LanguageIdentification.languageIdentification()
        
        for sentence in testSentences {
            do {
                // Identify language with confidence threshold
                let identifiedLanguage = try await languageIdentifier.identifyLanguage(for: sentence)
                print("Sentence: '\(sentence)'")
                print("Detected language: \(identifiedLanguage)")
                print("---")
            } catch {
                print("Error detecting language for '\(sentence)': \(error.localizedDescription)")
            }
        }
        
        // You can also identify multiple possible languages with confidence scores
        print("\n--- Identifying multiple languages with confidence ---")
        let testText = "Hello, how are you? 안녕하세요"
        do {
            let possibleLanguages = try await languageIdentifier.identifyPossibleLanguages(for: testText)
            print("Text: '\(testText)'")
            for language in possibleLanguages {
                print("Language: \(language), Confidence: \(language.confidence)")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
