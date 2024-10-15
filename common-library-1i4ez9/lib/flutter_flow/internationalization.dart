import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ko'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? koText = '',
  }) =>
      [enText, koText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomeScreen
  {
    'jjxejav6': {
      'en': 'LEARN AI',
      'ko': '인공지능 공부',
    },
    'rhhufrz3': {
      'en': 'HOMEWORK AI',
      'ko': '숙제 인공지능',
    },
    '51w3ikz1': {
      'en': 'AI ASSISTANT',
      'ko': '인공지능 도우미',
    },
    'xnvg52m7': {
      'en': 'Learn AI',
      'ko': '인공지능 공부',
    },
    'ovwgw7bm': {
      'en': 'Have a fun journey into AI world!',
      'ko': '신나는 인공지능 세계로 모험을 떠나요',
    },
    '2mm0pcx5': {
      'en': 'Learn English',
      'ko': '영어 공부',
    },
    't6cwx7se': {
      'en': 'Let\'s learn English with fun and easy!',
      'ko': '쉬운 영어를 통해 전세계 친구들과 얘기해요',
    },
    'yihmhln3': {
      'en': 'Learn Math',
      'ko': '수학 공부',
    },
    'ggziq9ku': {
      'en': 'Give yourself confidence in math!',
      'ko': '머리 아픈 수학? 이제 자신있어요.',
    },
    'qkliz9ah': {
      'en': 'Listen to Music',
      'ko': '음악 듣기',
    },
    '553x8uwf': {
      'en': 'Sing and dance with your favorite idol!',
      'ko': '아이돌과 함께 신나는 노래와 댄스를...',
    },
    'iun4acmq': {
      'en': 'Page Title',
      'ko': '페이지 제목',
    },
    'aznlh5li': {
      'en': 'AI COOL',
      'ko': '아이쿨',
    },
    '4kv37tp3': {
      'en': 'Home',
      'ko': '홈',
    },
  },
  // MenuScreen
  {
    'mvbdht0c': {
      'en': 'Update your profile',
      'ko': '',
    },
    'gajdz5te': {
      'en': 'Update',
      'ko': '업데이트',
    },
    '0n1t9tyx': {
      'en': 'Menu',
      'ko': '메뉴',
    },
  },
  // PhoneSignInScreen
  {
    's5ms9o4v': {
      'en': 'Choose your country and log in with your phone number to sign in.',
      'ko': '국가를 선택하고 전화번호로 로그인하여 로그인하세요.',
    },
    '886rhyph': {
      'en': 'Phone Number',
      'ko': '전화 번호',
    },
    '86v231qi': {
      'en': 'Input phone number',
      'ko': '전화번호를 입력하세요.',
    },
    'chsbjlgp': {
      'en': '',
      'ko': '',
    },
    'k0np0sko': {
      'en': 'Send SMS Code',
      'ko': 'SMS 코드 전송',
    },
    'fgt4tyr5': {
      'en': 'Home',
      'ko': '홈',
    },
  },
  // ProfileEditScreen
  {
    'qrn3l3fb': {
      'en': 'Display Name',
      'ko': ' 이름',
    },
    '5xnh8ll8': {
      'en': 'TextField',
      'ko': '텍스트필드',
    },
    '8u4rcavq': {
      'en': 'Name',
      'ko': '이름',
    },
    'g7uis8rl': {
      'en': 'TextField',
      'ko': '텍스트필드',
    },
    '0c8njuua': {
      'en': 'Update',
      'ko': '업데이트',
    },
    'w42fxpyq': {
      'en': 'Update Profile',
      'ko': '프로필 업데이트',
    },
    'yzuefk56': {
      'en': 'Home',
      'ko': '',
    },
  },
  // PublicProfileScreen
  {
    '07k0qhgb': {
      'en': 'Report',
      'ko': '신고',
    },
    'qegnjs5t': {
      'en': 'Home',
      'ko': '',
    },
  },
  // ReportListScreen
  {
    'fmekdvfy': {
      'en': 'Report List Screen',
      'ko': '신고 목록',
    },
    'wybslxli': {
      'en': 'Home',
      'ko': '',
    },
  },
  // UserListScreen
  {
    'eihes2v1': {
      'en': 'UsersList',
      'ko': '사용자 목록',
    },
    'kpxmudj2': {
      'en': 'Home',
      'ko': '',
    },
  },
  // ChatAiScreen
  {
    'to2655fa': {
      'en': 'Chat Ai',
      'ko': '챗봇',
    },
    'ctrbsykb': {
      'en': 'AI',
      'ko': '인공지능',
    },
  },
  // HomeworkAiScreen
  {
    'ss406nxk': {
      'en': 'Homework Ai',
      'ko': '속제 도우미',
    },
    '1bm9fpo1': {
      'en': 'Homework',
      'ko': '숙제',
    },
  },
  // BlockListScreen
  {
    'ubfajokd': {
      'en': 'Blocked Users',
      'ko': '차단 목록',
    },
    'pkagr07n': {
      'en': 'Home',
      'ko': '',
    },
  },
  // PhonicsScreen
  {
    'gbxn10df': {
      'en': 'Phonics',
      'ko': '파닉스',
    },
    '0y93fu3c': {
      'en': 'Home',
      'ko': '',
    },
  },
  // MathLearningScreen
  {
    'w2ltco3p': {
      'en': 'Math Learning',
      'ko': '수학 공부',
    },
    'xs4xo7cx': {
      'en': 'Home',
      'ko': '',
    },
  },
  // MathLearnOperationScreen
  {
    '9ld508u0': {
      'en': 'Practice',
      'ko': '연습',
    },
    '19aprizs': {
      'en': 'Correct Answer. Great Job!',
      'ko': '정답! 잘했어요.',
    },
    '9pvqpg2l': {
      'en': 'Try again',
      'ko': '다시하기',
    },
    'ywzxdt9t': {
      'en': 'Enter your answer',
      'ko': '답을 입력하세요.',
    },
    '5ceqjzh9': {
      'en': 'Next',
      'ko': '다음',
    },
    'r866x7oc': {
      'en': 'Submit',
      'ko': '전송',
    },
    'tpzs1267': {
      'en': 'Next',
      'ko': '다음',
    },
    '6aue3zmd': {
      'en': 'Lesson Complete',
      'ko': '수업 끝',
    },
    '96dwjj26': {
      'en': 'Restart',
      'ko': '다시하기',
    },
    'kkv7digl': {
      'en': 'Home',
      'ko': '',
    },
  },
  // PhonicWordsScreen
  {
    'hvbnmzkg': {
      'en': 'Go Back',
      'ko': '돌아가기',
    },
    'xhvc53p0': {
      'en': 'Next',
      'ko': '다음',
    },
    '2klkjzoe': {
      'en': 'Home',
      'ko': '',
    },
  },
  // YoutubeViewScreen
  {
    'lmv5vt87': {
      'en': 'You might enjoy',
      'ko': '좋아 할 만한 영상',
    },
    'yup9q576': {
      'en': 'Youtube Video',
      'ko': '유튜브',
    },
    'vfqx8did': {
      'en': 'Home',
      'ko': '',
    },
  },
  // YoutubeListScreen
  {
    'w654dtgw': {
      'en': 'Home',
      'ko': '',
    },
  },
  // AILearningScreen
  {
    'je4t1pfl': {
      'en':
          'AI is a smart software for robots or computers. It helps you understand things and solve problems!',
      'ko': '인공지능은 로봇이나 컴퓨터에 들어가는 프로그램입니다. 어려운 문제를 쉽게 풀 수 있도록 도와주죠.',
    },
    '5p9fswph': {
      'en': 'What can I do with AI?',
      'ko': '인공지능으로 무엇을 할 수 있을까요?',
    },
    '0st7pyej': {
      'en':
          'You can use AI to help with your homework, or even talk to it like a friend!',
      'ko': '숙제를 하거나 친구 처럼 대화를 할 수 있습니다.',
    },
    'uqfs71gr': {
      'en': 'Can I try',
      'ko': '인공지능을 체험해 볼래요?',
    },
    'hc7rhdzi': {
      'en': 'Yes, you can use AI right now!',
      'ko': '네, 지금 바로 인공지능을 체험해 보세요.',
    },
    'idvfgk59': {
      'en': 'AI Learning',
      'ko': '인공지능 공부',
    },
    'pun8b3s4': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // LearningScreen
  {
    'uj28educ': {
      'en': 'Learning Screen',
      'ko': '공부',
    },
    '1dps817t': {
      'en': 'Learn',
      'ko': '공부',
    },
  },
  // ResignScreen
  {
    '6qvgz0ka': {
      'en':
          'Deleting your account is a permanent action that cannot be undone. All your data, homework, personal information, etc. will be permanently erased.',
      'ko': '회원 탈퇴를 하시면 회원님의 데이터가 모두 사라지며 복구 할 수 없습니다.',
    },
    '69uwlcky': {
      'en': 'Resign and Delete account',
      'ko': '회원 탈퇴',
    },
    'dqk8anao': {
      'en': 'Resign',
      'ko': '탈퇴',
    },
    'w5vceq5g': {
      'en': 'Home',
      'ko': '',
    },
  },
  // StateEditScreen
  {
    'wox1jbxf': {
      'en': 'Upload your state photo',
      'ko': '백그라운드 사진 등록',
    },
    'z3briy9u': {
      'en': 'View',
      'ko': '보기',
    },
    'c3nm7erf': {
      'en': 'State Message: How are you now?',
      'ko': '상태 메시지 등록: 오늘 기분이 어떠신가요?',
    },
    '7rc5c96l': {
      'en': 'Save',
      'ko': '저장',
    },
    'xodx1b7q': {
      'en': 'Home',
      'ko': '',
    },
  },
  // SMSVerificationScreen
  {
    'fxapp3ca': {
      'en': '',
      'ko': '',
    },
    'on83u9it': {
      'en': '000000',
      'ko': '000000',
    },
    '7mj249d4': {
      'en': '',
      'ko': '',
    },
    'prhuhca5': {
      'en': 'Verify SMS Code',
      'ko': 'SMS 코드 확인',
    },
    '75q40pw9': {
      'en': 'Cancel',
      'ko': '취소',
    },
    'o8gwkupj': {
      'en': 'SMS Verification',
      'ko': 'SMS 인증 확인',
    },
    'orrge4ua': {
      'en': 'Home',
      'ko': '',
    },
  },
  // TermsAndConditionScreen
  {
    'c93yt7b4': {
      'en':
          'Please, review and agree to the terms and conditions to proceed with login.',
      'ko': '가입약관을 확인해 주세요.',
    },
    'exphl8zg': {
      'en':
          'Chapter 1: General Provisions\n\nArticle 1 (Purpose)\nThese terms and conditions aim to establish the basic matters regarding the conditions and procedures for using the AICOOL service (hereinafter referred to as \"the Service\") operated by Withcenter (hereinafter referred to as \"the Company\").\n\nArticle 2 (Effectiveness and Amendment of Terms)\n\nThese terms and conditions take effect upon notification to users on the login screen or other screens.\nThe Company may amend these terms and conditions, and the amended terms and conditions will take effect by being notified or announced in the same manner as specified in Paragraph 1.\nArticle 3 (Definition of Terms)\nThe definitions of terms used in these terms and conditions are as follows:\n\n\"Member\": An individual or organization that logs in (or registers) to use the Company’s services.\n\"Applicant\": An individual or organization that applies for membership.\n\"Termination\": The cancellation of the service use agreement by the Company or the member.\n\n\nChapter 2: Service Use Agreement\n\nArticle 4 (Establishment of the Use Agreement)\n\nBy clicking the agreement button at the bottom of the terms and conditions, it is considered that the user agrees to these terms.\nThe use agreement is established when the service applicant agrees to the terms and conditions and the site approves the use request.\nArticle 5 (Application for Use)\n\nTo use the Service, the applicant must submit user information in the prescribed form.\nAll user information entered in the membership form is considered to be real data. Users who do not enter their real name or actual information will not receive legal protection and may face service restrictions.\nArticle 6 (Approval of Use Application)\n\nThe Company approves the service use application, except for cases falling under Paragraphs 2 and 3.\nThe Company may withhold approval until the reason for the restriction is resolved if:\na. There is no spare capacity in the service facilities.\nb. There are technical difficulties.\nc. The Company deems it necessary.\nThe Company may refuse approval if the applicant:\na. Applies using another individual’s name.\nb. Submits false user information.\nc. Applies with the intent to disrupt public order or good morals.\nd. Does not meet other service application requirements specified by the site.\nArticle 7 (Change of User Information)\nMembers must update their information online if there are changes to the information entered at the time of application. The member is responsible for any issues that arise from not updating their information.\n\nChapter 3: Obligations of the Contracting Parties\n\nArticle 8 (Obligations of the Company)\n\nThe Company provides the following services to members:\na. A service allowing members to communicate with other members within the Service.\nb. A service enabling members to freely share information through a bulletin board function.\nc. A chat function allowing members to converse with each other.\nThe Company shall not disclose, distribute, or use members’ personal information obtained in connection with providing the Service for commercial purposes without the member’s consent, except in the following cases:\na. When required by law, such as the Telecommunications Basic Act.\nb. For the purpose of criminal investigation or at the request of the Information and Communication Ethics Committee.\nc. When requested according to procedures prescribed by other relevant laws.\nThe Company has an obligation to continuously and stably provide the Service as stipulated in these terms.\nArticle 9 (Obligations of the Member)\n\nWhen using the Service, members must not engage in the following actions:\na. Fraudulently use other members’ information.\nb. Reproduce, alter, publish, or broadcast information obtained from the Service for purposes other than personal use without prior consent from the Company.\nc. Infringe on the Company’s or others’ copyrights or other rights.\nd. Distribute information, text, or images that violate public order or good morals.\ne. Engage in actions objectively judged to be related to crime.\nf. Engage in other actions that violate relevant laws.\nMembers must comply with relevant laws, these terms and conditions, the Service’s usage guide, and other notices.\nMembers must comply with usage restrictions specified in the Service notices or separately announced by the site.\n\n\nChapter 4: Provision and Use of Service\n\nArticle 10 (Member’s Responsibility for Managing Login Information)\n\nMembers are responsible for managing their login information. Members are fully responsible for any consequences arising from unauthorized use of their login information.\nIf their login information is used improperly or if there is a security breach, members must notify the Company immediately.\n\n\nArticle 11 (Service Restriction and Suspension)\n\nThe Company may restrict or suspend the Service in whole or in part if a state of national emergency occurs or is expected to occur due to war, disaster, or other force majeure events, or if a telecommunication service is suspended by a basic telecommunication business operator under the Telecommunications Business Act.\nWhen restricting or suspending the Service under Paragraph 1, the Company must notify the member of the reason and the restriction period without delay.\n\n\nChapter 5: Change and Termination of the Contract\n\nArticle 12 (Change of Information)\nMembers can change their customer information, such as their address, using the Service’s member information modification function.\n\nArticle 13 (Termination of the Contract)\nMembers may terminate the service use agreement, and in such cases, they must apply for termination directly through the Service, by phone, or online to the Company. The Company will restrict the member\'s use of the Service from the date the termination application is received. The Company must notify the member of the intention to terminate at least seven days in advance if it intends to terminate the use agreement for the following reasons, giving the member an opportunity to explain:\n\nIf the member violates the usage restrictions and fails to resolve the reasons for the restriction within the restriction period.\nIf the Information and Communication Ethics Committee requests termination.\nIf the member fails to respond to requests for opinions without a valid reason.\nIf the member applies under another person\'s name or provides false information on the application form, or attaches false documents when entering into the use agreement.\nThe Company may restrict the re-registration of a terminated user for a separately prescribed period.\nChapter 6: Compensation for Damages\n\nArticle 14 (Disclaimer)\n\nThe Company is not responsible for any damages arising from members not obtaining the expected benefits from the Service or from selecting or using Service materials.\nThe Company is not responsible for any failures in the Service or data damage caused by members\' negligence or the deliberate acts of third parties.\nThe Company is not responsible for the content of materials posted or transmitted by members.\nIf members upload or transmit content that infringes on trademark or copyright, they are responsible for any damages or compensation that may arise, and the Company is not liable for any such issues.\nThe Company is not responsible for any issues that arise between project clients and developers.\n\nArticle 15 (Jurisdiction)\nIn case of any disputes between the Company and members regarding the Service, the court with jurisdiction over the Company’s location shall have jurisdiction.\n\n[Supplementary Provisions]\n\n(Effective Date) These terms and conditions are effective as of August 1, 2024.',
      'ko':
          '제 1 장 총 칙\n\n제 1 조 (목적)\n이 약관은 위세너(이하 \"본사\"라 합니다)에서 운영하는 앱인 아이쿨(이하 \"서비스\"라 합니다)의 이용 조건 및 절차에 관한 기본적인 사항을 규정함을 목적으로 합니다.\n\n제 2 조 (약관의 효력 및 변경)\n① 이 약관은 로그인 화면 및 기타 화면에서 이용고객에게 공지함으로써 효력을 발생합니다.\n② 본사는 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.\n\n제 3 조 (용어의 정의)\n이 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n① 회원 : 본사의 서비스를 이용하기 위해 로그인(또는 가입)하는 개인 또는 단체를 말합니다.\n② 신청자 : 회원가입을 신청하는 개인 또는 단체를 말합니다.\n③ 해지 : 본사 또는 회원이 서비스 이용계약을 취소하는 것을 말합니다.\n\n제 2 장 서비스 이용계약\n\n제 4 조 (이용계약의 성립)\n① 이용약관 하단의 동의 버튼을 누르면 이 약관에 동의하는 것으로 간주됩니다.\n② 이용계약은 서비스 이용희망자의 이용약관 동의 후 이용 신청에 대하여 사이트가 승낙함으로써 성립합니다.\n\n제 5 조 (이용신청)\n① 신청자가 본 서비스를 이용하기 위해서는 소정의 양식에서 요구하는 이용자 정보를 기록하여 제출해야 합니다.\n② 회원 정보 양식에 기재하는 모든 이용자 정보는 모두 실제 데이터인 것으로 간주됩니다. 실명이나 실제 정보를 입력하지 않은 사용자는 법적인 보호를 받을 수 없으며, 서비스의 제한을 받을 수 있습니다.\n\n제 6 조 (이용신청의 승낙)\n① 본사는 신청자에 대하여 제2항, 제3항의 경우를 예외로 하여 서비스 이용신청을 승낙합니다.\n② 본사는 다음에 해당하는 경우에 그 신청에 대한 승낙 제한사유가 해소될 때까지 승낙을 유보할 수 있습니다.\n가. 서비스 관련 설비에 여유가 없는 경우\n나. 기술상 지장이 있는 경우\n다. 기타 본사가 필요하다고 인정되는 경우\n③ 본사는 신청자가 다음에 해당하는 경우에는 승낙을 거부할 수 있습니다.\n가. 다른 개인(서비스)의 명의를 사용하여 신청한 경우\n나. 이용자 정보를 허위로 기재하여 신청한 경우\n다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우\n라. 기타 사이트 소정의 이용신청요건을 충족하지 못하는 경우\n\n제 7 조 (이용자정보의 변경)\n회원은 이용 신청시에 기재했던 회원정보가 변경되었을 경우에는, 온라인으로 수정하여야 하며 변경하지 않음으로 인하여 발생되는 모든 문제의 책임은 회원에게 있습니다.\n\n제 3 장 계약 당사자의 의무\n\n제 8 조 (본사의 의무)\n① 본사는 회원에게 각 호의 서비스를 제공합니다.\n가. 회원이 서비스 내에서 다른 회원과 소통할 수 있는 서비스\n나. 게시판 기능을 통해 회원들이 자유롭게 정보를 공유할 수 있는 서비스\n다. 채팅 기능을 통해 회원들이 대화 할 수 있는 서비스\n② 본사는 서비스 제공과 관련하여 취득한 회원의 개인정보를 회원의 동의없이 타인에게 누설, 공개 또는 배포할 수 없으며, 서비스관련 업무 이외의 상업적 목적으로 사용할 수 없습니다. 단, 다음 각 호의 1에 해당하는 경우는 예외입니다.\n가. 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우\n나. 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우\n다. 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우\n③ 본사는 이 약관에서 정한 바에 따라 지속적, 안정적으로 서비스를 제공할 의무가 있습니다.\n\n제 9 조 (회원의 의무)\n① 회원은 서비스 이용 시 다음 각 호의 행위를 하지 않아야 합니다.\n가. 다른 회원의 정보를 부정하게 사용하는 행위\n나. 서비스에서 얻은 정보를 본사의 사전승낙 없이 회원의 이용 이외의 목적으로 복제하거나 이를 변경, 출판 및 방송 등에 사용하거나 타인에게 제공하는 행위\n다. 본사의 저작권, 타인의 저작권 등 기타 권리를 침해하는 행위\n라. 공공질서 및 미풍양속에 위반되는 내용의 정보, 문장, 도형 등을 타인에게 유포하는 행위\n마. 범죄와 결부된다고 객관적으로 판단되는 행위\n바. 기타 관계법령에 위배되는 행위\n② 회원은 관계법령, 이 약관에서 규정하는 사항, 서비스 이용 안내 및 주의 사항을 준수하여야 합니다.\n③ 회원은 내용별로 사이트가 서비스 공지사항에 게시하거나 별도로 공지한 이용 제한 사항을 준수하여야 합니다.\n\n제 4 장 서비스 제공 및 이용\n\n제 10 조 (회원 로그인 정보 관리에 대한 회원의 의무)\n① 회원 로그인 정보에 대한 모든 관리는 회원에게 책임이 있습니다. 회원 로그인 부정사용에 의하여 발생하는 모든 결과에 대한 전적인 책임은 회원에게 있습니다.\n② 자신의 로그인 정보가 부정하게 사용된 경우 또는 기타 보안 위반에 대하여, 회원은 반드시 본사에 그 사실을 통보해야 합니다.\n\n제 11 조 (서비스 제한 및 정지)\n① 본사는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신 사업자가 전기통신서비스를 중지하는 등 기타 불가항력적 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.\n② 본사는 제1항의 규정에 의하여 서비스의 이용을 제한하거나 정지할 때에는 그 사유 및 제한기간 등을 지체없이 회원에게 알려야 합니다.\n\n제5장 계약사항의 변경, 해지\n\n제 12 조 (정보의 변경)\n회원이 주소 등 고객정보를 변경하고자 하는 경우에는 서비스의 회원정보 변경 기능을 이용하여 변경할 수 있습니다. \n\n제 13 조 (계약사항의 해지)\n회원은 서비스 이용계약을 해지할 수 있으며, 해지할 경우에는 본인이 직접 서비스를 통하거나 전화 또는 온라인 등으로 본사에 해지신청을 하여야 합니다. 본사는 해지신청이 접수된 당일부터 해당 회원의 서비스 이용을 제한합니다. 본사는 회원이 다음 각 항의 1에 해당하여 이용계약을 해지하고자 할 경우에는 해지조치 7일전까지 그 뜻을 이용고객에게 통지하여 소명할 기회를 주어야 합니다.\n① 이용고객이 이용제한 규정을 위반하거나 그 이용제한 기간 내에 제한 사유를 해소하지 않는 경우\n② 정보통신윤리위원회가 이용해지를 요구한 경우\n③ 이용고객이 정당한 사유 없이 의견진술에 응하지 아니한 경우\n④ 타인 명의로 신청을 하였거나 신청서 내용의 허위 기재 또는 허위서류를 첨부하여 이용계약을 체결한 경우\n본사는 상기 규정에 의하여 해지된 이용고객에 대해서는 별도로 정한 기간동안 가입을 제한할 수 있습니다.\n\n제6장 손해배상\n\n제 14 조 (면책조항)\n① 본사는 회원이 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.\n② 본사는 회원의 귀책사유나 제3자의 고의로 인하여 서비스에 장애가 발생하거나 회원의 데이터가 훼손된 경우에 책임이 면제됩니다.\n③ 본사는 회원이 게시 또는 전송한 자료의 내용에 대해서는 책임이 면제됩니다.\n④ 상표권 또는 저작권이 있는 콘텐츠를 업로드 또는 전송한 경우, 이로 인해 발생할 수 있는 손해나 배상에 대한 책임은 회원 당사자에게 있으며, 본사는 이에 대한 일체의 책임을 지지 않습니다.\n⑤ 본사는 프로젝트 의뢰인과 개발자 사이에서 발생하는 문제에 대해서 책임을 지지 않습니다.\n\n제 15 조 (관할법원)\n서비스와 관련하여 본사와 회원간에 분쟁이 발생할 경우 본사 소재지를 관할하는 법원을 관할법원으로 합니다.\n\n[부칙]\n\n(시행일) 이 약관은 2024년 8월 1일 부터 시행합니다.',
    },
    'd0euq11p': {
      'en': 'Go Back',
      'ko': '돌아가기',
    },
    'p3miop90': {
      'en': 'Agree',
      'ko': '동의',
    },
    'y9xj5msu': {
      'en': 'Terms and Conditions',
      'ko': '이용약관',
    },
    '7ofmnmdh': {
      'en': 'Agree',
      'ko': '동의합니다.',
    },
    'fxcueizi': {
      'en': 'Home',
      'ko': '집',
    },
  },
  // AboutScreen
  {
    'hqc3q3mq': {
      'en': 'About AI Cool',
      'ko': '',
    },
    'qut8fcg9': {
      'en': 'Home',
      'ko': '',
    },
  },
  // PrivacyPolicyScreen
  {
    'mpo8hfhu': {
      'en':
          '<Withcenter> (hereinafter referred to as \"https://sonub.com\") establishes and discloses personal information processing policies as follows to protect personal information of information subjects and to handle related grievances quickly and smoothly pursuant to Article 30 of the Personal Information Protection Act.\n\n○ This personal information processing policy will be applied from December 1, 2022.\n\n\nArticle 1 (Purpose of Processing Personal Information)\n\n<Withcenter> (\"https://sonub.com\") processes personal information for the following purposes: The personal information being processed will not be used for any of the following purposes, and if the purpose of use is changed, necessary measures will be implemented, such as obtaining separate consent under Article 18 of the Personal Information Protection Act.\n\n1. Registering and managing membership on the website\n\nPersonal information is processed for the purpose of confirming your intention to join the membership.\n\n\n2. Providing goods or services\n\nWe process personal information for the purpose of providing services.\n\n\nArticle 2 (Processing and Retaining Period of Personal Information)\n\n① <Withcenter> processes and holds personal information within the period of holding and using personal information under the Act or the period of holding and using personal information agreed upon when collecting personal information from the data subject.\n\n② Each personal information processing and holding period is as follows.\n\n1.<Provide goods or services>\nCollection of personal information related to the provision of goods or services.Held for the above purpose of use from the date of consent for use to <3 years>.It\'s being used.\nGrounds for possession: Records on the handling of consumer complaints or disputes\nRelated Acts and subordinate statutes: Records on the handling of consumer complaints or disputes: 3 years\n\n\nArticle 3 (items of personal information to be processed)\n\n① <Withcenter> is processing the following personal information items:\n\n1<Registration and management of homepage>\nRequired items: Email, mobile phone number, name\nSelection: Gender, Date of Birth\n\n\nArticle 4 (Procedure and Method of Destruction of Personal Information)\n\n\n① <Withcenter> destroys the personal information without delay when personal information becomes unnecessary, such as the lapse of the personal information retention period and the achievement of the purpose of processing.\n\n② If the personal information retention period agreed by the data subject has elapsed or the purpose of processing has been achieved, the personal information shall be transferred to a separate database (DB) or stored in a different storage place.\n\n\n③ The procedures and methods of destroying personal information are as follows.\n1. Destruction procedure\n<Withcenter> selects personal information that causes destruction, and destroys personal information with the approval of <Withcenter>\'s personal information protection manager.\n\n2. Destruction method\n\nInformation in the form of electronic files uses a technical method that cannot be played back\n\n\n\nArticle 5 (Matters concerning the rights and obligations of the information subject and legal representative, and the method of exercising them)\n\n\n\n① The information subject may exercise the right to view, correct, delete, and request suspension of processing personal information at any time.\n\n② The exercise of rights under paragraph (1) can be made in writing, e-mail, facsimile (FAX), etc. in accordance with Article 41 (1) of the Enforcement Decree of the Personal Information Protection Act, and We will take action against it without delay.\n\n③ The exercise of rights under paragraph (1) may be conducted through an agent, such as a legal representative of the information subject or a person entrusted.In such cases, \"Public Notice on the Method of Processing Personal Information (No. 2020-7)\" You must submit a power of attorney in attached Form 11.\n\n④ Requests for access to personal information and suspension of processing may be restricted under Articles 35 (4) and 37 (2) of the Personal Information Protection Act.\n\n⑤ A request for correction and deletion of personal information cannot be requested if the personal information is specified as the subject of collection in other laws and regulations.\n\n⑥ Withcenter verifies whether the person who made the request for perusal, correction and deletion according to the right of the information subject, and inspection when requesting suspension of processing, is the person himself or a legitimate agent.\n\n\n\nArticle 6 (Matters concerning measures to secure the safety of personal information)\n\n<Withcenter> is taking the following measures to ensure the safety of personal information.\n\n1. Establishing and implementing an internal management plan\nFor the safe processing of personal information, an internal management plan is established and implemented.\n\n2. Technical countermeasures against hacking, etc\nTo prevent personal information leakage and damage caused by hacking or computer viruses, <Withcenter> (\'Sonaub\') installs security programs, updates and inspects regularly, and installs systems in areas where access is controlled from outside, and monitors and blocks them technically/physically.\n\n3. Access control for unauthorized persons\nWe have established and operated access control procedures for separately storing personal information.\n\n\n\nArticle 7 (Matters concerning the installation and operation of devices that automatically collect personal information and their refusal)\n\nWithcenter does not use \'cookie\', which stores information on the use of information subjects and calls them from time to time.\n\n\nArticle 8 (Matters concerning the collection, use, provision, rejection, etc. of behavioral information)\n\nMatters concerning the collection, use, provision, rejection, etc. of behavioral information;\n\n<Personal Information Controller Name> does not collect, use, or provide behavioral information for online customized advertisements.\n\nArticle 9 (Matters concerning the person in charge of personal information protection)\n\n① Withcenter is in charge of personal information processing, and designates a person in charge of personal information protection as follows to handle complaints and remedy damages by information subjects related to personal information processing.\n\n▶ Person in charge of personal information protection\nName: Song Jae-ho\nPosition: Representative\nPosition: Representative\nContact :010-8693-4225, thruthesky@gmail.com\n※ You will be connected to the department responsible for privacy.\n\n▶ Personal Information Protection Department\nDepartment name: Management office\nPerson in charge: Song Jae-ho\n연락처 :010-8693-4225, thruthesky@gmail.com\n② The information subject can contact the person in charge of personal information protection and the department in charge of personal information protection for all personal information protection inquiries, complaints, and damage relief that occurred while using Withcenter\'s service (or business). Withcenter will respond and process your inquiry without delay.\n\nArticle 10 (Department that receives and processes requests for access to personal information)\nThe information subject may request the following departments for access to personal information under Article 35 of the ｢ Personal Information Protection Act.\n<Withcenter> will try to expedite the request for access to personal information by the information subject.\n\n\nArticle 11 (Method of remedy for infringement of rights and interests of information subjects)\n\nIn order to receive relief from personal information infringement, information entities can apply for dispute resolution or counseling to the Personal Information Dispute Mediation Committee and the Korea Internet & Security Agency\'s Personal Information Infringement Reporting Center. In addition, please contact the institution below for other reports and consultations on personal information infringement.\n\n1. Personal Information Dispute Mediation Committee: (without national number) 1833-6972 (www.kopico.go.kr)\n2. Personal Information Infringement Reporting Center: 118 (privacy.kisa.or.kr)\n3. Supreme Prosecutors\' Office: 1301 (www.spo.go.kr)\n4. National Police Agency: 182 (ecrm.cyber.go.kr)\n\nA person who has been infringed on his/her rights or interests due to disposition or omission by the head of a public institution in response to a request under Articles 35 (Personal Information Access), 36 (Correction or Deletion of Personal Information, etc.) of the Personal Information Protection Act may request an administrative trial as prescribed by the Administrative Appeals Act.\n\n※ For more information on administrative trials, please refer to the website of the Central Administrative Appeals Commission (www.simpan.go.kr).\n\nArticle 12 (Matters concerning the processing of pseudonymous information in case of processing pseudonymous information)\n\n< Withcenter > processes pseudonymous information for the following purposes.\n\n▶ Purpose of processing pseudonymous information\n\n- Can be written directly.\n\n▶ Processing and retention period of pseudonymous information\n\n- Can be written directly.\n\n▶ Matters concerning the provision of pseudonymous information to third parties (to be completed only if applicable)\n\n- Can be written directly.\n\n▶ Matters concerning consignment of pseudonymous information processing (to be completed only if applicable)\n\n- Can be written directly.\n\n▶ Items of personal information subject to pseudonymization\n\n- Can be written directly.\n\n▶ Matters concerning measures to ensure the safety of pseudonymous information in accordance with Article 28-4 of the Act (duty of safety measures for pseudonymous information, etc.)\n\n- Can be written directly.\n\nArticle 13 (Matters on Person in Charge of Personal Information Protection)\n\n① Withcenter is responsible for overall handling of personal information, and has designated the person in charge of personal information protection as follows to handle complaints and damage relief of information subjects related to personal information processing.\n\n▶ Person in charge of personal information protection\nName: Song Jae-ho\nPosition: Representative\nPosition : Representative\nContact:010-8693-4225, thruthesky@gmail.com,\n※ You will be connected to the department in charge of personal information protection.\n\n\n▶ Department in charge of personal information protection\nDepartment name : Planning\nPerson in charge: Song Jae-ho\nContact:010-8693-4225, thruthesky@gmail.com,\n② The information subject may inquire about personal information protection related inquiries, complaint handling, damage relief, etc. that occurred while using Withcenter\'s service (or business) to the person in charge of personal information protection and the department in charge. Withcenter will respond to and process inquiries from information subjects without delay.\n\nArticle 14 (Department that receives and handles requests for access to personal information)\nThe information subject may request the viewing of personal information in accordance with Article 35 of the Personal Information Protection Act to the following departments.\n< Withcenter > will make efforts to promptly process the personal information access request of the information subject.\n\n▶ Personal information viewing request reception and processing department\nDepartment Name: Administration\nPerson in charge: Song Jae-ho\nContact: 010-8693-4225, thruthesky@gmail.com\n\n\nArticle 15 (Method of Remedy for Infringement of Rights and Interests of Information Subjects)\n\n\nThe information subject can apply for dispute resolution or consultation to the Personal Information Dispute Mediation Committee and the Personal Information Infringement Reporting Center of the Korea Internet & Security Agency in order to receive relief from personal information infringement. In addition, please contact the following organizations for reporting or consulting of other personal information infringement.\n\n1. Personal Information Dispute Mediation Committee: (without area code) 1833-6972 (www.kopico.go.kr)\n2. Personal information infringement reporting center: (without area code) 118 (privacy.kisa.or.kr)\n3. Supreme Prosecutors\' Office: (without area code) 1301 (www.spo.go.kr)\n4. National Police Agency: (without area code) 182 (ecrm.cyber.go.kr)\n\nIn response to requests under the provisions of Article 35 (Access to Personal Information), Article 36 (Correction/Deletion of Personal Information), and Article 37 (Suspension of Processing of Personal Information, etc.) of the 「Personal Information Protection Act」, the head of a public institution A person whose rights or interests have been infringed upon due to a disposition or omission may request an administrative appeal in accordance with the Administrative Appeals Act.\n\n※ Please refer to the website of the Central Administrative Appeals Commission (www.simpan.go.kr) for details on administrative adjudication.\n\nArticle 16 (Matters Regarding the Operation and Management of Video Information Processing Devices)\n① <Withcenter> installs and operates the following image information processing devices.\n\n1. Basis/Purpose of Installation of Video Information Processing Equipment: Describes the installation and purpose of the video information processing equipment of <Withcenter>.\n\n2. Number of installations, installation location, shooting range:\nNumber of installations: 1 unit\nInstallation location: front door\nShooting range: Inside the office\n3. Person in charge of management, department in charge, and person with access to image information: Song Jae-ho\n\n4. Video information recording time, storage period, storage location, processing method\nShooting time: 168 hours\nStorage period: 1 week from the time of shooting\nStorage location and processing method: Crowd\n5. How and where to check video information: Mobile phone app\n\n6. Measures against the information subject\'s request, such as viewing video information: Requests for personal image information viewing/existence confirmation must be made, and when the information subject himself/herself is filmed or is clearly necessary for the interests of the information subject\'s life, body, and property Allowed to view for one year\n\n7. Technical, administrative, and physical measures to protect image information:\n\n\nArticle 17 (Change of Privacy Policy)\n\n① This privacy policy will be applied from Aug 1, 2024.',
      'ko':
          '< 위세너 >는 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.\n\n○ 이 개인정보처리방침은 2022년 10월 26부터 적용됩니다.\n\n\n제1조(개인정보의 처리 목적)\n\n< 위세너 >는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.\n\n1. 홈페이지 회원가입 및 관리\n\n회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 서비스 부정이용 방지, 각종 고지·통지 목적으로 개인정보를 처리합니다.\n\n\n2. 재화 또는 서비스 제공\n\n회원과의 소통을 위한 목적으로 개인정보를 처리합니다.\n\n\n3. 마케팅 및 광고에의 활용\n\n신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공 등을 목적으로 개인정보를 처리합니다.\n\n\n\n\n제2조(개인정보의 처리 및 보유 기간)\n\n① < 위세너 >은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.\n\n② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.\n\n1.<마케팅 및 광고에의 활용>\n<마케팅 및 광고에의 활용>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<3년>까지 위 이용목적을 위하여 보유.이용됩니다.\n보유근거 : 재가입 방지 목적\n관련법령 : 1)신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년\n2) 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년\n3) 대금결제 및 재화 등의 공급에 관한 기록 : 5년\n4) 계약 또는 청약철회 등에 관한 기록 : 5년\n예외사유 :\n\n\n제3조(처리하는 개인정보의 항목)\n\n① < 위세너 >은(는) 다음의 개인정보 항목을 처리하고 있습니다.\n\n1< 홈페이지 회원가입 및 관리 >\n필수항목 : 없음\n선택항목 : 이메일, 이름, 전화번호, 성별, 생년월일\n\n\n제4조(만 14세 미만 아동의 개인정보 처리에 관한 사항)\n\n\n\n① <개인정보처리자명>은(는) 만 14세 미만 아동에 대해 개인정보를 수집할 때 법정대리인의 동의를 얻어 해당 서비스 수행에 필요한 최소한의 개인정보를 수집합니다.\n\n• 필수항목 : 법정 대리인의 성명, 관계, 연락처\n\n② 또한, <개인정보처리자명>의 <처리목적> 관련 홍보를 위해 아동의 개인정보를 수집할 경우에는 법정대리인으로부터 별도의 동의를 얻습니다.\n\n③ <개인정보처리자명>은(는) 만 14세 미만 아동의 개인정보를 수집할 때에는 아동에게 법정대리인의 성명, 연락처와 같이 최소한의 정보를 요구할 수 있으며, 다음 중 하나의 방법으로 적법한 법정대리인이 동의하였는지를 확인합니다.\n\n• 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 개인정보처리자가 그 동의 표시를 확인했음을 법정대리인의 휴대전화 문자 메시지로 알리는 방법\n\n• 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 법정대리인의 신용카드·직불카드 등의 카드정보를 제공받는 방법\n\n• 동의 내용을 게재한 인터넷 사이트에 법정대리인이 동의 여부를 표시하도록 하고 법정대리인의 휴대전화 본인인증 등을 통해 본인 여부를 확인하는 방법\n\n• 동의 내용이 적힌 서면을 법정대리인에게 직접 발급하거나, 우편 또는 팩스를 통하여 전달하고 법정대리인이 동의 내용에 대하여 서명날인 후 제출하도록 하는 방법\n\n• 동의 내용이 적힌 전자우편을 발송하여 법정대리인으로부터 동의의 의사표시가 적힌 전자우편을 전송받는 방법\n\n• 전화를 통하여 동의 내용을 법정대리인에게 알리고 동의를 얻거나 인터넷주소 등 동의 내용을 확인할 수 있는 방법을 안내하고 재차 전화 통화를 통하여 동의를 얻는 방법\n\n• 그 밖에 위와 준하는 방법으로 법정대리인에게 동의 내용을 알리고 동의의 의사표시를 확인하는 방법\n\n\n\n제5조(개인정보의 제3자 제공에 관한 사항)\n\n① < 위세너 >은(는) 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 「개인정보 보호법」 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.\n\n\n제6조(개인정보의 파기절차 및 파기방법)\n\n\n① < 위세너 > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.\n\n② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.\n1. 법령 근거 :\n2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜\n\n③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.\n1. 파기절차\n< 위세너 > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < 위세너 > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.\n\n2. 파기방법\n\n전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다\n\n\n\n제7조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)\n\n\n\n① 정보주체는 위세너에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.\n\n② 제1항에 따른 권리 행사는위세너에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 위세너은(는) 이에 대해 지체 없이 조치하겠습니다.\n\n③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.\n\n④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.\n\n⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.\n\n⑥ 위세너은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.\n\n\n\n제8조(개인정보의 안전성 확보조치에 관한 사항)\n\n< 위세너 >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n\n1. 정기적인 자체 감사 실시\n개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.\n\n2. 해킹 등에 대비한 기술적 대책\n<위세너>는 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.\n\n3. 접속기록의 보관 및 위변조 방지\n개인정보처리시스템에 접속한 기록을 최소 1년 이상 보관, 관리하고 있으며,다만, 5만명 이상의 정보주체에 관하여 개인정보를 추가하거나, 고유식별정보 또는 민감정보를 처리하는 경우에는 2년이상 보관, 관리하고 있습니다.\n또한, 접속기록이 위변조 및 도난, 분실되지 않도록 보안기능을 사용하고 있습니다.\n\n4. 개인정보에 대한 접근 제한\n개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.\n\n\n\n\n제9조(개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항)\n\n\n\n① 위세너 은(는) 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.\n② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.\n가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.\n나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.\n다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.\n\n\n제10조(행태정보의 수집·이용·제공 및 거부 등에 관한 사항)\n\n\n\n행태정보의 수집·이용·제공 및 거부등에 관한 사항\n\n<개인정보처리자명>은(는) 온라인 맞춤형 광고 등을 위한 행태정보를 수집·이용·제공하지 않습니다.\n\n\n\n제11조(추가적인 이용·제공 판단기준)\n\n< 위세너 > 은(는) ｢개인정보 보호법｣ 제15조제3항 및 제17조제4항에 따라 ｢개인정보 보호법 시행령｣ 제14조의2에 따른 사항을 고려하여 정보주체의 동의 없이 개인정보를 추가적으로 이용·제공할 수 있습니다.\n이에 따라 < 위세너 > 가(이) 정보주체의 동의 없이 추가적인 이용·제공을 하기 위해서 다음과 같은 사항을 고려하였습니다.\n▶ 개인정보를 추가적으로 이용·제공하려는 목적이 당초 수집 목적과 관련성이 있는지 여부\n\n▶ 개인정보를 수집한 정황 또는 처리 관행에 비추어 볼 때 추가적인 이용·제공에 대한 예측 가능성이 있는지 여부\n\n▶ 개인정보의 추가적인 이용·제공이 정보주체의 이익을 부당하게 침해하는지 여부\n\n▶ 가명처리 또는 암호화 등 안전성 확보에 필요한 조치를 하였는지 여부\n\n※ 추가적인 이용·제공 시 고려사항에 대한 판단기준은 사업자/단체 스스로 자율적으로 판단하여 작성·공개함\n\n\n\n제12조(가명정보를 처리하는 경우 가명정보 처리에 관한 사항)\n\n< 위세너 > 은(는) 다음과 같은 목적으로 가명정보를 처리하고 있습니다.\n\n▶ 가명정보의 처리 목적\n\n- 직접작성 가능합니다.\n\n▶ 가명정보의 처리 및 보유기간\n\n- 직접작성 가능합니다.\n\n▶ 가명정보의 제3자 제공에 관한 사항(해당되는 경우에만 작성)\n\n- 직접작성 가능합니다.\n\n▶ 가명정보 처리의 위탁에 관한 사항(해당되는 경우에만 작성)\n\n- 직접작성 가능합니다.\n\n▶ 가명처리하는 개인정보의 항목\n\n- 직접작성 가능합니다.\n\n▶ 법 제28조의4(가명정보에 대한 안전조치 의무 등)에 따른 가명정보의 안전성 확보조치에 관한 사항\n\n- 직접작성 가능합니다.\n\n제13조 (개인정보 보호책임자에 관한 사항)\n\n① 위세너 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.\n\n▶ 개인정보 보호책임자\n성명 :송재호\n직책 :대표\n직급 :대표\n연락처 :010-8693-4225, thruthesky@gmail.com,\n※ 개인정보 보호 담당부서로 연결됩니다.\n\n\n▶ 개인정보 보호 담당부서\n부서명 :기획\n담당자 :송재호\n연락처 :010-8693-4225, thruthesky@gmail.com,\n② 정보주체께서는 위세너 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 위세너 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.\n\n제14조(개인정보의 열람청구를 접수·처리하는 부서)\n정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.\n< 위세너 >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.\n\n▶ 개인정보 열람청구 접수·처리 부서\n부서명 : 운영\n담당자 : 송재호\n연락처 : 010-8693-4225, thruthesky@gmail.com\n\n\n제15조(정보주체의 권익침해에 대한 구제방법)\n\n\n\n정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.\n\n1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)\n2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)\n3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)\n4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)\n\n「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.\n\n※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.\n\n제16조(영상정보처리기기 운영·관리에 관한 사항)\n① < 위세너 >은(는) 아래와 같이 영상정보처리기기를 설치·운영하고 있습니다.\n\n1.영상정보처리기기 설치근거·목적 : < 위세너 >의 영상정보처리기기 설치 및 목적에 대한 내용을 기술합니다.\n\n2.설치 대수, 설치 위치, 촬영 범위 :\n설치대수 : 1 대\n설치위치 : 정문\n촬영범위 : 사무실 내부\n3.관리책임자, 담당부서 및 영상정보에 대한 접근권한자 : 송재호\n\n4.영상정보 촬영시간, 보관기간, 보관장소, 처리방법\n촬영시간 : 168 시간\n보관기간 : 촬영시부터 1주일\n보관장소 및 처리방법 : 크라우드\n5.영상정보 확인 방법 및 장소 : 핸드폰앱\n\n6.정보주체의 영상정보 열람 등 요구에 대한 조치 : 개인영상정보 열람.존재확인 청구서로 신청하여야 하며, 정보주체 자신이 촬영된 경우 또는 명백히 정보주체의 생명.신체.재산 이익을 위해 필요한 경우에 한해 열람을 허용함\n\n7.영상정보 보호를 위한 기술적.관리적.물리적 조치 :\n\n\n\n제17조(개인정보 처리방침 변경)\n\n\n① 이 개인정보처리방침은 2024년 8월 1일 부터 적용됩니다.',
    },
    'niu44818': {
      'en': 'Privacy Policy',
      'ko': '',
    },
    'c093runs': {
      'en': 'Home',
      'ko': '',
    },
  },
  // EmailLoginScreen
  {
    '7l836gkt': {
      'en': 'Email',
      'ko': '',
    },
    'zflxg3gu': {
      'en': 'example@email.com',
      'ko': '',
    },
    'nd7isx39': {
      'en': '',
      'ko': '',
    },
    'aamjge7z': {
      'en': 'Password',
      'ko': '',
    },
    'qpmtmbxu': {
      'en': 'Input Password',
      'ko': '',
    },
    'kog591ik': {
      'en': '',
      'ko': '',
    },
    'dzttn21d': {
      'en': 'Confirm Password',
      'ko': '',
    },
    '27j7hfcn': {
      'en': 'Input Confirm Password',
      'ko': '',
    },
    '4p138e69': {
      'en': '',
      'ko': '',
    },
    'inh5fo9o': {
      'en': 'Sign In',
      'ko': '',
    },
    '4r0kjam2': {
      'en': 'Don\'t have an account? Register now!',
      'ko': '',
    },
    'l0tw3aqt': {
      'en': 'Register',
      'ko': '',
    },
    'rpb1qeuc': {
      'en': 'Have an account? Sign in instead',
      'ko': '',
    },
    '06gpk1lc': {
      'en': 'Use Phone sign in instead',
      'ko': '',
    },
    'ifbpsmjt': {
      'en': 'Home',
      'ko': '',
    },
  },
  // AnonymousMenuScreen
  {
    'mpkkwopb': {
      'en': 'Anonymous',
      'ko': '',
    },
    'ri1sf2h6': {
      'en': 'Sign In',
      'ko': '',
    },
    'v5obmpum': {
      'en': 'Home',
      'ko': '',
    },
  },
  // UserTileComponent
  {
    'sbo9554y': {
      'en': 'Report',
      'ko': '',
    },
  },
  // ReportBottomSheetComponent
  {
    'yq08s52h': {
      'en': 'Report This User',
      'ko': '',
    },
    'rj9zizmi': {
      'en': 'Option 1',
      'ko': '',
    },
    'qfckqc7z': {
      'en': 'Option 2',
      'ko': '',
    },
    'c3a9n4p4': {
      'en': 'Option 3',
      'ko': '',
    },
    'l2f5j5d8': {
      'en': 'Reason',
      'ko': '',
    },
    'o67zsj0p': {
      'en': 'Explain the reason why you are reporting this user',
      'ko': '',
    },
    'ewieuggq': {
      'en': 'Cancel',
      'ko': '',
    },
    'jwm8bvh8': {
      'en': 'Submit',
      'ko': '',
    },
  },
  // AILearningHeaderComponent
  {
    '3814510o': {
      'en': 'What is AI?',
      'ko': '',
    },
    '36g4kinm': {
      'en': 'SMART BRAIN',
      'ko': '',
    },
    'soemrnre': {
      'en': 'for\nRobots and Computers',
      'ko': '',
    },
  },
  // MenuHomeworkAIContentComponent
  {
    '9l9s2uxg': {
      'en': 'Hello, I\'m Homework Assistant. I\'m here to help you!',
      'ko': '',
    },
  },
  // MathLearningIconsComponent
  {
    '7vfcmby0': {
      'en': '=',
      'ko': '',
    },
  },
  // AboutTileComponent
  {
    'jdmj2pwz': {
      'en': 'Terms and Condtions',
      'ko': '',
    },
  },
  // Miscellaneous
  {
    'gdxzv7xj': {
      'en': 'Hello World',
      'ko': '안녕하세요 세상',
    },
    '0u8ladjh': {
      'en': 'Hello World',
      'ko': '안녕하세요 세상',
    },
    '3to8jxn0': {
      'en': 'Button',
      'ko': '단추',
    },
    'cufbrr33': {
      'en': 'Button',
      'ko': '단추',
    },
    'nsbk2c44': {
      'en': 'Button',
      'ko': '단추',
    },
    'lup58njd': {
      'en': 'Button',
      'ko': '단추',
    },
    'qh4jw4fj': {
      'en': 'Button',
      'ko': '단추',
    },
    'dtcfphri': {
      'en': 'TextField',
      'ko': '텍스트필드',
    },
    'b067xvai': {
      'en': 'TextField',
      'ko': '텍스트필드',
    },
    'emrfgjoo': {
      'en': 'Button',
      'ko': '',
    },
    'rql8viyr': {
      'en': '',
      'ko': '',
    },
    '7degsbf7': {
      'en': '',
      'ko': '',
    },
    'uctl90a7': {
      'en':
          'AICOOL app requires access to the microphone to query AI with your voice.',
      'ko': '',
    },
    'v1tzm3bn': {
      'en': '',
      'ko': '',
    },
    '84yss0b4': {
      'en': '',
      'ko': '',
    },
    '0nihq0vw': {
      'en': '',
      'ko': '',
    },
    '1zadtwwo': {
      'en': 'AICOOL app requires access to recognize your voice to query AI.',
      'ko': '',
    },
    '6w58tth7': {
      'en': '',
      'ko': '',
    },
    'lyajk8pk': {
      'en': '',
      'ko': '',
    },
    '1j4luawi': {
      'en': '',
      'ko': '',
    },
    'y99b78kk': {
      'en': '',
      'ko': '',
    },
    'vluk1zlu': {
      'en': '',
      'ko': '',
    },
    'mluy76ay': {
      'en': '',
      'ko': '',
    },
    'ezmk9nmq': {
      'en': '',
      'ko': '',
    },
    '8y2kz6hj': {
      'en': '',
      'ko': '',
    },
    'msl5thsi': {
      'en': '',
      'ko': '',
    },
    '2sctqx2o': {
      'en': '',
      'ko': '',
    },
    'wirh02d4': {
      'en': '',
      'ko': '',
    },
    'pu7jfhy0': {
      'en': '',
      'ko': '',
    },
    'oq6sgynj': {
      'en': '',
      'ko': '',
    },
    'wslo2kgb': {
      'en': '',
      'ko': '',
    },
    'c0qapefg': {
      'en': '',
      'ko': '',
    },
    'ry4anf46': {
      'en': '',
      'ko': '',
    },
    'fjvhks3c': {
      'en': '',
      'ko': '',
    },
    '1bfua4ny': {
      'en': '',
      'ko': '',
    },
    'obmsvi7a': {
      'en': '',
      'ko': '',
    },
    'pja2ue3p': {
      'en': '',
      'ko': '',
    },
    'z9l5qbjc': {
      'en': '',
      'ko': '',
    },
    '1yw7nkxi': {
      'en': '',
      'ko': '',
    },
    '0vkwxdfg': {
      'en': '',
      'ko': '',
    },
    'hqxeh4fv': {
      'en': '',
      'ko': '',
    },
    't36g7mxx': {
      'en': '',
      'ko': '',
    },
  },
].reduce((a, b) => a..addAll(b));
