//
//  SwiftFlutterIosChannelPlugin.swift
//  Runner
//
//  Created by shuaike on 2024/9/4.
//

import UIKit
import Flutter

enum SKFlutterIosChannelPluginMethodName: String {
    case cloud_import_local_album
}


public class SwiftFlutterIosChannelPlugin: NSObject, FlutterPlugin {

    static let channel_name = "com.sk.cleaner.flutter_ios_channel"

    
    public static func addManuallyToRegistry(registry: FlutterPluginRegistry) {
    // https://api.flutter.dev/objcdoc/Protocols/FlutterPluginRegistry.html#/c:objc(pl)FlutterPluginRegistry(im)registrarForPlugin:
            let registrar = registry.registrar(forPlugin: channel_name)
            if let safeRegistrar = registrar {
                register(with: safeRegistrar)
            }
        }
    
    public static func register(with registerar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channel_name, binaryMessenger: registerar.messenger())
        let instance = SwiftFlutterIosChannelPlugin()
        registerar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "clean_user_select_from_album" {
            debugPrint("flutter 插件调用选择照片")
            result(["albumlist":"123"]);
            return
        }
        
        if call.method == SKFlutterIosChannelPluginMethodName.cloud_import_local_album.rawValue {
            // 导入本地相册
        CloudService.loadLocalAlbumGroup { list in
            let resultList = list.compactMap { model in
                return ["albumName": model.assetCollection?.localizedTitle,
                        "assetCover":model.list?.first?.assetData?.base64EncodedString(),
                        "assetAlbumCount":model.list?.filter({ $0.asset?.mediaType == .image}).count ?? 0,
                        "assetVideoCount": model.list?.filter({ $0.asset?.mediaType == .video}).count ?? 0]
                }
                result(["list":resultList]);
            }
            return
        }
        
        result(FlutterMethodNotImplemented)
    }
}
