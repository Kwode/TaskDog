import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/models/service_request.dart';

final requestProvider =
    StateProvider<ServiceRequest>((ref) {
  return ServiceRequest();
});