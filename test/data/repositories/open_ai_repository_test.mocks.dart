// Mocks generated by Mockito 5.3.2 from annotations
// in open_ai_simplified/test/data/repositories/open_ai_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:io' as _i6;

import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:open_ai_simplified/data/remote/open_ia_service.dart' as _i8;
import 'package:open_ai_simplified/domain/models/embeddings_response.dart'
    as _i4;
import 'package:open_ai_simplified/domain/models/list_file_response.dart'
    as _i5;
import 'package:open_ai_simplified/domain/models/models.dart' as _i3;
import 'package:open_ai_simplified/domain/models/moderation_response.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCompletionResponse_1 extends _i1.SmartFake
    implements _i3.CompletionResponse {
  _FakeCompletionResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOpenAiModels_2 extends _i1.SmartFake implements _i3.OpenAiModels {
  _FakeOpenAiModels_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEditsResponse_3 extends _i1.SmartFake implements _i3.EditsResponse {
  _FakeEditsResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeImagesResponse_4 extends _i1.SmartFake
    implements _i3.ImagesResponse {
  _FakeImagesResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEmbeddingsResponse_5 extends _i1.SmartFake
    implements _i4.EmbeddingsResponse {
  _FakeEmbeddingsResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeListFileResponse_6 extends _i1.SmartFake
    implements _i5.ListFileResponse {
  _FakeListFileResponse_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileData_7 extends _i1.SmartFake implements _i5.FileData {
  _FakeFileData_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFile_8 extends _i1.SmartFake implements _i6.File {
  _FakeFile_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeModerationResponse_9 extends _i1.SmartFake
    implements _i7.ModerationResponse {
  _FakeModerationResponse_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OpenIAService].
///
/// See the documentation for Mockito's code generation for more information.
class MockOpenIAService extends _i1.Mock implements _i8.OpenIAService {
  MockOpenIAService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);
  @override
  _i9.Future<_i3.CompletionResponse> getCompletion({
    required String? prompt,
    required String? apiKey,
    required _i3.ConfigCompletion? config,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCompletion,
          [],
          {
            #prompt: prompt,
            #apiKey: apiKey,
            #config: config,
          },
        ),
        returnValue:
            _i9.Future<_i3.CompletionResponse>.value(_FakeCompletionResponse_1(
          this,
          Invocation.method(
            #getCompletion,
            [],
            {
              #prompt: prompt,
              #apiKey: apiKey,
              #config: config,
            },
          ),
        )),
      ) as _i9.Future<_i3.CompletionResponse>);
  @override
  _i9.Future<_i3.OpenAiModels> getModelsList({required String? apiKey}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getModelsList,
          [],
          {#apiKey: apiKey},
        ),
        returnValue: _i9.Future<_i3.OpenAiModels>.value(_FakeOpenAiModels_2(
          this,
          Invocation.method(
            #getModelsList,
            [],
            {#apiKey: apiKey},
          ),
        )),
      ) as _i9.Future<_i3.OpenAiModels>);
  @override
  _i9.Future<_i3.EditsResponse> getEdits({
    required String? apiKey,
    required _i3.ConfigEdits? config,
    required Map<String, dynamic>? inputWithInstruction,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEdits,
          [],
          {
            #apiKey: apiKey,
            #config: config,
            #inputWithInstruction: inputWithInstruction,
          },
        ),
        returnValue: _i9.Future<_i3.EditsResponse>.value(_FakeEditsResponse_3(
          this,
          Invocation.method(
            #getEdits,
            [],
            {
              #apiKey: apiKey,
              #config: config,
              #inputWithInstruction: inputWithInstruction,
            },
          ),
        )),
      ) as _i9.Future<_i3.EditsResponse>);
  @override
  _i9.Future<_i3.ImagesResponse> generateImages({
    required String? apiKey,
    required _i3.ConfigImages? config,
    required Map<String, dynamic>? prompt,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateImages,
          [],
          {
            #apiKey: apiKey,
            #config: config,
            #prompt: prompt,
          },
        ),
        returnValue: _i9.Future<_i3.ImagesResponse>.value(_FakeImagesResponse_4(
          this,
          Invocation.method(
            #generateImages,
            [],
            {
              #apiKey: apiKey,
              #config: config,
              #prompt: prompt,
            },
          ),
        )),
      ) as _i9.Future<_i3.ImagesResponse>);
  @override
  _i9.Future<_i3.ImagesResponse> variateImage({
    required _i6.File? image,
    required String? apiKey,
    required _i3.ConfigImages? config,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #variateImage,
          [],
          {
            #image: image,
            #apiKey: apiKey,
            #config: config,
          },
        ),
        returnValue: _i9.Future<_i3.ImagesResponse>.value(_FakeImagesResponse_4(
          this,
          Invocation.method(
            #variateImage,
            [],
            {
              #image: image,
              #apiKey: apiKey,
              #config: config,
            },
          ),
        )),
      ) as _i9.Future<_i3.ImagesResponse>);
  @override
  _i9.Future<_i3.ImagesResponse> editImage({
    required String? prompt,
    required _i6.File? image,
    _i6.File? mask,
    required String? apiKey,
    required _i3.ConfigImages? config,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #editImage,
          [],
          {
            #prompt: prompt,
            #image: image,
            #mask: mask,
            #apiKey: apiKey,
            #config: config,
          },
        ),
        returnValue: _i9.Future<_i3.ImagesResponse>.value(_FakeImagesResponse_4(
          this,
          Invocation.method(
            #editImage,
            [],
            {
              #prompt: prompt,
              #image: image,
              #mask: mask,
              #apiKey: apiKey,
              #config: config,
            },
          ),
        )),
      ) as _i9.Future<_i3.ImagesResponse>);
  @override
  _i9.Future<_i4.EmbeddingsResponse> createEmbedding({
    required String? apiKey,
    required Map<String, dynamic>? promptWithModel,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createEmbedding,
          [],
          {
            #apiKey: apiKey,
            #promptWithModel: promptWithModel,
          },
        ),
        returnValue:
            _i9.Future<_i4.EmbeddingsResponse>.value(_FakeEmbeddingsResponse_5(
          this,
          Invocation.method(
            #createEmbedding,
            [],
            {
              #apiKey: apiKey,
              #promptWithModel: promptWithModel,
            },
          ),
        )),
      ) as _i9.Future<_i4.EmbeddingsResponse>);
  @override
  _i9.Future<_i5.ListFileResponse> getFileList({required String? apiKey}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFileList,
          [],
          {#apiKey: apiKey},
        ),
        returnValue:
            _i9.Future<_i5.ListFileResponse>.value(_FakeListFileResponse_6(
          this,
          Invocation.method(
            #getFileList,
            [],
            {#apiKey: apiKey},
          ),
        )),
      ) as _i9.Future<_i5.ListFileResponse>);
  @override
  _i9.Future<_i5.FileData> uploadFile({
    required String? apiKey,
    required _i6.File? file,
    required String? purpose,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadFile,
          [],
          {
            #apiKey: apiKey,
            #file: file,
            #purpose: purpose,
          },
        ),
        returnValue: _i9.Future<_i5.FileData>.value(_FakeFileData_7(
          this,
          Invocation.method(
            #uploadFile,
            [],
            {
              #apiKey: apiKey,
              #file: file,
              #purpose: purpose,
            },
          ),
        )),
      ) as _i9.Future<_i5.FileData>);
  @override
  _i9.Future<Map<String, dynamic>> deleteFile({
    required String? fileId,
    required String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteFile,
          [],
          {
            #fileId: fileId,
            #apiKey: apiKey,
          },
        ),
        returnValue:
            _i9.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i9.Future<Map<String, dynamic>>);
  @override
  _i9.Future<_i5.FileData> retriveFile({
    required String? fileId,
    required String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #retriveFile,
          [],
          {
            #fileId: fileId,
            #apiKey: apiKey,
          },
        ),
        returnValue: _i9.Future<_i5.FileData>.value(_FakeFileData_7(
          this,
          Invocation.method(
            #retriveFile,
            [],
            {
              #fileId: fileId,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i9.Future<_i5.FileData>);
  @override
  _i9.Future<_i6.File> retriveFileContent({
    required String? fileId,
    required String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #retriveFileContent,
          [],
          {
            #fileId: fileId,
            #apiKey: apiKey,
          },
        ),
        returnValue: _i9.Future<_i6.File>.value(_FakeFile_8(
          this,
          Invocation.method(
            #retriveFileContent,
            [],
            {
              #fileId: fileId,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i9.Future<_i6.File>);
  @override
  _i9.Future<_i7.ModerationResponse> checkModeration({
    required Map<String, dynamic>? input,
    required String? apiKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkModeration,
          [],
          {
            #input: input,
            #apiKey: apiKey,
          },
        ),
        returnValue:
            _i9.Future<_i7.ModerationResponse>.value(_FakeModerationResponse_9(
          this,
          Invocation.method(
            #checkModeration,
            [],
            {
              #input: input,
              #apiKey: apiKey,
            },
          ),
        )),
      ) as _i9.Future<_i7.ModerationResponse>);
}
