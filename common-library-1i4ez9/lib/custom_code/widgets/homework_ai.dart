// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/chat_ai_library.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:super_library_5mglde/custom_code/actions/super_library.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/components/ai/ai_user_chat_bubble_component/ai_user_chat_bubble_component_widget.dart';
import '/components/ai/ai_response_chat_bubble_component/ai_response_chat_bubble_component_widget.dart';

GenerativeModel chatGenerativeModel = FirebaseVertexAI.instance.generativeModel(
  model: 'gemini-1.5-flash',
  systemInstruction: Content.system(
    '''
    You are a homework helper, your objective is to help user answer their homework.
    User may provide homework as text or as an image.
    The homework may be coming from the textbook or any other activities that the user need to achieve.
    Understand what the problem is asking or requesting.
    Solve the homework and present the solution back to the user in detail but concise and very easy to read.
    If the input from the user does not look like a homework, then say its not homework and provide another input.',
    ''',
  ),
  generationConfig: GenerationConfig(
    temperature: 0,
    topK: 1,
    topP: 0,
    maxOutputTokens: 240,
  ),
  safetySettings: [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
  ],
);

class HomeworkAi extends StatefulWidget {
  const HomeworkAi({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<HomeworkAi> createState() => _HomeworkAiState();
}

class _HomeworkAiState extends State<HomeworkAi> {
  final List<String> queries = [];
  String response = '';

  bool filledHistory = false;

  bool waiting = false;

  late ChatSession chatSession;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatSession = chatGenerativeModel.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ValueListView(
            query: homeworkAiRef.orderByChild('createdAt'),
            reverseQuery: true,
            builder: (snapshot, fetchMore) {
              if (filledHistory == false) {
                filledHistory = true;

                getChatHistory(snapshot.docs, (history) {
                  chatSession = chatGenerativeModel.startChat(
                    history: history,
                  );
                });
              }

              return ListView.builder(
                itemCount: snapshot.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  fetchMore(index);
                  final DataSnapshot doc = snapshot.docs[index];
                  final ChatBotModel chat = ChatBotModel.fromSnapshot(doc);

                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (chat.hasUrl)
                          UserChatImageBubble(
                            chat: chat,
                          ),

                        if (chat.client != true) ...[
                          SizedBox(height: 16),
                          AiUserChatBubbleComponentWidget(
                              createdAt: chat.createdAt, prompt: chat.prompt),
                        ],

                        SizedBox(height: 16),
                        // ResponseChatBubble(chat: chat),
                        AiResponseChatBubbleComponentWidget(
                          response: chat.response,
                          error: chat.error,
                          completedAt: chat.completedAt,
                        ),

                        /// display initial response while firebase storage dont have the response updated yet
                        if (index == 0 &&
                            chat.response.isEmpty &&
                            (response.isNotEmpty || waiting))
                          // ResponseChatPreviewBubble(textPreview: response),
                          AiResponseChatBubbleComponentWidget(
                            textPreview: response.isEmpty ? ' ' : response,
                          ),
                        SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        MessageInputBox(
          key: Key('AIHomeworkInputBox'),
          sttId: "AIHomeworkInputBox",
          chatSession: chatSession,
          reference: homeworkAiRef,
          onSendStart: () {
            // set true to make sure not to get anymore from loaded docs specially on first message.
            filledHistory = true;

            /// clear response
            response = '';

            /// show loader
            waiting = true;
            setState(() {});
          },
          onResponse: (String res) {
            response = res;
            setState(() {});
          },
          onSendEnd: () {
            /// hide loader
            waiting = false;
            setState(() {});
          },
          sendOnUpload: true,
          onUploadPrompt: '''
                      Analyze and provide information about the image.
                      If the image has question or math problem, what is the answer.
                      If the image doesnt look like have problem just describe the image else if it has question or problem then answer in 2 part,
                      first should be short and concise the second part should be detailed answer.
                      ''',
        )
      ],
    );
  }
}
