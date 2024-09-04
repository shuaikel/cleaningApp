//
//  PhotoService.swift
//  Runner
//
//  Created by shuaike on 2024/9/4.
//

import UIKit
import Photos

class PhotoService: NSObject {
    
    static func requestImageBy(asset: PHAsset,targetSize: CGSize,isSync: Bool,callback :((UIImage?) -> Void)?) {
        var options = PHImageRequestOptions()
        options.isSynchronous = isSync
        
        if !isSync {
            options.isNetworkAccessAllowed = true
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, infoDict in
            var isSmall = infoDict?["PHImageResultIsDegradedKey"] as? Bool
            debugPrint("requestImageBy : \(infoDict)")
            if isSmall == false {
                callback?(image)
            }
        }
    }
}
