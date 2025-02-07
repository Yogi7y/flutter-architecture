import 'package:meta/meta.dart';
import 'package:network_y/network_y.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/network/api_client.dart';

@immutable
class GetOrdersRequest extends BaseApiRequest implements GetRequest {
  GetOrdersRequest({super.endpoint = Api.orders});
}
