import 'dart:convert';

import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/services/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/data_to_string_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_interface.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

class SpaceMediaDatasource implements ISpaceMediaDatasouce {
  final IHttpService client;

  SpaceMediaDatasource(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }
}
