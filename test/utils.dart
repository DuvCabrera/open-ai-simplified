class Mocks {
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
}
