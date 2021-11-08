import UIKit

// MARK: - App Root Window
extension UIApplication {
    static var appRootWindow: UIWindow? {
        guard
            let windowScene: UIWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate: SceneDelegate = windowScene.delegate as? SceneDelegate,
            let window: UIWindow = sceneDelegate.window
        else {
            return nil
        }
        
        return window
    }
    
    static var appRootViewController: UIViewController? {
        appRootWindow?.rootViewController
    }
    
    static var appRootView: UIView? {
        appRootViewController?.view
    }
}
