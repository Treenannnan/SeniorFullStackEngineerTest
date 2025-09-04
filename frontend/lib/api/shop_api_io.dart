import 'package:frontend/proto/schema/v1/schema.pb.dart';
import 'package:grpc/grpc.dart' as grpc;
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

  grpc.ClientChannel? _ch;
  late final shop.ShopServiceClient _client;

  void _open() {
    _ch = grpc.ClientChannel(
      _host,
      port: _port,
      options: const grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      ),
    );
    _client = shop.ShopServiceClient(_ch!);
  }

  grpc.CallOptions _opts() {
    final tok = _accessToken;
    return grpc.CallOptions(
      metadata: (tok != null && tok.isNotEmpty)
          ? {'authorization': 'Bearer $tok'}
          : null,
    );
  }

  Future<void> close() async => _ch?.shutdown();

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
        options: _opts(),
      );

  Future<void> addToCart(String audiobookId, {int quantity = 1}) => _client
      .addToCart(
        shop.AddToCartRequest(audiobookId: audiobookId),
        options: _opts(),
      )
      .then((_) {});

  Future<shop.ViewCartResponse> viewCart() =>
      _client.viewCart($empty.Empty(), options: _opts());

  Future<shop.CheckoutResponse> checkout() =>
      _client.checkout($empty.Empty(), options: _opts());

  Future<shop.ListPurchasesResponse> listPurchases() =>
      _client.listPurchases($empty.Empty(), options: _opts());

  Future<shop.GetDownloadURLResponse> getDownloadURL(String audiobookId) =>
      _client.getDownloadURL(
        shop.GetDownloadURLRequest(audiobookId: audiobookId),
        options: _opts(),
      );

  Future<shop.GetTranscriptResponse> getTranscript(String audiobookId) =>
      _client.getTranscript(
        shop.GetTranscriptRequest(audiobookId: audiobookId),
        options: _opts(),
      );

  Future<shop.GetDescriptionResponse> getDescription(String audiobookId) =>
      _client.getDescription(
        shop.GetDescriptionRequest(audiobookId: audiobookId),
        options: _opts(),
      );

  Future<shop.CreateUploadUrlResponse> getUploadURLForExisting(
          String audiobookId) =>
      _client.getUploadURL(
        shop.GetUploadURLRequest(audiobookId: audiobookId),
        options: _opts(),
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
        options: _opts(),
      );

  Future<shop.CompleteUploadResponse> completeUpload(String audiobookId, shop.AIProvider aiProvider,  shop.MediaStatus forceStatus) =>
      _client.completeUpload(
        shop.CompleteUploadRequest(audiobookId: audiobookId, aiProvider: aiProvider , forceStatus: forceStatus),
        options: _opts(),
      );

  Future<shop.GetAudiobookStatusResponse> getAudiobookStatus(
          String audiobookId) =>
      _client.getAudiobookStatus(
        shop.GetAudiobookStatusRequest(audiobookId: audiobookId),
        options: _opts(),
      );

  Future<void> removeFromCart(String audiobookId, {int quantity = 1}) async {
    await _client.removeFromCart(
      shop.RemoveFromCartRequest(audiobookId: audiobookId),
      options: _opts(),
    );
  }
}
