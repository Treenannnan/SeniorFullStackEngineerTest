// เลือกไฟล์ตามแพลตฟอร์มอัตโนมัติ
import 'shop_api_io.dart' if (dart.library.html) 'shop_api_web.dart' as impl;

// re-export ให้ import ที่ไฟล์นี้ได้คลาส ShopApi ตรง ๆ
export 'shop_api_io.dart' if (dart.library.html) 'shop_api_web.dart';

// factory เผื่ออยากเรียกแบบ create*
impl.ShopApi createShopApi(String host, int port,
        {String? accessToken, bool? useGrpcWeb}) =>
    impl.ShopApi(host, port, accessToken: accessToken, useGrpcWeb: useGrpcWeb);
