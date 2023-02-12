import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

import '../../utils.dart';
import 'open_ia_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late OpenIAService sut;
  late MockDio dio;
  late Map<String, dynamic> mockCompletionResponse;
  late Map<String, dynamic> mockModelsResponse;
  late Map<String, dynamic> mockEditsResponse;

  setUp(() => sut = OpenIAService(dio));
  setUpAll(() {
    mockEditsResponse = Mocks.mockEditsResponse;
    mockModelsResponse = Mocks.mockModelsResponse;
    mockCompletionResponse = Mocks.mockCompletionResponse;
    dio = MockDio();
  });
  test('getCompletion should return the right result', () async {
    when(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockCompletionResponse));
    final response = await sut.getCompletion(
        prompt: '', apiKey: '', config: ConfigCompletion());

    expect(response, isA<CompletionResponse>());
    verify(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('getModelsList should return the right result', () async {
    when(dio.get(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockModelsResponse));

    final result = await sut.getModelsList(apiKey: '');

    expect(result, isA<OpenAiModels>());
    verify(dio.get(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });
  test('getEdits should return the right result', () async {
    when(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''), data: mockEditsResponse));
    final response = await sut
        .getEdits(apiKey: '', config: ConfigEdits(), inputWithInstruction: {});

    expect(response, isA<EditsResponse>());
    verify(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });
}