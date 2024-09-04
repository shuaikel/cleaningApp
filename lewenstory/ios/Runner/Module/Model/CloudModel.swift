//
//  CloudModel.swift
//  Runner
//
//  Created by shuaike on 2024/9/4.
//

import Foundation
import Photos

struct CloudLocalAlbumConfigModel {
    var assetCollection: PHAssetCollection?
    var list: [CloudUploadAlbumModel]?
}

struct CloudUploadAlbumModel {
    var asset: PHAsset?
    var assetData: Data?
    var assetThumbnailData: Data?
}
