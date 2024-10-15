// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:super_library_5mglde/custom_code/actions/super_library.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';

import '/custom_code/widgets/photo_viewer.dart';
import '/custom_code/actions/upload_library.dart';

DatabaseReference get chatAiRef =>
    database.ref('ai').child(myUid).child('chatbot');
DatabaseReference get homeworkAiRef =>
    database.ref('ai').child(myUid).child('homework');

Future<FileData?> getFileData(String url) async {
  // get fileRef from url
  final fileRef = FirebaseStorage.instance.refFromURL(url);

  // get MIME type from metadata
  // return null if mimeType is empty/null or has error
  String mimeType;
  // get metadata from fileRef
  try {
    FullMetadata metadata = await fileRef.getMetadata();
    // check if content type is not null
    if (metadata.contentType == null) return null;

    mimeType = metadata.contentType!;
  } on FirebaseException catch (e) {
    dog('getFileData::FirebaseException:e: $e');
    dog('getFileData::FirebaseException:code: ${e.code}');
    if (e.code == 'object-not-found') {
      return null;
    } else {
      rethrow;
    }
  }

  // get bucket from fileRef
  final bucket = fileRef.bucket;
  // get fullPath from fileRef
  final fullPath = fileRef.fullPath;
  // Construct the file uri in the correct format.
  final fileUri = 'gs://$bucket/$fullPath';
  // Construct the filePart with the MIME type and the URL.
  return FileData(mimeType, fileUri);
}

/// Get the previous history as List<Content> via callback
///
/// Chat history must be a alternating conversation with User and model
///
/// The order should be [User,Model,User,Model,....] because the next input will be from user.
///
/// History before reverse
///
/// [ModelContent, UserContent, ModelContent, UserContent, ....]
///
/// History After reverse
///
/// [UserContent, ModelContent, UserContent, ModelContent, ...]
///
///
/// Usage
/// List<Content> history = getHistory(snapshot.docs);
/// chat = chatGenerativeModel.startChat(history: history);
///
/// Note* If the file url has no `mimeType` it will not include from the fileData.
///
getChatHistory(
    List<DataSnapshot> docs, Function(List<Content>) callback) async {
  List<Content> history = [];

  for (final doc in docs) {
    final chat = ChatBotModel.fromSnapshot(doc);
    history.add(Content.model([
      TextPart(
          chat.response.isNotEmpty ? chat.response : 'Error occured, try again')
    ]));

    List<FileData> files = [];
    if (chat.hasUrl) {
      final file = await getFileData(chat.url);
      if (file != null) files.add(file);
    }
    if (chat.hasUrls) {
      for (final url in chat.urls) {
        final file = await getFileData(url);
        if (file != null) files.add(file);
      }
    }

    history.add(
      Content.multi(
        [
          TextPart(chat.prompt),
          ...files,
        ],
      ),
    );
  }

  callback.call(history.reversed.toList());
}

class ChatBotModel {
  String id;
  DateTime? createdAt;
  DateTime? completedAt;
  String response;
  String prompt;
  String state;
  String url;
  List<String> urls;
  String error;
  bool? client;

  bool get completed => state == 'COMPLETED';
  bool get hasError => state == 'ERROR';

  bool get hasUrl => url.isNotEmpty;

  bool get hasUrls => urls.isNotEmpty;

  String get createdAtShort => createdAt?.short ?? '';

  ChatBotModel({
    required this.id,
    required this.createdAt,
    required this.response,
    required this.prompt,
    required this.error,
    this.completedAt,
    this.state = '',
    this.url = '',
    this.urls = const [],
    this.client,
  });

  factory ChatBotModel.fromJson(Map<dynamic, dynamic> json, String id) {
    return ChatBotModel(
      id: id,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] ?? 0),
      completedAt:
          DateTime.fromMillisecondsSinceEpoch(json['completedAt'] ?? 0),
      response: json['response'] ?? '',
      prompt: json['prompt'],
      url: json['url'] ?? '',
      urls: List<String>.from(json['urls'] ?? []),
      error: json['error'] ?? '',
      state: json['state'] ?? '',
      client: json['client'] ?? false,
    );
  }

  factory ChatBotModel.fromSnapshot(DataSnapshot snapshot) {
    return ChatBotModel.fromJson(
        snapshot.value as Map<dynamic, dynamic>, snapshot.key!);
  }
}

