//
//  ZLPhotoSelectedAsset.swift
//  ZLPhotoBrowser
//
//  Created by Andrei Pachtarou on 2023-04-19.
//

import UIKit
import Photos

public enum ZLPhotoSelectedAsset {
    case raw(asset: PHAsset)
    case edited(asset: PHAsset, editModel: ZLEditImageModel?, image: UIImage)
    case result(model: ZLResultModel)
    
    var asset: PHAsset {
        switch self {
        case let .raw(asset), let .edited(asset, _, _): return asset
        case let .result(model): return model.asset
        }
    }
}

extension ZLPhotoSelectedAsset: Equatable {
    public static func ==(lhs: ZLPhotoSelectedAsset, rhs: ZLPhotoSelectedAsset) -> Bool {
        return lhs.asset == rhs.asset
    }
}
