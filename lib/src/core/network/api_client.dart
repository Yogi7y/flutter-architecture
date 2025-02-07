import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_y/network_y.dart';
import 'package:network_y/src/request/request.dart';

import '../constants/api.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(apiExecutor: DioApiExecutor()));

class BaseApiRequest extends Request {
  BaseApiRequest({
    required super.endpoint,
    super.baseUrl = Api.baseUrl,
    super.headers = const <String, String>{
      'Content-Type': 'application/json',
    },
  });
}
