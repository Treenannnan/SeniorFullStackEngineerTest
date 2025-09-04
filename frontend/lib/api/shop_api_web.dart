import 'package:grpc/grpc_web.dart' as grpc_web;
import '../proto/shop/v1/shop.pbgrpc.dart' as shop;
import '../proto/google/protobuf/empty.pb.dart' as $empty;
import 'package:fixnum/fixnum.dart';

class ShopApi {
  ShopApi(this._host, this._port, {String? accessToken, bool? useGrpcWeb}) {
    _accessToken = accessToken;
    _open();
  }

  final String _host;
  final int _port;
  String? _accessToken;

  set accessToken(String? t) => _accessToken = t;

  late final grpc_web.GrpcWebClientChannel _ch;
  late final shop.ShopServiceClient _client;

  void _open() {
    _ch = grpc_web.GrpcWebClientChannel.xhr(Uri.parse('http://$_host:$_port'));
    _client = shop.ShopServiceClient(_ch);
  }

  // grpc-web ไม่มี shutdown
  Future<void> close() async {}

  Map<String, String>? _md() {
    final tok = _accessToken;
    if (tok == null || tok.isEmpty) return null;
    return {'authorization': 'Bearer $tok'};
  }

  // ====== APIs ======
  Future<shop.ListAudiobooksResponse> listAudiobooks(
          {int pageSize = 50,
          String pageToken = "",
          String query = "",
          String category = ""}) =>
      _client.listAudiobooks(
        shop.ListAudiobooksRequest(
            pageSize: pageSize,
            pageToken: pageToken,
            query: query,
            category: category),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<void> addToCart(String audiobookId) => _client
      .addToCart(
        shop.AddToCartRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      )
      .then((_) {});

  Future<shop.ViewCartResponse> viewCart() => _client.viewCart($empty.Empty(),
      options: grpc_web.CallOptions(metadata: _md()));

  Future<shop.CheckoutResponse> checkout() => _client.checkout($empty.Empty(),
      options: grpc_web.CallOptions(metadata: _md()));

  Future<shop.ListPurchasesResponse> listPurchases() =>
      _client.listPurchases($empty.Empty(),
          options: grpc_web.CallOptions(metadata: _md()));

  Future<shop.GetDownloadURLResponse> getDownloadURL(String audiobookId) =>
      _client.getDownloadURL(
        shop.GetDownloadURLRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<shop.GetTranscriptResponse> getTranscript(String audiobookId) =>
      _client.getTranscript(
        shop.GetTranscriptRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<shop.CreateUploadUrlResponse> getUploadURLForExisting(
          String audiobookId) =>
      _client.getUploadURL(
        shop.GetUploadURLRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<shop.CreateUploadUrlResponse> createUploadURL({
    required String title,
    required String author,
    required int priceCents,
    required String filename,
    required String contentType,
  }) =>
      _client.createUploadURL(
        shop.CreateUploadUrlRequest(
          title: title,
          author: author,
          priceCents: Int64(priceCents),
          filename: filename,
          contentType: contentType,
        ),
        options: grpc_web.CallOptions(metadata: _md()),
      );
  Future<shop.GetAudiobookStatusResponse> getAudiobookStatus(
          String audiobookId) =>
      _client.getAudiobookStatus(
        shop.GetAudiobookStatusRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<shop.CompleteUploadResponse> completeUpload(String audiobookId) =>
      _client.completeUpload(
        shop.CompleteUploadRequest(audiobookId: audiobookId),
        options: grpc_web.CallOptions(metadata: _md()),
      );

  Future<void> removeFromCart(String audiobookId, {int quantity = 1}) async {
    await _client.removeFromCart(
      shop.RemoveFromCartRequest(audiobookId: audiobookId),
      options: grpc_web.CallOptions(metadata: _md()),
    );
  }
}
