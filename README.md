<h1>OpenAi Simplified</h1>

### OpenAI Simplified is an application that aims to provide easy and intuitive access to OpenAI services. With it, developers can integrate some of OpenAI's artificial intelligence technologies into their own applications in a simple and efficient manner.

Status: Developing 👷🏿
⚠️ Some of the tools provided by OpenAI are still under development and will be implemented over time

## Installation

To instal OpenAi Simplified, you can use either of the following methods:

### Method 1: flutter pub add
```
flutter pub add open_ai_simplified
```

### Method 2: pubspec.yaml
Alternatively, you can add the following line to your pubspec.yaml file:
```
dependencies:
    open_ai_simplified: ^VERSION
```
Replace VERSION with the latest version of OpenAI Simplified
Import the library into your code by adding the following line at the top of your file:
```dart
import 'package:open_ai_simplified/open_ai_simplified.dart';
```
## Features

Below are some of the features available.

Feature     | Availability
:---------- | :-----------:
Models      | ✅
Completions | ✅
Edits       | ✅
Images      | ❌
Embeddings  | ❌
Files       | ❌
Fine-tunes  | ❌
Moderations | ❌
Engines     | ❌

## Getting started

OpenAI Simplified aims to make it easier to use its capabilities, so almost no configuration is required to use it. Just initialize its repository and provide it with your OpenAI API secret key, and all the features already use the suggested configuration in the API as the default. It is also possible to change the settings if necessary.
To configure the parameters of the desired functionality, methods are available, one where it is possible to use one of the objects from the package itself and another passing a Map with the data structure provided by the [OpenAI API](https://platform.openai.com/docs/api-reference/introduction).

## Usage

```dart
void main() async {
  // Load env
  await dotenv.load(fileName: ".env");
  // Create a new repository.
  OpenIARepository openAi = OpenIARepository();
  // Add the api key.
  openAi.addApiKey(dotenv.env['API_KEY']!);
  // Retrive the models avaibles.
  final models = await openAi.getRawModelsList();
  // Print the models
  log(models.toString());
  // Configure the completion params, this can also be done using the method configCompletionFromMap
  openAi.configCompletionFromConfig(ConfigCompletion(temperature: 0.6));
  // Create a completion
  final completion = await openAi.getCompletion('what times it?');
  // Print the completion
  log(completion.choices[0].text);
  // Configure the edits params, this can also be done using the method configEditsFromMap
  openAi.configEditsFromConfig(config: ConfigEdits(temperature: 0.8));
  // Print the edits
  final edit = await openAi.getEdits(
      input: 'helo piple', instruction: 'fix the spelling mistakes');
  // Print the edits
  log(edit.choices[0].text);
}
```

## Contributing

We welcome contributions to the OpenAi Simplified project! If you would like to contribute, please feel free to reach out to the current maintainers for more information.

## Issues

If you encounter any issues while using Focus on It, please open a new issue in the [issue tracker](https://github.com/DuvCabrera/open-ai-simplified/issues). Please include as much information as possible, such as the version of Focus on It you are using and steps to reproduce the issue.

## Lincense

OpenAi Simplified is licensed under the MIT license. See [LICENSE](https://github.com/DuvCabrera/open-ai-simplified/blob/main/LICENSE).
