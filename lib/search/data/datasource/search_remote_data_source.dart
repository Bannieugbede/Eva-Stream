import 'package:dio/dio.dart';
import '../../../core/data/error/exceptions.dart';
import '../../../core/data/network/api_constants.dart';
import '../../../core/data/network/error_message_model.dart';
import '../models/search_result_item_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search(String title);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  @override
  Future<List<SearchResultItemModel>> search(String title) async {
    final response = await Dio().get(ApiConstants.getSearchPath(title));
    if (response.statusCode == 200) {
      return List<SearchResultItemModel>.from((response.data['results'] as List)
          .where((e) => e['media_type'] != 'person')
          .map((e) => SearchResultItemModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
