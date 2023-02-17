class Mocks {
  static Map<String, dynamic> mockEmbeddingsResponse = {
    "object": "list",
    "data": [
      {
        "object": "embedding",
        "embedding": [
          0.0023064255,
          -0.009327292,
          -0.0028842222,
        ],
        "index": 0
      }
    ],
    "model": "text-embedding-ada-002",
    "usage": {"prompt_tokens": 8, "total_tokens": 8}
  };
  static Map<String, dynamic> mockCompletionResponse = {
    "id": "cmpl-uqkvlQyYK7bGYrRHQ0eXlWi7",
    "object": "text_completion",
    "created": 1589478378,
    "model": "text-davinci-003",
    "choices": [
      {
        "text": "\n\nThis is indeed a test",
        "index": 0,
        "logprobs": null,
        "finish_reason": "length"
      }
    ],
    "usage": {"prompt_tokens": 5, "completion_tokens": 7, "total_tokens": 12}
  };

  static Map<String, dynamic> mockModelsResponse = {
    "data": [
      {"id": "model-id-0", "object": "model", "owned_by": "organization-owner"},
      {"id": "model-id-1", "object": "model", "owned_by": "organization-owner"},
      {"id": "model-id-2", "object": "model", "owned_by": "openai"},
    ],
    "object": "list"
  };

  static Map<String, dynamic> mockEditsResponse = {
    "object": "edit",
    "created": 1589478378,
    "choices": [
      {
        "text": "What day of the week is it?",
        "index": 0,
      }
    ],
    "usage": {"prompt_tokens": 25, "completion_tokens": 32, "total_tokens": 57}
  };

  static Map<String, dynamic> mockImagesResponse = {
    "created": 1589478378,
    "data": [
      {"url": "https://"},
      {"url": "https://"}
    ]
  };

  static Map<String, dynamic> mockListFileResponse = {
    "data": [
      {
        "id": "file-ccdDZrC3iZVNiQVeEA6Z66wf",
        "object": "file",
        "bytes": 175,
        "created_at": 1613677385,
        "filename": "train.jsonl",
        "purpose": "search"
      },
      {
        "id": "file-XjGxS3KTG0uNmNOK362iJua3",
        "object": "file",
        "bytes": 140,
        "created_at": 1613779121,
        "filename": "puppy.jsonl",
        "purpose": "search"
      }
    ],
    "object": "list"
  };
  static Map<String, dynamic> mockFileDataResponse = {
    "id": "file-XjGxS3KTG0uNmNOK362iJua3",
    "object": "file",
    "bytes": 140,
    "created_at": 1613779121,
    "filename": "mydata.jsonl",
    "purpose": "fine-tune"
  };
}