class ResponseChatBubble extends StatelessWidget {
  const ResponseChatBubble({
    super.key,
    this.chat,
    this.textPreview,
  });

  final ChatBotModel? chat;

  final String? textPreview;

  String get responseText =>
      chat!.response.trim() +
      (chat!.error.isNotEmpty
          ? '${chat!.response.trim().isEmpty ? '' : '\n\n'}${'something went wrong, try again. or try changing your message'}'
          : '');

  String get displayText => chat != null ? responseText : textPreview ?? '';

  @override
  Widget build(BuildContext context) {
    /// hide widget if no response yet or error message.
    if (chat != null && chat!.response.isEmpty && chat!.error.isEmpty) {
      return const SizedBox.shrink();
    }

    /// display chat.response and chat.error or display preview with loader
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Icon(Icons.adb),
        ),
        const SizedBox(
          height: 8,
        ),
        Flexible(
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (displayText.isNotEmpty) ...[
                    MarkdownBody(
                      data: displayText,
                      selectable: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                  if (chat != null)
                    Text(
                      chat!.completedAt!.short,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  if (textPreview != null)
                    const Padding(
                      padding: EdgeInsets.only(left: 2, top: 4, bottom: 4),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ResponseChatPreviewBubble extends StatelessWidget {
  const ResponseChatPreviewBubble({
    super.key,
    required this.textPreview,
  });

  final String textPreview;

  @override
  Widget build(BuildContext context) {
    return ResponseChatBubble(textPreview: textPreview);
  }
}

class UserChatBubble extends StatelessWidget {
  const UserChatBubble({
    super.key,
    required this.chat,
  });

  final ChatBotModel chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 52,
        ),
        Text(
          chat.createdAt?.short ?? '',
          style: TextStyle(color: Colors.grey.shade500),
        ),
        const SizedBox(
          height: 4,
        ),
        Flexible(
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: Colors.amber.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.end,
                chat.prompt,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageInputBox extends StatefulWidget {
  const MessageInputBox({
    super.key,
    required this.sttId,
    required this.chatSession,
    required this.reference,
    required this.onSendStart,
    required this.onResponse,
    required this.onSendEnd,
    this.sendOnUpload = false,
    this.onUploadPrompt = '',
    this.multiImage = false,
  }) : assert(
          sendOnUpload == true && onUploadPrompt != '' ||
              sendOnUpload == false && onUploadPrompt == '',
        );
  final String sttId;
  final ChatSession chatSession;
  final DatabaseReference reference;
  final VoidCallback onSendStart;
  final Function(String) onResponse;
  final VoidCallback onSendEnd;

  final bool sendOnUpload;
  final String onUploadPrompt;

  final bool multiImage;

  @override
  State<MessageInputBox> createState() => _MessageInputBoxState();
}

class _MessageInputBoxState extends State<MessageInputBox> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final AISoundController aiSoundController = AISoundController();
  final SpeechToTextService sttService = SpeechToTextService.instance;

  double? progress;

  String url = '';
  List<String> urls = [];

  bool sendAfterSpeech = false;
  String tmpMessage = '';
  bool textChanging = false;

  @override
  void initState() {
    super.initState();
    aiSoundController.initialize();
  }

  @override
  void dispose() async {
    aiSoundController.dispose();
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  send({String? text}) async {
    String prompt = text ?? messageController.text;

    /// Single image
    String uploadedUrl = url;

    /// multiImage
    List<String> uploadedUrls = urls;

    // return for entry prompt/message
    if (prompt.trim() == '') return;

    /// sending start
    widget.onSendStart();

    // stop listening to voice command if send while still recording
    if (sttService.isListening(widget.sttId)) {
      sttService.stopListening(widget.sttId);
    }

    /// clear inputs and url before database update.
    setState(() {
      messageController.clear();
      url = '';
      urls = [];
    });

    /// play generating sound while waiting for the response from the ai
    aiSoundController.playGeneratingSound();

    /// push to reference to get new child ref
    final ref = widget.reference.push();

    /// save prompt with createdAt in to firestore
    /// upload url if not empty
    await ref.set({
      'prompt': prompt,
      'createdAt': ServerValue.timestamp,
      // 'order': Timestamp.now().millisecondsSinceEpoch * -1,
      if (uploadedUrl != '') 'url': uploadedUrl,
      if (uploadedUrls.isNotEmpty) 'urls': uploadedUrls,
      if (text != null && text.isNotEmpty) 'client': true,
    });

    /// setState after the prompt was added to the collection
    setState(() {});

    List<Part> parts = [];

    // Add TextPart if prompt is not empty
    if (prompt.isNotEmpty) {
      parts.add(TextPart(prompt));
    }

    // Prepare FileData if uploadedUrl is not empty

    if (uploadedUrl != '') {
      final fileData = await getFileData(uploadedUrl);
      if (fileData != null) {
        parts.add(fileData);
      }
    }

    // Prepare filesData if uploadedUrls is not empty
    if (uploadedUrls.isNotEmpty) {
      for (String url in uploadedUrls) {
        final fileData = await getFileData(url);
        if (fileData != null) {
          parts.add(fileData);
        }
      }
    }

    String? error;

    ///  bool flag so the stop generating sound and play typing sound will only run on the first chuck reply
    bool firstResponse = true;
    String response = '';
    try {
      /// get response stream from chat session
      Stream<GenerateContentResponse> responseStream =
          widget.chatSession.sendMessageStream(Content.multi(parts));

      /// got response, display the response from stream
      await for (final chunk in responseStream) {
        // dog('responseStream::chunk $chunk');

        /// on the first response, stop playing the generating sound
        /// start playing the typing sound
        if (firstResponse) {
          firstResponse = false;
          aiSoundController.stopGeneratingSound();
          aiSoundController.playTypingSound();
        }
        if (chunk.text != null) {
          response += chunk.text!;
          widget.onResponse(response);
          setState(() {});
        }
      }
    } catch (e) {
      dog('catch(e)::responseStream::chunk  $e');
      // String message = (e as dynamic)['message'] ?? '';
      // error = message.isNotEmpty ? message : e.toString();
      error = e.toString();
      Future.delayed(const Duration(milliseconds: 300), () {
        aiSoundController.stopGeneratingSound();
      });
    }

    // stop playing typing sound
    Future.delayed(const Duration(milliseconds: 300), () {
      aiSoundController.stopTypingSound();
    });

    /// update response and state in firestore
    await ref.update({
      'response': response,
      'state': error == null || error.isEmpty ? 'COMPLETED' : 'ERROR',
      'error': error,
      'completedAt': ServerValue.timestamp,
    });

    widget.onSendEnd();

    /// clear response since response will be displayed from database
    setState(() {
      response = '';
      sendAfterSpeech = false;
      tmpMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (url.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 300,
                        ),
                        child: Stack(
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.zero,
                              child: CachedNetworkImage(
                                imageUrl: url,
                                errorWidget: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Failed to display file...',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  await StorageService.instance.delete(url);
                                  setState(() => url = '');
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (urls.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...urls.map((u) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: urls.first == u ? 8 : 0, right: 8),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.zero,
                              child: CachedNetworkImage(
                                imageUrl: u,
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
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  await StorageService.instance.delete(u);
                                  urls.remove(u);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        if (progress != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Stack(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  value: 0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (progress ?? 0.2),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 0 : 4,
            ),
            child: TextField(
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              scrollController: scrollController,
              maxLines: 3,
              minLines: 1,
              onChanged: (text) {
                textChanging = text.isEmpty ? false : true;
                sendAfterSpeech = false;
                tmpMessage = text;
                if (SpeechToTextService.instance.isListening(widget.sttId)) {
                  SpeechToTextService.instance.stopListening(widget.sttId);
                }
                dog("onchange::  tmpMessage::$tmpMessage sendAfterSpeech::$sendAfterSpeech");
                setState(() {});
              },
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Enter message',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    width: 1.4,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    width: 1.4,
                  ),
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 4),
                    if (textChanging == false) ...[
                      UploadIconButton.image(
                          icon: Icon(
                            Icons.camera_alt,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                          visualDensity: VisualDensity.compact,
                          uploadBottomSheetPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          uploadBottomSheetSpacing: 16,
                          onUpload: (u) {
                            dog('onUpload: $u');
                            if (widget.multiImage) {
                              urls.add(u);
                            } else {
                              url = u;
                            }
                            setState(() {});
                            if (widget.sendOnUpload) {
                              final prompt = widget.onUploadPrompt;
                              send(text: prompt);
                            }
                          },
                          progress: (p) => setState(() => progress = p),
                          complete: () => setState(() => progress = null),
                          onUploadSourceSelected: (source) {
                            // dog('onUploadSourceSelected: $source');
                            if (source != null) {
                              FocusManager.instance.primaryFocus!.unfocus();
                            }
                          }),
                      SpeechToTextIconButton(
                        sttId: widget.sttId,
                        margin: const EdgeInsets.only(
                          left: 4,
                          right: 8,
                        ),
                        onSpeech: (String speech) {
                          // dog("onSpeech:: tmpMessage::$tmpMessage speech::$speech sendAfterSpeech::$sendAfterSpeech");
                          sendAfterSpeech = true;
                          if (tmpMessage.isNotEmpty) {
                            messageController.text = "$tmpMessage $speech";
                          } else {
                            /// update the text field with the updated speech
                            messageController.text = speech;
                          }

                          /// jump to the end of the textfield to display the last message
                          scrollController.jumpTo(
                            scrollController.position.maxScrollExtent,
                          );
                          setState(() {});
                        },
                        onStatus: (String status) {
                          // dog('SpeechToText status1: status::$status sendAfterSpeech::$sendAfterSpeech');
                          setState(() {});
                          if (status == SpeechToText.doneStatus &&
                              sendAfterSpeech) {
                            send();
                          }
                        },
                        onError: (SpeechRecognitionError error) {
                          // dog('SpeechToText error: $error');
                          setState(() {});
                        },
                        onStartTap: () async {
                          // dog('onTapStart1');
                          await aiSoundController.playSpeechStartSound();
                        },
                        onStopTap: () async {
                          // dog('onTapStop1');
                        },
                      ),
                    ],
                    if (textChanging == true)
                      IconButton(
                        onPressed: () => {
                          setState(() {
                            textChanging = false;
                          })
                        },
                        icon: Icon(
                          Icons.add_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      )
                  ],
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (messageController.text.isNotEmpty)
                      InkWell(
                        onTap: () => {
                          setState(() {
                            textChanging = false;
                            messageController.clear();
                            // stop listening to voice command if send while still recording
                            if (SpeechToTextService.instance
                                .isListening(widget.sttId)) {
                              SpeechToTextService.instance
                                  .stopListening(widget.sttId);
                            }
                          })
                        },
                        child: Icon(
                          Icons.clear,
                          color:
                              Theme.of(context).iconTheme.color!.withAlpha(80),
                        ),
                      ),
                    IconButton(
                      onPressed: () => {
                        textChanging = false,
                        send(),
                      },
                      icon: Icon(
                        Icons.send,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              onSubmitted: (_) => send(),
            ),
          ),
        ),
      ],
    );
  }
}

class SpeechToTextService {
  static SpeechToTextService? _instance;

  static SpeechToTextService get instance =>
      _instance ??= SpeechToTextService._();

  SpeechToTextService._() {
    // _initialized();
  }

  /// `CurrentId` is the current listerner being used
  /// This is set then `startListening` method is called
  String? currentActiveId;

  final SpeechToText speechToText = SpeechToText();

  /// Contains result callbacks
  Map<String, Future<void> Function(String result)> onResultCallbacks = {};

  /// Contains status callbacks
  Map<String, Future<void> Function(String status)> onStatusCallbacks = {};

  /// Contains error callbacks
  Map<String, Future<void> Function(SpeechRecognitionError error)>
      onErrorCallbacks = {};

  /// Contains error stream
  StreamController<SpeechRecognitionError> errorStreamController =
      StreamController.broadcast();

  /// Contain error subscribers
  Map<String, StreamSubscription<SpeechRecognitionError>>
      errorStreamSubscriptions = {};

  /// Contains status stream
  StreamController<String> statusStreamController =
      StreamController.broadcast();

  /// Contains status subscribers
  Map<String, StreamSubscription<String>> statusStreamSubscriptions = {};

  /// isListening true to currentActiveID and speechToText.isListening == true
  bool isListening(String sttId) {
    if (currentActiveId != sttId) return false;
    return speechToText.isListening;
  }

  /// isNotListening if not currentActiveId and speechToText.isListening == false
  bool isNotListening(String sttId) {
    return !isListening(sttId);
  }

  /// True if [initialize] succeeded
  bool get isAvailable => speechToText.isAvailable;

  /// True if [initialize] failed
  bool get isNotAvailable => !isAvailable;

  dispose(String sttId) {
    errorStreamSubscriptions[sttId]?.cancel();
    statusStreamSubscriptions[sttId]?.cancel();
    onResultCallbacks.remove(sttId);
    onStatusCallbacks.remove(sttId);
    onErrorCallbacks.remove(sttId);
    currentActiveId = null;
  }

  Future init({
    required String sttId,
    required Future<void> Function(String result) onResult,
    required Future<void> Function(String status) onStatus,
    required Future<void> Function(SpeechRecognitionError error) onError,
  }) async {
    onResultCallbacks[sttId] = onResult;
    onStatusCallbacks[sttId] = onStatus;
    onErrorCallbacks[sttId] = onError;

    errorStreamSubscriptions[sttId] =
        errorStreamController.stream.listen((error) async {
      if (sttId != currentActiveId) return;
      // dog("SpeechToText error: $error $sttId");
      await speechToText.stop();
      onErrorCallbacks[sttId]?.call(error);
    });

    statusStreamSubscriptions[sttId] =
        statusStreamController.stream.listen((status) async {
      if (sttId != currentActiveId) return;
      // dog("SpeechToText status: $status $sttId");

      /// stop listening if the status was change to not listening or done status
      if ((status == SpeechToText.notListeningStatus ||
              status == SpeechToText.doneStatus) &&
          isListening(sttId)) {
        await speechToText.stop();
      }
      onStatusCallbacks[sttId]?.call(status);
    });

    if (speechToText.isAvailable) return;
    await speechToText.initialize(
      onError: (error) async {
        errorStreamController.add(error);
      },
      onStatus: (status) async {
        statusStreamController.add(status);
      },
    );
  }

  startListening({
    required String sttId,
    Duration? listenFor,
    pauseFor = const Duration(
      seconds: 3,
    ),
  }) async {
    currentActiveId = sttId;

    await speechToText.listen(
      listenFor: listenFor,
      pauseFor: pauseFor,
      onResult: (SpeechRecognitionResult result) {
        // dog("SpeechToText result: ${result.recognizedWords} / $sttId");

        /// only return while still listening
        if (isListening(sttId)) {
          onResultCallbacks[sttId]?.call(result.recognizedWords);
        }
      },
    );
  }

  stopListening(String sttId) async {
    await speechToText.stop();
  }
}

/// AISoundController is a class that will handle all sound effect for AI
class AISoundController {
  AISoundController();

  /// Create audioplayer instance that will hold each sound effect
  final generatingPlayer = AudioPlayer();
  final speechStartPlayer = AudioPlayer();
  final typingPlayer = AudioPlayer();

  /// To to initialize only few or some sound you can set them to false to skip initialization.
  Future<void> initialize(
      {bool generating = true,
      bool speechStart = true,
      bool typing = true}) async {
    /// Initialize sound for ai generating event
    if (generating) {
      await generatingPlayer.setReleaseMode(ReleaseMode.loop);
      // await generatingPlayer.setSource(AssetSource('audios/ai_generating.mp3'));
      await generatingPlayer.setSourceAsset('audios/ai_generating.mp3');
    }

    /// Initialize sound for speech start event
    if (speechStart) {
      await speechStartPlayer.setReleaseMode(ReleaseMode.stop);
      // await speechStartPlayer
      //     .setSource(AssetSource('audios/ai_speech_start.mp3'));
      await speechStartPlayer.setSourceAsset('audios/ai_speech_start.mp3');
    }

    /// Initialize sound for ai typing event
    if (typing) {
      await typingPlayer.setReleaseMode(ReleaseMode.loop);
      // await typingPlayer.setSource(AssetSource('audios/ai_typing.mp3'));
      await typingPlayer.setSourceAsset('audios/ai_typing.mp3');
    }
  }

  /// dispose resources
  void dispose() {
    generatingPlayer.dispose();
    speechStartPlayer.dispose();
    typingPlayer.dispose();
  }

  /// play generating sound effect
  playGeneratingSound() async {
    //  dog('AISoundController::playGeneratingSound');
    await generatingPlayer.seek(Duration.zero);
    await generatingPlayer.resume();
  }

  /// stop generating sound effect
  stopGeneratingSound() async {
    //  dog('AISoundController::stopAIGeneratingSound');
    await generatingPlayer.stop();
  }

  /// play typing sound effect
  playTypingSound() async {
    //  dog('AISoundController::playTypingSound');
    await typingPlayer.seek(Duration.zero);
    await typingPlayer.resume();
  }

  /// stop typing sound effect
  stopTypingSound() async {
    //  dog('AISoundController::stopTypingSound');
    await typingPlayer.stop();
  }

  /// play speech start sound effect
  /// No need to stop since it is too short
  playSpeechStartSound() async {
    await speechStartPlayer.seek(Duration.zero);
    await speechStartPlayer.resume();
  }
}

class SpeechToTextIconButton extends StatefulWidget {
  const SpeechToTextIconButton({
    super.key,
    required this.sttId,
    required this.onSpeech,
    this.onStatus,
    this.onError,
    this.onStartTap,
    this.onStopTap,
    this.size,
    this.margin = EdgeInsets.zero,
    this.visualDensity = VisualDensity.compact,
  });

  final String sttId;
  final Function(String speech) onSpeech;
  final Function(String status)? onStatus;
  final Future Function()? onStartTap;
  final Future Function()? onStopTap;
  final Function(SpeechRecognitionError error)? onError;
  final double? size;
  final EdgeInsets? margin;
  final VisualDensity visualDensity;

  @override
  State<SpeechToTextIconButton> createState() => _SpeechToTextIconButtonState();
}

class _SpeechToTextIconButtonState extends State<SpeechToTextIconButton> {
  SpeechToTextService get stts => SpeechToTextService.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    stts.dispose(widget.sttId);
    super.dispose();
  }

  init() async {
    await stts.init(
      sttId: widget.sttId,
      onResult: (result) => widget.onSpeech(result),
      onStatus: (status) async {
        // dog("SpeechToTextIconButton::onStatus: $status sttId::${widget.sttId}");
        if (mounted) setState(() {});
        await widget.onStatus?.call(status);
      },
      onError: (error) async {
        // dog("SpeechToTextIconButton::onError: $error");
        if (mounted) setState(() {});
        await widget.onError?.call(error);
      },
    );

    /// rebuild to update widget display if it is disable or enabled
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    /// speech is not was disabled
    if (stts.isNotAvailable) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: widget.margin,
      child:

          /// isListening
          (stts.isListening(widget.sttId))
              ?

              /// display stop button
              ClipOval(
                  child: Container(
                    color: Colors.red.withOpacity(0.1),
                    child: IconButton(
                      visualDensity: widget.visualDensity,
                      icon: Icon(Icons.stop, size: widget.size),
                      onPressed: () async {
                        // print('stop recording');
                        await widget.onStopTap?.call();
                        await stts.stopListening(widget.sttId);
                        setState(() {});
                      },
                    ),
                  ),
                )
              :

              /// display mic button
              IconButton(
                  visualDensity: widget.visualDensity,
                  icon: Icon(
                    Icons.mic,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: widget.size,
                  ),
                  onPressed: () async {
                    // print('start recording');

                    await widget.onStartTap?.call();
                    await stts.startListening(
                      sttId: widget.sttId,
                      pauseFor: const Duration(seconds: 3),
                    );
                    setState(() {});
                  },
                ),
    );
  }
}

class UserChatImageBubble extends StatelessWidget {
  const UserChatImageBubble({
    super.key,
    required this.chat,
  });

  final ChatBotModel chat;

  @override
  Widget build(BuildContext context) {
    if (chat.url.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 24),
        if (chat.client == true && chat.hasUrl) ...[
          Text(
            chat.createdAt?.short ?? '',
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: InkWell(
            onTap: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (_, __, ___) => PhotoViewer(
                  urls: [chat.url],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  width: 1.4,
                ),
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: chat.url,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Failed to display file...',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future chatAiLibrary() async {
  // Add your function code here!
}
