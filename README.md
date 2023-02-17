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
Images      | ✅
Embeddings  | ✅
Files       | ✅
Fine-tunes  | ❌
Moderations | ❌

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
   // Configure the images params, this can also be done using the method configImagesFromMap
  // The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
  openAi.configImagesFromConfig(ConfigImages(n: 1, size: '256x256'));
  // Create the images
  final images = await openAi.getImages('horse with golden hair and dragons');
  // Print the url with the images
  images.data.forEach((element) {
    log(element.url);
  });
   // Create a variation of an image, the image should be a png file with less then 4MB and a square
  final imageVariation = await openAi.createAImageVariation(
    imageFile: await downloadFile(images.data[0].url),
  );
  log(imageVariation.data[0].url);
  // Edits an image, you also can pass another image as mask
  final editImage = await openAi.editImage(
      image: await downloadFile(images.data[0].url),
      prompt: 'give a new hair style to the horse');
  // Print the url with the image
  log(editImage.data[0].url);

  /// create an embedding
  final embedding = await openAi.createEmbedding(prompt: 'sabado a noite');

  /// print the embeddings
  log(embedding.data[0].embedding.toString());

  /// The file need to be an JsonL, another types of file will not work
  /// Retrives the list of stored files as ListFileResponse object. you can have
  /// the data as Map if use the method getRawFilesList
  final list = await openAi.getFilesList();

  /// print the list
  log(list.data.toString());

  /// Upload a file that contains document(s) to be used across various endpoints/features.
  ///  Currently, the size of all the files uploaded by one organization can be up to 1 GB.
  final uploadedFile = await openAi.uploadFile(
      file: File('director/xxx.jsonl'), purpose: 'fine-tune');

  /// print the uploadedFile
  log(uploadedFile.toString());

  /// Deletes a file and return informations about de file deleted
  final deletedFile = await openAi.deleteFile(fileId: 'fileId');

  /// print the information about the file deleted
  log(deletedFile.toString());

  /// Get the info about a file as a FileData object
  /// you also can get the info as Map with the method retriveRawFileInfo
  final fileInfo = await openAi.retriveFileInfo(fileId: 'fileId');

  /// print the file info
  log(fileInfo.toString());

  /// Get the content of a specific file.
  final fileContent = await openAi.retriveFileContent(fileId: 'fileId');

  /// print the content
  log(fileContent.toString());
}

Future<File> downloadFile(String url) async {
  Dio simple = Dio();
  String savePath = '${Directory.systemTemp.path}/${url.split('/').last}';
  await simple.download(url, savePath,
      options: Options(responseType: ResponseType.bytes));
  File file = File(savePath);
  return file;
}


```

## Contributing

We welcome contributions to the OpenAi Simplified project! If you would like to contribute, please feel free to reach out to the current maintainers for more information.

## Issues

If you encounter any issues while using Focus on It, please open a new issue in the [issue tracker](https://github.com/DuvCabrera/open-ai-simplified/issues). Please include as much information as possible, such as the version of Focus on It you are using and steps to reproduce the issue.

## Lincense

OpenAi Simplified is licensed under the MIT license. See [LICENSE](https://github.com/DuvCabrera/open-ai-simplified/blob/main/LICENSE).
