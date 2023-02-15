import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:open_ai_simplified/data/remote/open_ia_service.dart';
import 'package:open_ai_simplified/data/repositories/open_ai_repository.dart';
import 'package:open_ai_simplified/domain/exceptions.dart';
import 'package:open_ai_simplified/domain/models/images_response.dart';
import 'package:open_ai_simplified/domain/models/models.dart';

import '../../utils.dart';
import 'open_ai_repository_test.mocks.dart';

@GenerateMocks([OpenIAService])
void main() {
  late OpenIARepository sut;
  late MockOpenIAService openIAService;
  late Map<String, dynamic> mockCompletionResponse;
  late Map<String, dynamic> mockModelsResponse;
  late Map<String, dynamic> mockEditsResponse;
  late Map<String, dynamic> mockImagesResponse;

  setUpAll(() {
    mockImagesResponse = Mocks.mockImagesResponse;
    mockEditsResponse = Mocks.mockEditsResponse;
    mockModelsResponse = Mocks.mockModelsResponse;
    mockCompletionResponse = Mocks.mockCompletionResponse;
    openIAService = MockOpenIAService();
  });

  setUp(() {
    sut = OpenIARepository(service: openIAService);
    sut.addApiKey('apikey');
  });
  test('getRawCompletion should return a map ...', () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));
    final result = await sut.getRawCompletion('d');
    expect(result, isA<Map>());
    verify(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getRawCompletion should throw KeyNotFoundException when apikey is not provided',
      () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));
    sut.addApiKey('');
    final result = sut.getRawCompletion('d');
    expect(result, throwsA(isA<KeyNotFoundException>()));
    verifyNoMoreInteractions(openIAService);
  });
  test(
      'getRawCompletion should throw InvalidParamsException when prompt is empty',
      () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));

    final result = sut.getRawCompletion('');
    expect(result, throwsA(isA<InvalidParamsException>()));
    verifyNoMoreInteractions(openIAService);
  });

  test('getCompletion should return a Completion ...', () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));
    final result = await sut.getCompletion('s');
    expect(result, isA<CompletionResponse>());
    verify(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getCompletion should throw KeyNotFoundException when apikey is not provided',
      () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));
    sut.addApiKey('');
    final result = sut.getCompletion('d');
    expect(result, throwsA(isA<KeyNotFoundException>()));
    verifyNoMoreInteractions(openIAService);
  });
  test('getCompletion should throw InvalidParamsException when prompt is empty',
      () async {
    when(openIAService.getCompletion(
            prompt: anyNamed('prompt'),
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config')))
        .thenAnswer((realInvocation) async =>
            CompletionResponse.fromMap(mockCompletionResponse));

    final result = sut.getCompletion('');
    expect(result, throwsA(isA<InvalidParamsException>()));
    verifyNoMoreInteractions(openIAService);
  });
  test('getRawModelsList shold return a map', () async {
    when(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).thenAnswer(
        (realInvocation) async => OpenAiModels.fromMap(mockModelsResponse));
    final result = await sut.getRawModelsList();

    expect(result, isA<Map>());
    verify(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getRawModelsList shold throw a KeyNotFoundException when the apikey is not provided',
      () async {
    when(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).thenAnswer(
        (realInvocation) async => OpenAiModels.fromMap(mockModelsResponse));
    sut.addApiKey('');
    final result = sut.getRawModelsList();

    expect(result, throwsA(isA<KeyNotFoundException>()));

    verifyNoMoreInteractions(openIAService);
  });

  test('getModelsList shold return a OpenAiModels', () async {
    when(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).thenAnswer(
        (realInvocation) async => OpenAiModels.fromMap(mockModelsResponse));
    final result = await sut.getModelsList();

    expect(result, isA<OpenAiModels>());
    verify(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getModelsList shold throw a KeyNotFoundException when the apikey is not provided',
      () async {
    when(openIAService.getModelsList(apiKey: anyNamed('apiKey'))).thenAnswer(
        (realInvocation) async => OpenAiModels.fromMap(mockModelsResponse));
    sut.addApiKey('');
    final result = sut.getModelsList();

    expect(result, throwsA(isA<KeyNotFoundException>()));

    verifyNoMoreInteractions(openIAService);
  });
  test('getRawEdits should return a map', () async {
    when(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .thenAnswer(
            (realInvocation) async => EditsResponse.fromMap(mockEditsResponse));
    final result = await sut.getRawEdits(input: 's', instruction: 's');
    expect(result, isA<Map>());
    verify(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });
  test('getEdits should return a EditsResponse', () async {
    when(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .thenAnswer(
            (realInvocation) async => EditsResponse.fromMap(mockEditsResponse));
    final result = await sut.getEdits(input: 's', instruction: 's');
    expect(result, isA<EditsResponse>());
    verify(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });
  test(
      'getEdits should throws a KeyNotFoundException if apiKey is empty or is not provided',
      () async {
    when(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .thenAnswer(
            (realInvocation) async => EditsResponse.fromMap(mockEditsResponse));
    sut.addApiKey('');
    final result = sut.getEdits(input: 's', instruction: 's');
    expect(result, throwsA(isA<KeyNotFoundException>()));
    verifyNoMoreInteractions(openIAService);
  });
  test(
      'getEdits should throws a InvalidParamsException if input is empty or is not provided',
      () async {
    when(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .thenAnswer(
            (realInvocation) async => EditsResponse.fromMap(mockEditsResponse));
    final result = sut.getEdits(input: '', instruction: 's');
    expect(result, throwsA(isA<InvalidParamsException>()));
    verifyNoMoreInteractions(openIAService);
  });
  test(
      'getEdits should throws a InvalidParamsException if instruction is empty or is not provided',
      () async {
    when(openIAService.getEdits(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            inputWithInstruction: anyNamed('inputWithInstruction')))
        .thenAnswer(
            (realInvocation) async => EditsResponse.fromMap(mockEditsResponse));
    final result = sut.getEdits(input: 'd', instruction: '');
    expect(result, throwsA(isA<InvalidParamsException>()));
    verifyNoMoreInteractions(openIAService);
  });

  test('getRawImages should return a Map', () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));
    final result = await sut.getRawImages('s');
    expect(result, isA<Map>());
    verify(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getRawImages should throw KeyNotFoundException when apiKey is not provided',
      () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));
    sut.addApiKey('');
    final result = sut.getRawImages('s');
    expect(result, throwsA(isA<KeyNotFoundException>()));

    verifyNoMoreInteractions(openIAService);
  });

  test('getRawImages should throw InvalidParamsException when prompt is empty',
      () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));

    final result = sut.getRawImages('');
    expect(result, throwsA(isA<InvalidParamsException>()));

    verifyNoMoreInteractions(openIAService);
  });

  test('getImages should return a ImagesResponse object', () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));
    final result = await sut.getImages('s');
    expect(result, isA<ImagesResponse>());
    verify(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .called(1);
    verifyNoMoreInteractions(openIAService);
  });

  test(
      'getImages should throw KeyNotFoundException when apiKey is not provided',
      () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));
    sut.addApiKey('');
    final result = sut.getImages('s');
    expect(result, throwsA(isA<KeyNotFoundException>()));

    verifyNoMoreInteractions(openIAService);
  });

  test('geImages should throw InvalidParamsException when prompt is empty',
      () async {
    when(openIAService.generateImages(
            apiKey: anyNamed('apiKey'),
            config: anyNamed('config'),
            prompt: anyNamed('prompt')))
        .thenAnswer((realInvocation) async =>
            ImagesResponse.fromMap(mockImagesResponse));

    final result = sut.getImages('');
    expect(result, throwsA(isA<InvalidParamsException>()));

    verifyNoMoreInteractions(openIAService);
  });
}
