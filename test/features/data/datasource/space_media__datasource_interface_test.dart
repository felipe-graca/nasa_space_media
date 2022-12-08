import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/services/http_client/http_client.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_interface.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasouce datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDatasource(client);
  });

  const urlExpected = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-12-08';
  final tDate = DateTime(2022, 12, 08);

  void successMock() {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  group('requisition methods', () {
    test('should call the get method with correct url', () async {
      // arrange
      successMock();
      // act
      await datasource.getSpaceMediaFromDate(tDate);
      // assert
      verify(() => client.get(urlExpected)).called(1);
    });
  });

  group('return data', () {
    test('should return a spaceMediaModel when is successful', () async {
      // arrange
      successMock();
      // act
      final result = await datasource.getSpaceMediaFromDate(tDate);
      // assert
      expect(result, tSpaceMedia);
    });

    test('should throw a ServiceException when the call is umccessful', () async {
      // arrange
      when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: 'something went wrong', statusCode: 400));
      // act
      final result = datasource.getSpaceMediaFromDate(tDate);
      // assert
      expect(() => result, throwsA(ServerException()));
    });
  });
}
