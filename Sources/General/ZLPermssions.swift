import Foundation
import Photos

public
final class ZLPermssions {
    public static func photoLibrary (_ callback: @escaping (ZLPermssions.PermssionsValue) -> Void) {
        let zlPermssion = PHPhotoLibrary.authorizationStatus().zlPermssion
        guard zlPermssion == .notDetermined else {
            ZLMainAsync { callback(zlPermssion) }
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            ZLMainAsync { callback(status.zlPermssion) }
        }
    }
    
    public static func camera (_ callback: @escaping (ZLPermssions.PermssionsValue) -> Void) {
        let zlPermssion = AVCaptureDevice.authorizationStatus(for: .video).zlPermssion
        guard zlPermssion == .notDetermined else {
            ZLMainAsync { callback(zlPermssion) }
            return
        }
        AVCaptureDevice.requestAccess(for: .video) { videoGranted in
            ZLMainAsync { callback(videoGranted ? .allowed : .denied) }
        }
    }

    public static func audio (_ callback: @escaping (ZLPermssions.PermssionsValue) -> Void) {
        let zlPermssion = AVCaptureDevice.authorizationStatus(for: .audio).zlPermssion
        guard zlPermssion == .notDetermined else {
            ZLMainAsync { callback(zlPermssion) }
            return
        }
        AVCaptureDevice.requestAccess(for: .audio) { videoGranted in
            ZLMainAsync { callback(videoGranted ? .allowed : .denied) }
        }
    }
}

public extension ZLPermssions {
    enum PermssionsValue {
        case allowed
        case allowedWithLimitations
        case restricted
        case denied
        case notDetermined

        public var isAllowed: Bool {
            switch self {
            case .allowed, .allowedWithLimitations: return true
            case .notDetermined, .restricted, .denied: return false
            }
        }
    }
}

public extension PHAuthorizationStatus {
    var zlPermssion: ZLPermssions.PermssionsValue {
        switch self {
        case .notDetermined: return .notDetermined
        case .authorized: return .allowed
        case .limited: return .allowedWithLimitations
        case .restricted: return .restricted
        case .denied: return .denied
        @unknown default:
            return .notDetermined            
        }
    }
}

public extension AVAuthorizationStatus {
    var zlPermssion: ZLPermssions.PermssionsValue {
        switch self {
        case .notDetermined: return .notDetermined
        case .authorized: return .allowed
        case .restricted: return .restricted
        case .denied: return .denied
        @unknown default:
            return .notDetermined
        }
    }
}
