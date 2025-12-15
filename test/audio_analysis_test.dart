import 'dart:async';

import 'spotify_mock.dart';
import 'package:test/test.dart';

// ignore_for_file: deprecated_member_use_from_same_package

Future main() async {
  final spotify = SpotifyApiMock.create();

  tearDown(() {
    spotify.interceptor = null;
  });

  group('Audio Analysis', () {
    test('get', () async {
      final result = await spotify.audioAnalysis.get('xyz123');

      expect(result.track, isNotNull);
      expect(result.bars?.isEmpty, isFalse);
      expect(result.beats?.isEmpty, isFalse);
      expect(result.sections?.isEmpty, isFalse);
      expect(result.segments?.isEmpty, isFalse);
      expect(result.tatums?.isEmpty, isFalse);

      final firstSection = result.sections?.first;
      expect(firstSection?.start, 0);
      expect(firstSection?.duration, 6.97092);
      expect(firstSection?.confidence, 1);
      expect(firstSection?.loudness, -14.938);
      expect(firstSection?.tempo, 113.178);
      expect(firstSection?.tempoConfidence, 0.647);
      expect(firstSection?.key, 9);
      expect(firstSection?.keyConfidence, 0.297);
      expect(firstSection?.mode, 1);
      expect(firstSection?.modeConfidence, 0.471);
      expect(firstSection?.timeSignature, 4);
      expect(firstSection?.timeSignatureConfidence, 1);

      final firstSegment = result.segments?.first;
      expect(firstSegment?.start, 0);
      expect(firstSegment?.duration, 0.24317);
      expect(firstSegment?.confidence, 1);
      expect(firstSegment?.loudnessStart, -59.656);
      expect(firstSegment?.loudnessMaxTime, 0.21478);
      expect(firstSegment?.loudnessMax, -36.317);
      expect(firstSegment?.loudnessEnd, 0);
      expect(firstSegment?.pitches?.isEmpty, isFalse);
      expect(firstSegment?.timbre?.isEmpty, isFalse);

      final track = result.track;
      expect(track?.numSamples, 4585515);
      expect(track?.duration, 207.95985);
      expect(track?.analysisSampleRate, 22050);
      expect(track?.analysisChannels, 1);
      expect(track?.endOfFadeIn, 0);
      expect(track?.startOfFadeOut, 201.13705);
      expect(track?.loudness, -2.743);
      expect(track?.tempo, 114.944);
      expect(track?.tempoConfidence, 0.74);
      expect(track?.timeSignature, 4);
      expect(track?.timeSignatureConfidence, 0.994);
      expect(track?.key, 2);
      expect(track?.keyConfidence, 0.408);
      expect(track?.mode, 1);
      expect(track?.codeString, 'eJxVmgl2LDcOBK_SR-');
      expect(track?.codeVersion, 3.15);
      expect(track?.synchString, 'eJxNWglyHDEI_I');
      expect(track?.synchVersion, 1);
      expect(track?.rhythmString, 'eJx1XFmW4zgOvIqPwJ3g_S');
      expect(track?.rhythmVersion, 1);
    });
  });
}
