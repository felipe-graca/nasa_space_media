import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository_interface.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description:
        '''Mars looks sharp in these two rooftop telescope views captured in late November from Singapore, planet Earth. At the time, Mars was about 82 million kilometers from Singapore and approaching its opposition, opposite the Sun in planet Earth's sky on December 8. Olympus Mons, largest of the volcanoes in the Tharsis Montes region (and largest known volcano in the Solar System), is near Mars' western limb. In both the images it's the whitish donut-shape at the upper right. The dark area visible near center is the Terra Sirenum region while the long dark peninsula closest to the planet's eastern limb is Sinus Gomer. Near its tip is Gale crater, the Curiosity rover's landing site in 2012. Above Sinus Gomer, white spots are other volcanoes in the Elysium region. At top of the planet is the north polar cap covered with ice and clouds. Taken about two days apart, these images of the same martian hemisphere form a stereo pair. Look at the center of the frame and cross your eyes until the separate images come together to see the Red Planet in 3D.''',
    mediaType: 'image',
    title: 'Stereo Mars near Opposition',
    mediaUrl: 'https://apod.nasa.gov/apod/image/2212/Mars-Stereo.png',
  );

  // final tNoParams = NoParams();

  final tDate = DateTime(2021, 12, 1);

  test('should get space media for a given date from repository', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer((_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));
    final result = await usecase(tDate);
    expect(result, right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
