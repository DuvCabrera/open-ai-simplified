import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/domain/models/fine_tunes_response.dart';
import 'package:open_ai_simplified/domain/models/list_fine_tunes_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';
import 'package:open_ai_simplified/domain/models/moderation_response.dart';

import '../../utils.dart';
import 'open_ia_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late OpenIAService sut;
  late MockDio dio;
  late Map<String, dynamic> mockCompletionResponse;
  late Map<String, dynamic> mockModelsResponse;
  late Map<String, dynamic> mockEditsResponse;
  late Map<String, dynamic> mockImagesResponse;
  late Map<String, dynamic> mockEmbeddingResponse;
  late Map<String, dynamic> mockFileListResponse;
  late Map<String, dynamic> mockFileDataResponse;
  late Map<String, dynamic> mockModerationResponse;
  late Map<String, dynamic> mockFineTunesResponse;
  late Map<String, dynamic> mockListFineTunesResponse;

  setUp(() => sut = OpenIAService(dio));
  setUpAll(() {
    mockListFineTunesResponse = Mocks.mockListFineTunesResponse;
    mockFineTunesResponse = Mocks.mockFineTunesResponse;
    mockModerationResponse = Mocks.mockModerationResponse;
    mockFileDataResponse = Mocks.mockFileDataResponse;
    mockFileListResponse = Mocks.mockListFileResponse;
    mockEmbeddingResponse = Mocks.mockEmbeddingsResponse;
    mockImagesResponse = Mocks.mockImagesResponse;
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

  test('generateImages should return right ImagesResponse object', () async {
    when(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockImagesResponse));

    final result = await sut
        .generateImages(apiKey: '', config: ConfigImages(), prompt: {});

    expect(result, isA<ImagesResponse>());
    verify(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('createEmbedding should return EmbeddingsResponse object', () async {
    when(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockEmbeddingResponse));

    final result = await sut.createEmbedding(apiKey: '', promptWithModel: {});
    expect(result, isA<EmbeddingsResponse>());
    verify(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('getFilelist should return ListFileResponse object', () async {
    when(dio.get(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFileListResponse));
    final result = await sut.getFileList(apiKey: '');
    expect(result, isA<ListFileResponse>());
    verify(dio.get(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });

  test('deleteFile should return a Map', () async {
    when(dio.delete(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFileDataResponse));
    final result = await sut.deleteFile(apiKey: '', fileId: '');
    expect(result, isA<Map<String, dynamic>>());
    verify(dio.delete(any,
            options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('retriveFile should return a FileData object', () async {
    when(dio.get(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFileDataResponse));

    final result = await sut.retriveFile(apiKey: '', fileId: '');
    expect(result, isA<FileData>());
    verify(dio.get(
      any,
      options: anyNamed('options'),
    )).called(1);
    verifyNoMoreInteractions(dio);
  });

  test('checkModeration should return a ModerationResponse object', () async {
    when(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockModerationResponse));

    final response = await sut.checkModeration(input: {}, apiKey: 'apiKey');
    expect(response, isA<ModerationResponse>());
    verify(dio.post(any, options: anyNamed('options'), data: anyNamed('data')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('createFineTune should return a FineTuneResponse object', () async {
    when(dio.post(any, data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFineTunesResponse));
    final response =
        await sut.createFineTune(trainingParams: {}, apiKey: 'apiKey');
    expect(response, isA<FineTunesResponse>());
    verify(dio.post(any, data: anyNamed('data'), options: anyNamed('options')))
        .called(1);
    verifyNoMoreInteractions(dio);
  });

  test('getListFineTunes should return ListFineTunesResponse object', () async {
    when(dio.get(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockListFineTunesResponse));
    final response = await sut.getListFineTunes(apiKey: 'apiKey');
    expect(response, isA<ListFineTunesResponse>());
    verify(dio.get(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });

  test('retriveFineTune should return a FineTuneResponse object', () async {
    when(dio.get(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFineTunesResponse));
    final response =
        await sut.retriveFineTune(fineTuneId: '', apiKey: 'apiKey');
    expect(response, isA<FineTunesResponse>());
    verify(dio.get(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });

  test('cancelFineTune should return a FineTuneResponse object', () async {
    when(dio.post(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFineTunesResponse));
    final response = await sut.cancelFineTune(fineTuneId: '', apiKey: 'apiKey');
    expect(response, isA<FineTunesResponse>());
    verify(dio.post(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });

  test('deleteFineTunelModel should return a Map ', () async {
    when(dio.delete(any, options: anyNamed('options'))).thenAnswer(
        (realInvocation) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockFineTunesResponse));
    final response =
        await sut.deleteFineTunelModel(model: '', apiKey: 'apiKey');
    expect(response, isA<Map>());
    verify(dio.delete(any, options: anyNamed('options'))).called(1);
    verifyNoMoreInteractions(dio);
  });
}
