import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository.dart';

class MockeSpaceMediaDatasource extends Mock implements ISpaceMediaDatasouce {}

void main() {
  late SpaceMediaRepository repository;
  late ISpaceMediaDatasouce datasouce;

  setUp(() {
    datasouce = MockeSpaceMediaDatasource();
    repository = SpaceMediaRepository(datasouce);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description:
        '''Mars looks sharp in these two rooftop telescope views captured in late November from Singapore, planet Earth. At the time, Mars was about 82 million kilometers from Singapore and approaching its opposition, opposite the Sun in planet Earth's sky on December 8. Olympus Mons, largest of the volcanoes in the Tharsis Montes region (and largest known volcano in the Solar System), is near Mars' western limb. In both the images it's the whitish donut-shape at the upper right. The dark area visible near center is the Terra Sirenum region while the long dark peninsula closest to the planet's eastern limb is Sinus Gomer. Near its tip is Gale crater, the Curiosity rover's landing site in 2012. Above Sinus Gomer, white spots are other volcanoes in the Elysium region. At top of the planet is the north polar cap covered with ice and clouds. Taken about two days apart, these images of the same martian hemisphere form a stereo pair. Look at the center of the frame and cross your eyes until the separate images come together to see the Red Planet in 3D.''',
    mediaType: 'image',
    title: 'Stereo Mars near Opposition',
    mediaUrl: 'https://apod.nasa.gov/apod/image/2212/Mars-Stereo.png',
  );

  final tDate = DateTime(2021, 12, 1);

  test('should return space media model when calls the datasource', () async {
    // arrange
    when(() => datasouce.getSpaceMediaFromDate(any())).thenAnswer((_) async => tSpaceMediaModel);
    // act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // assert
    expect(result, const Right(tSpaceMediaModel));
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
