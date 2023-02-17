import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_ai_simplified/open_ai_simplified.dart';

void main() async {
  /// Load env
  await dotenv.load(fileName: ".env");

  /// Create a new repository.
  OpenIARepository openAi = OpenIARepository();

  /// Add the api key.
  openAi.addApiKey(dotenv.env['API_KEY']!);

  /// Retrive the models avaibles.
  final models = await openAi.getRawModelsList();

  /// Print the models
  log(models.toString());

  /// Configure the completion params, this can also be done using the method configCompletionFromMap
  openAi.configCompletionFromConfig(ConfigCompletion(temperature: 0.6));

  /// Create a completion
  final completion = await openAi.getCompletion('what times it?');

  /// Print the completion
  log(completion.choices[0].text);

  /// Configure the edits params, this can also be done using the method configEditsFromMap
  openAi.configEditsFromConfig(config: ConfigEdits(temperature: 0.8));

  /// Create the edits
  final edit = await openAi.getEdits(
      input: 'helo piple', instruction: 'fix the spelling mistakes');

  /// Print the edits
  log(edit.choices[0].text);

  /// Configure the images params, this can also be done using the method configImagesFromMap
  /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
  openAi.configImagesFromConfig(ConfigImages(n: 1, size: '256x256'));

  /// Create the images
  final images = await openAi.getImages('horse with golden hair and dragons');

  /// Print the url with the images
  for (var element in images.data) {
    log(element.url);
  }

  /// Create a variation of an image, the image should be a png file with less then 4MB and a square
  final imageVariation = await openAi.createAImageVariation(
    imageFile: await downloadFile(images.data[0].url),
  );
  log(imageVariation.data[0].url);

  /// Edits an image, you also can pass another image as mask
  /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
  final editImage = await openAi.editImage(
      image:
          await downloadFile('https://xxx.example-with-trasnparecy-area.com'),
      prompt: 'with flames');

  /// Print the url with the image
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

  /// Classifies if text violates OpenAI's Content Policy, returns ModerationResponse object
  final moderationInfo =
      await openAi.moderationCheck(input: 'I want to kill them.');

  /// print moderation info
  log(moderationInfo.results[0].categories.toString());
}

Future<File> downloadFile(String url) async {
  Dio simple = Dio();
  String savePath = '${Directory.systemTemp.path}/${url.split('/').last}';
  await simple.download(url, savePath,
      options: Options(responseType: ResponseType.json));

  File file = File(savePath);

  return file;
}
