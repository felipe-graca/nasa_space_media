import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  test('should be a subclass of SpaceMediaEntity', () {
    // assert
    expect(tSpaceMedia, isA<SpaceMediaEntity>());
  });

  test('should return a valid model', () {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    // act
    final result = SpaceMediaModel.fromJson(jsonMap);

    // assert
    expect(result, tSpaceMedia);
  });

  test('should return a json map containing the proper data', () {
    // arrage
    final expectedMap = {
      "explanation":
          "Mars looks sharp in these two rooftop telescope views captured in late November from Singapore, planet Earth. At the time, Mars was about 82 million kilometers from Singapore and approaching its opposition, opposite the Sun in planet Earth's sky on December 8. Olympus Mons, largest of the volcanoes in the Tharsis Montes region (and largest known volcano in the Solar System), is near Mars' western limb. In both the images it's the whitish donut-shape at the upper right. The dark area visible near center is the Terra Sirenum region while the long dark peninsula closest to the planet's eastern limb is Sinus Gomer. Near its tip is Gale crater, the Curiosity rover's landing site in 2012. Above Sinus Gomer, white spots are other volcanoes in the Elysium region. At top of the planet is the north polar cap covered with ice and clouds. Taken about two days apart, these images of the same martian hemisphere form a stereo pair. Look at the center of the frame and cross your eyes until the separate images come together to see the Red Planet in 3D.",
      "media_type": "image",
      "title": "Stereo Mars near Opposition",
      "url": "https://apod.nasa.gov/apod/image/2212/Mars-Stereo.png"
    };

    // act
    final result = tSpaceMedia.toJson();

    // assert
    expect(result, expectedMap);
  });
}
