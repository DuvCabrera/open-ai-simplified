import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_ai_simplified/open_ai_simplified.dart';

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
