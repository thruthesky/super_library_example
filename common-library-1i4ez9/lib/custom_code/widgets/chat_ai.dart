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
The user is a kid around 6 to 12 years old.
You are a helpful assistant like a teacher.
Your answer must be in detail and easy to read, but short, precise and clear.
Don't answer more than 200 words. It's very important because kids are having a hard time reading long answers. Always keep it short, simple and easy to understand.
Use emojis (but no special characters) to make your answer more engaging.
    ''',
  ),
  generationConfig: GenerationConfig(
    maxOutputTokens: 240,
  ),
  safetySettings: [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
  ],
);

class ChatAi extends StatefulWidget {
  const ChatAi({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChatAi> createState() => _ChatAiState();
}

class _ChatAiState extends State<ChatAi> {
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
            query: chatAiRef.orderByChild('createdAt'),
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
                        if (chat.hasUrl) ...[
                          UserChatImageBubble(
                            chat: chat,
                          ),
                          const SizedBox(height: 8),
                        ],

                        if (chat.hasUrls) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...chat.urls.map((url) {
                                int i = chat.urls.indexOf(url);
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                    bottom: chat.urls.last == url ? 0 : 8,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (_, __, ___) =>
                                            PhotoViewer(
                                          urls: chat.urls,
                                          selectedIndex: i,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          width: 1.4,
                                        ),
                                      ),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: url,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              'Failed to display file...',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                        // UserChatBubble(chat: chat),
                        AiUserChatBubbleComponentWidget(
                            createdAt: chat.createdAt, prompt: chat.prompt),
                        const SizedBox(height: 8),
                        // ResponseChatBubble(
                        //   chat: chat,
                        // ),
                        AiResponseChatBubbleComponentWidget(
                          response: chat.response,
                          error: chat.error,
                          completedAt: chat.completedAt,
                        ),

                        /// display initial response while firebase storage dont have the response updated yet
                        // if (index == 0 &&
                        //     chat.response.isEmpty &&
                        //     (response.isNotEmpty || waiting))
                        //   ResponseChatPreviewBubble(
                        //     textPreview: response,
                        //   ),
                        if (index == 0 &&
                            chat.response.isEmpty &&
                            (response.isNotEmpty || waiting))
                          AiResponseChatBubbleComponentWidget(
                            textPreview: response.isEmpty ? ' ' : response,
                          ),
                        const SizedBox(height: 16)
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        MessageInputBox(
          key: Key('AIHelperInputBox'),
          sttId: "AIHelperInputBox",
          multiImage: true,
          chatSession: chatSession,
          reference: chatAiRef,
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
        ),
      ],
    );
  }
}
