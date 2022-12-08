import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository.dart';

import '../../../mocks/space_media_mock.dart';

class MockeSpaceMediaDatasource extends Mock implements ISpaceMediaDatasouce {}

void main() {
  late SpaceMediaRepository repository;
  late ISpaceMediaDatasouce datasouce;

  setUp(() {
    datasouce = MockeSpaceMediaDatasource();
    repository = SpaceMediaRepository(datasouce);
  });

  final tDate = DateTime(2021, 12, 1);

  test('should return space media model when calls the datasource', () async {
    // arrange
    when(() => datasouce.getSpaceMediaFromDate(any())).thenAnswer((_) async => tSpaceMedia);
    // act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // assert
    expect(result, const Right(tSpaceMedia));
    verify(() => datasouce.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a server failure when the call to datasource is unsuccessful', () async {
    // arrange
    when(() => datasouce.getSpaceMediaFromDate(any())).thenThrow(ServerException());
    // act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // assert
    expect(result, Left(ServerFailure()));
    verify(() => datasouce.getSpaceMediaFromDate(tDate)).called(1);
  });
}
