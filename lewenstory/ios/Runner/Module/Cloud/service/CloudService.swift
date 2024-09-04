//
//  CloudService.swift
//  Runner
//
//  Created by shuaike on 2024/9/4.
//

import UIKit
import Photos

class CloudService: NSObject {

}

extension CloudService {
    
    // 获取用户相册列表
    static func loadLocalAlbumGroup(_ completionBlock: (([CloudLocalAlbumConfigModel]) -> Void)?) {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let smartAlbums: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        var mlist: [CloudLocalAlbumConfigModel] = .init()
        let group = DispatchGroup()
        smartAlbums.enumerateObjects { (collection, _, stop) in
            group.enter()
            enumerateAssetsIn(assetCollection: collection, original: true) { configM in
                mlist.append(configM)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            debugPrint("mlist info: \(mlist)===\(mlist.count)")
            mlist.removeAll(where: { $0.list?.isEmpty ?? false })
            mlist.sort(by: { $0.assetCollection?.startDate?.compare($1.assetCollection?.startDate ?? Date()) == .orderedDescending })
            completionBlock?(mlist)
        }
    }
    
    // 遍历相册中的图片
    static func enumerateAssetsIn(assetCollection: PHAssetCollection,original: Bool,completionBlock:((CloudLocalAlbumConfigModel) -> Void)?) {
        debugPrint("相簿名称：\(assetCollection.localizedTitle)====\(assetCollection.startDate)===assetCollection:\(assetCollection)")
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.version = .current
        
        let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: assetCollection, options: nil)
        let group = DispatchGroup()
        var mlist: [CloudUploadAlbumModel] = .init()
        assets.enumerateObjects { (asset, index, stop) in
            group.enter()
            debugPrint("requestImageDataAndOrientation data:\(asset)===index:\(index)")
            PhotoService.requestImageBy(asset: asset, targetSize: PHImageManagerMaximumSize, isSync: false) { img in
                mlist.append(CloudUploadAlbumModel(asset: asset,assetData: img?.jpegData(compressionQuality: 1)))
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completionBlock?(CloudLocalAlbumConfigModel(assetCollection: assetCollection,list: mlist))
        }
    }
}
