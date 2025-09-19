import 'package:dio/dio.dart';
import '../../../../core/error/api_exception.dart';
import '../models/owner_response.dart';

class OwnerService {
  final Dio dio;

  OwnerService(this.dio);


  Future<OwnerResponse> fetchCurrentOwner() async {
    final url ='/me/';



    try {
        final response = await dio.get(url);



        if (response.statusCode == 200) {
          return OwnerResponse.fromJson(response.data);
        } else if (response.statusCode == 404) {
          throw ApiException('Proprietário não encontrado.',code: response.statusCode.toString() );
        } else {
          throw ApiException('Erro ao carregar perfil do proprietário',code:  response.statusCode.toString());
        }

      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('Tempo de conexão esgotado. Tente novamente.');
        } else if (e.type == DioExceptionType.badResponse) {
          throw Exception('Erro de resposta do servidor: ${e.response?.statusCode}');
        } else if (e.type == DioExceptionType.connectionError) {
          throw Exception('Erro de conexão. Verifique sua internet.');
        } else {
          throw Exception('Erro inesperado: ${e.message}');
        }
      } catch (e) {
        throw ApiException('Erro ao buscar proprietário',code: e.toString());
      }
      
    
  }



  Future<OwnerResponse> fetchOwnerByImmobile(int immobileId) async {
  final url = '/$immobileId/getbyimmobile';

  try {
    final response = await dio.get(url);


    if (response.statusCode == 200) {
      return OwnerResponse.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw ApiException('Proprietário não encontrado para este imóvel.',code: response.statusCode.toString() );
    } else {
      throw ApiException('Erro ao carregar perfil do proprietário',code:  response.statusCode.toString());
    }

  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw Exception('Tempo de conexão esgotado. Tente novamente.');
    } else if (e.type == DioExceptionType.badResponse) {
      throw Exception('Erro de resposta do servidor: ${e.response?.statusCode}');
    } else if (e.type == DioExceptionType.connectionError) {
      throw Exception('Erro de conexão. Verifique sua internet.');
    } else {
      throw Exception('Erro inesperado: ${e.message}');
    }
  } catch (e) {
    throw ApiException('Erro ao buscar proprietário',code: e.toString());
  }
}


  Future<OwnerResponse> updateCurrentOwner(Map<String, dynamic> data) async {
  try {
    final response = await dio.patch(
      '/me/update-profile/',
      data: data,
    );
    
   
    if (response.statusCode == 200 && response.data != null) {
    
      return OwnerResponse.fromJson(response.data);
    } else {
      
      throw ApiException(
        'Erro ao atualizar dados do proprietário',
        code: response.statusCode.toString(),
      );
    }
  } 
 
  on DioException catch (e) {
    throw ApiException(
      e.message ?? 'Erro de rede desconhecido',
      code: e.response?.statusCode.toString(),
    );
  } 
 
  catch (e) {
    throw ApiException(
      'Erro inesperado ao processar os dados: ${e.toString()}',
    );
  }
}



  
}