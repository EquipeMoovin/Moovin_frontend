import 'package:dio/dio.dart';
import '../../../../core/error/api_exception.dart';
import '../models/tenant_response.dart';

class TenantService {
  final Dio dio;

  TenantService(this.dio);

  Future<TenantResponse> fetchTenant() async {
    final url = '/profile/profile/me/';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return TenantResponse.fromJson(response.data);
      } else {
        throw ApiException(
          'Erro ao carregar perfil do tenant',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Erro na requisição',
        code: e.response?.statusCode.toString(),
      );
    }
  }

  Future<TenantResponse> updateTenant(Map<String, dynamic> data) async {
    final url = '/profile/me/update-profile/';

    try {
      final response = await dio.patch(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        return TenantResponse.fromJson(response.data);
      } else {
        throw ApiException(
          'Erro ao atualizar o perfil do tenant',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Erro na requisição',
        code: e.response?.statusCode.toString(),
      );
    }
  }

  Future<void> favoriteProperty(int tenantId) async {
    final url = '/profile/$tenantId/favorite_property/';

    try {
      final response = await dio.post(url);

      if (response.statusCode != 200) {
        throw ApiException(
          'Erro ao favoritar o imóvel',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Erro ao favoritar o imóvel',
        code: e.response?.statusCode.toString(),
      );
    }
  }
}