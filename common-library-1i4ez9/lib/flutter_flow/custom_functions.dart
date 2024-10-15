import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

bool? checkAnswer(
  String operation,
  List<int> numbers,
  int? answer,
) {
  if (answer == null) return null;
  if (operation == "addition") {
    return numbers[0] + numbers[1] == answer;
  }
  if (operation == "subtraction") {
    return numbers[0] - numbers[1] == answer;
  }
  if (operation == "multiplication") {
    return (numbers[0] * numbers[1]) == answer;
  }
  if (operation == "division") {
    return (numbers[0] / numbers[1]) == answer;
  }
  if (operation == "percentage") {
    return (numbers[0] * numbers[1] / 100).ceil() == answer;
  }
  return null;
}

List<YoutubeStruct> getEnglishTutorialYoutubes() {
  final result = {
    'wc2saYCVGFo': {
      'channelTitle': "Teaching Kit",
      'youtubeId': "wc2saYCVGFo",
      'viewCount': 434784,
      'title':
          "CVC Reading Lesson 2 | CVC Words in Sentences | Sentences with Short Vowel Ee"
    },
    'OTQkqR2LlgU': {
      'channelTitle': "Read Kids",
      'youtubeId': "OTQkqR2LlgU",
      'viewCount': 2348646,
      'title':
          "PRACTICE READING 3-LETTER WORD / COLLECTION VOWELS / A  E  I  O  U /"
    },
    'Fw0rdSHzWFY': {
      'channelTitle': "English Singsing",
      'youtubeId': "Fw0rdSHzWFY",
      'viewCount': 7459970,
      'title':
          "Theme 1. Greeting - Good morning. Good bye. | ESL Song & Story - Learning English for Kids"
    },
    'nkWhvzcvKdc': {
      'channelTitle': "Teacher Aya Online Tutor",
      'youtubeId': "nkWhvzcvKdc",
      'viewCount': 2542872,
      'title':
          "Learn how to spell some of the basic words || Learn how to spell || Spelling || Lesson with quiz"
    },
    'BRZajMzxjeY': {
      'channelTitle': "Periwinkle",
      'youtubeId': "BRZajMzxjeY",
      'viewCount': 1144008,
      'title':
          "Vowels and Consonants | English Grammar & Composition Grade 1 | Periwinkle"
    },
    'HG361wJyDY0': {
      'channelTitle': "Scratch Garden",
      'youtubeId': "HG361wJyDY0",
      'viewCount': 6495329,
      'title': "The Spelling the Numbers Song | Counting Songs | Scratch Garden"
    },
    '78GhhuwR7M4': {
      'channelTitle': "LucyMax English",
      'youtubeId': "78GhhuwR7M4",
      'viewCount': 1226290,
      'title':
          "Ch.10 What is your name? | Basic English Conversation Practice for Kids"
    },
    'Qh7hCqyfaPs': {
      'channelTitle': "Jack Hartmann Kids Music Channel",
      'youtubeId': "Qh7hCqyfaPs",
      'viewCount': 1280718,
      'title':
          "Parts of a Sentence | Pre-K and Kindergarten Version | Jack Hartmann"
    },
    'nM91WToFCSE': {
      'channelTitle': "TPK Learning",
      'youtubeId': "nM91WToFCSE",
      'viewCount': 814927,
      'title': "K12 Grade 1 - English: Plural and Singular"
    },
    'sMEKaZ8h1qg': {
      'channelTitle': "NS LEARNING TOOLS",
      'youtubeId': "sMEKaZ8h1qg",
      'viewCount': 187505,
      'title':
          "Singular & Plural nouns list, Singular & Plural nouns for kids, English Grammar, 40 Singular-Plural"
    },
    'DdI6qJbi8gE': {
      'channelTitle': "Badanamu",
      'youtubeId': "DdI6qJbi8gE",
      'viewCount': 1612594,
      'title': "Consonant Song Cartoon Mix l Nursery Rhymes & Kids Songs"
    },
    'HzmG8uJFU2I': {
      'channelTitle': "COLORTIME",
      'youtubeId': "HzmG8uJFU2I",
      'viewCount': 14,
      'title':
          "SPELLING NUMBERS 1-10 | NUMBER NAME 1-10 | SPELLING NUMBERS | SPELLING NUMBERS 1-20 | KIDS NUMBERS"
    },
    'kKVGDmmXbVY': {
      'channelTitle': "Teaching Kit",
      'youtubeId': "kKVGDmmXbVY",
      'viewCount': 43388,
      'title':
          "CVC Reading Lesson 5 | CVC Words in Sentences | Sentences with Short Vowel Uu"
    },
    '0Wrv_ZviMEc': {
      'channelTitle': "Scratch Garden",
      'youtubeId': "0Wrv_ZviMEc",
      'viewCount': 7637585,
      'title': "The Sentence Song | English Songs | Scratch Garden"
    },
    'x83FKya5Yh4': {
      'channelTitle': "ABC kindergarten",
      'youtubeId': "x83FKya5Yh4",
      'viewCount': 9096451,
      'title':
          "ABC for Kids | Alphabet writing for kids | A to Z | Write the alphabet along the dotted line"
    },
    '8NYeMoz9pjI': {
      'channelTitle': "Nessy",
      'youtubeId': "8NYeMoz9pjI",
      'viewCount': 549812,
      'title':
          "Syllable Division | Learn the six rules of syllables | Chunking words | Learn to Read"
    },
    '4x_G21KhcEw': {
      'channelTitle': "ABC Moonsweeti",
      'youtubeId': "4x_G21KhcEw",
      'viewCount': 22526086,
      'title':
          "ABC Letter Sounds - Capital and Lowercase Alphabet - Learn to Read English with Phonics"
    },
    'uVeEAFy1z68': {
      'channelTitle': "Little Fox - Kids Stories and Songs",
      'youtubeId': "uVeEAFy1z68",
      'viewCount': 5409181,
      'title':
          "Word Families 1 |  -at, -am, -an, -ad  | Phonics CVC Words for Kindergarten"
    },
    'FY_aB03_hJA': {
      'channelTitle': "Read Kids",
      'youtubeId': "FY_aB03_hJA",
      'viewCount': 687297,
      'title':
          "PRACTICE READING SENTENCES / PART 1 / IMPROVE YOUR READING & VOCABULARY SKILLS"
    },
    'pM-gzdUsEmQ': {
      'channelTitle': "Teaching Kit",
      'youtubeId': "pM-gzdUsEmQ",
      'viewCount': 76733,
      'title':
          "CVC Reading Lesson 3 | CVC Words in Sentences | Sentences with Short Vowel Ii"
    },
    'UcGm_PM2IwY': {
      'channelTitle': "Kiddos World TV",
      'youtubeId': "UcGm_PM2IwY",
      'viewCount': 21366629,
      'title':
          "Fruits and Vegetables Names - Learn Fruits And Vegetables English Vocabulary"
    },
    'drlIUqRYM-w': {
      'channelTitle': "Kiddos World TV",
      'youtubeId': "drlIUqRYM-w",
      'viewCount': 20501429,
      'title': "Learning ABC Letters and Basic English Vocabulary"
    },
    'txe2ZgHFWrM': {
      'channelTitle': "WorldCom EDU",
      'youtubeId': "txe2ZgHFWrM",
      'viewCount': 2824012,
      'title':
          "Learn English through Sight Words 100 LEVEL 3 Full | Easy English with Brian Stuart"
    },
    'lc-uLipc09s': {
      'channelTitle': "Teaching Kit",
      'youtubeId': "lc-uLipc09s",
      'viewCount': 49191,
      'title':
          "CVC Reading Lesson 4 | CVC Words in Sentences | Sentences with Short Vowel Oo"
    },
    '1uAs44DbHE4': {
      'channelTitle': "Casey's Clever Cookies",
      'youtubeId': "1uAs44DbHE4",
      'viewCount': 80390,
      'title': "Synonyms and Antonyms [children's song!]"
    },
    'hyh_FvdoMh0': {
      'channelTitle': "Hopscotch",
      'youtubeId': "hyh_FvdoMh0",
      'viewCount': 914390,
      'title': "Antonyms (The Opposites Song)"
    },
    'PDI2xlOBcM4': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "PDI2xlOBcM4",
      'viewCount': 358860,
      'title':
          "SYNONYMS and ANTONYMS | Compilation | What is the difference between synonyms and antonyms?"
    },
    'PEYlyt7C94E': {
      'channelTitle': "Teaching Kit",
      'youtubeId': "PEYlyt7C94E",
      'viewCount': 1503171,
      'title':
          "CVC Reading Lesson 1 | CVC words in Sentences | Sentences with Short Vowel Aa"
    },
    'RUSCz41aDug': {
      'channelTitle': "A*List! English Learning Videos for Kids",
      'youtubeId': "RUSCz41aDug",
      'viewCount': 18910858,
      'title': "The Short Vowel Song | Best Phonics"
    },
    'BI1Syz9I2n0': {
      'channelTitle': "Periwinkle",
      'youtubeId': "BI1Syz9I2n0",
      'viewCount': 2836341,
      'title':
          "Nouns: Singular & Plural | English Grammar & Composition Grade 2 | Periwinkle"
    },
    '_TM_-0-ayFk': {
      'channelTitle': "Tora the Teacher",
      'youtubeId': "_TM_-0-ayFk",
      'viewCount': 442315,
      'title':
          "Short and Long Vowel Chant | Sounds and Actions for a, e, i, o, u"
    },
    '4SNdy7q6b8g': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "4SNdy7q6b8g",
      'viewCount': 286149,
      'title': "Learning each letter's sound - The Alphabet - Phonics For Kids"
    }
  };
  return result.entries
      .map((v) => YoutubeStruct(
          title: v.value["title"] as String,
          channel: v.value["channelTitle"] as String,
          youtubeId: v.key,
          viewCount: v.value["viewCount"] as int))
      .toList();
}

List<YoutubeStruct> getMusicYoutubes() {
  final result = {
    'rXqu2gwO0T0': {
      'channelTitle': "BANGTANTV",
      'youtubeId': "rXqu2gwO0T0",
      'viewCount': 2665042,
      'title': "지민 (Jimin) 'Who' @ The Tonight Show Starring Jimmy Fallon"
    },
    '11iZcYbq_is': {
      'channelTitle': "이영지",
      'youtubeId': "11iZcYbq_is",
      'viewCount': 26400305,
      'title': "[MV] 이영지 - Small girl feat. 도경수 (D.O.)"
    },
    'DdLYSziSXII': {
      'channelTitle': "TWICE JAPAN OFFICIAL YouTube Channel",
      'youtubeId': "DdLYSziSXII",
      'viewCount': 75182257,
      'title': "TWICE「Wake Me Up」Music Video"
    },
    'Bo_dgP7bilM': {
      'channelTitle': "Red Velvet",
      'youtubeId': "Bo_dgP7bilM",
      'viewCount': 56825,
      'title': "Red Velvet 레드벨벳 'Night Drive' (Official Audio)"
    },
    'fMIn43MiwG8': {
      'channelTitle': "TWICE JAPAN OFFICIAL YouTube Channel",
      'youtubeId': "fMIn43MiwG8",
      'viewCount': 78306033,
      'title': "TWICE 「Celebrate」 Music Video"
    },
    'bizQRBt4xeY': {
      'channelTitle': "jisooschild",
      'youtubeId': "bizQRBt4xeY",
      'viewCount': 459027,
      'title':
          "JISOO (지수) - CLARITY (Live SOLO STAGE, In Your Area Tour, Seoul)"
    },
    '9WKzt9QEmD4': {
      'channelTitle': "이지금 [IU Official]",
      'youtubeId': "9WKzt9QEmD4",
      'viewCount': 4181637,
      'title': "IU 'Shopper' Live Clip (2024 IU WORLD TOUR CONCERT IN SEOUL)"
    },
    'ax1csKKQnns': {
      'channelTitle': "이지금 [IU Official]",
      'youtubeId': "ax1csKKQnns",
      'viewCount': 11334788,
      'title':
          "IU 'Love wins all' Live Clip (2024 IU WORLD TOUR CONCERT IN SEOUL)"
    },
    'Cxzzg7L3Xgc': {
      'channelTitle': "이지금 [IU Official]",
      'youtubeId': "Cxzzg7L3Xgc",
      'viewCount': 14748136,
      'title':
          "[IU] '에잇(eight)' Live Clip (2022 IU Concert 'The Golden Hour : 오렌지 태양 아래')"
    },
    'ZETQ1MKypC8': {
      'channelTitle': "NewJeans",
      'youtubeId': "ZETQ1MKypC8",
      'viewCount': 3496509,
      'title':
          "NewJeans (뉴진스) 'Ditto' Stage Cam @ 2023 FNS Music Festival Summer"
    },
    'SN1Gb4Pqdo4': {
      'channelTitle': "NewJeans",
      'youtubeId': "SN1Gb4Pqdo4",
      'viewCount': 2764572,
      'title': "NewJeans (뉴진스) ‘OMG’ Stage Cam @ ONGAKUNOHI 2023"
    },
    'PFrrQdmq_ws': {
      'channelTitle': "ks",
      'youtubeId': "PFrrQdmq_ws",
      'viewCount': 9478,
      'title': "NewJeans (뉴진스) - Supernatural (Citypop R&B Remix)"
    },
    'QGCkDOkpWf8': {
      'channelTitle': "TWICE JAPAN OFFICIAL YouTube Channel",
      'youtubeId': "QGCkDOkpWf8",
      'viewCount': 10526902,
      'title': "TWICE『DIVE』Music Video"
    },
    '3YqPKLZF_WU': {
      'channelTitle': "Coldplay",
      'youtubeId': "3YqPKLZF_WU",
      'viewCount': 307736093,
      'title': "Coldplay X BTS - My Universe (Official Video)"
    },
    'kRT174IdxuM': {
      'channelTitle': "TWICE JAPAN OFFICIAL YouTube Channel",
      'youtubeId': "kRT174IdxuM",
      'viewCount': 87911490,
      'title': "TWICE 「Fanfare」Music Video"
    },
    '8ExNmYax-ms': {
      'channelTitle': "ITZY JAPAN OFFICIAL YouTube Channel",
      'youtubeId': "8ExNmYax-ms",
      'viewCount': 2893387,
      'title': "ITZY「Algorhythm」Music Video"
    },
    'o4GHoqGtRkg': {
      'channelTitle': "BLACKPINK",
      'youtubeId': "o4GHoqGtRkg",
      'viewCount': 70188552,
      'title': "BLACKPINK - ‘Don't Know What To Do’ 0407 SBS Inkigayo"
    },
    'a7GITgqwDVg': {
      'channelTitle': "Charlie Puth",
      'youtubeId': "a7GITgqwDVg",
      'viewCount': 421228074,
      'title':
          "Charlie Puth - Left And Right (feat. Jung Kook of BTS) [Official Video]"
    },
    'mX8rMMS-MbI': {
      'channelTitle': "Rosesarerosie",
      'youtubeId': "mX8rMMS-MbI",
      'viewCount': 25944693,
      'title': "ROSÉ - Viva La Vida (Coldplay) Live Studio Cover"
    },
    'Bl0s-1c5L0M': {
      'channelTitle': "Red Velvet",
      'youtubeId': "Bl0s-1c5L0M",
      'viewCount': 43157300,
      'title': "Red Velvet 레드벨벳 'Feel My Rhythm' Performance Video"
    }
  };
  return result.entries
      .map((v) => YoutubeStruct(
          title: v.value["title"] as String,
          channel: v.value["channelTitle"] as String,
          youtubeId: v.key,
          viewCount: v.value["viewCount"] as int))
      .toList();
}

PhonicStruct? getNextPhonic(PhonicStruct currentPhonic) {
  final phonics = getPhonics();
  final indexOfCurrentPhonic = phonics.indexOf(currentPhonic);
  if (indexOfCurrentPhonic == -1) return null;
  if (indexOfCurrentPhonic + 1 >= phonics.length) return null;
  return phonics[indexOfCurrentPhonic + 1];
}

PhonicStruct? getPreviousPhonic(PhonicStruct currentPhonic) {
  final phonics = getPhonics();
  final indexOfCurrentPhonic = phonics.indexOf(currentPhonic);
  if (indexOfCurrentPhonic - 1 < 0) return null;
  return phonics[indexOfCurrentPhonic - 1];
}

String getPhonicAudioPath(String word) {
  return 'https://raw.githubusercontent.com/thruthesky/aicool_assets/refs/heads/main/phonics/audio/$word.mp3';
}

String getPhonicExampleAudioPath(String word) {
  return 'https://raw.githubusercontent.com/thruthesky/aicool_assets/refs/heads/main/phonics/audio/$word-example.mp3';
}

String getPhonicImagePath(String word) {
  return 'https://raw.githubusercontent.com/thruthesky/aicool_assets/refs/heads/main/phonics/images/$word.webp';
}

List<PhonicStruct> getPhonics() {
  final values = {
    'airplane': {'example': 'The airplane flies high in the sky.'},
    'apple': {'example': 'The apple is red and round.'},
    'axe': {'example': 'The axe cuts the wood.'},
    'ball': {'example': 'The ball rolls on the ground.'},
    'banana': {'example': 'The banana is yellow and tasty.'},
    'basket': {'example': 'The basket holds apples.'},
    'bell': {'example': 'The bell makes a loud sound.'},
    'bicycle': {'example': 'I ride my bicycle to the park.'},
    'bird': {'example': 'The bird sings in the tree.'},
    'boat': {'example': 'The boat floats on the water.'},
    'book': {'example': 'I like to read a book.'},
    'bread': {'example': 'The bread is soft and warm.'},
    'broom': {'example': 'I use the broom to clean the floor.'},
    'bucket': {'example': 'The bucket is full of water.'},
    'bus': {'example': 'The bus takes us to school.'},
    'butterfly': {'example': 'The butterfly flies from flower to flower.'},
    'cactus': {'example': 'The cactus has sharp spines.'},
    'cake': {'example': 'The cake is sweet and yummy.'},
    'camera': {'example': 'The camera takes pictures.'},
    'candle': {'example': "The candle gives light when it's dark."},
    'candy': {'example': 'The candy is sweet and colorful.'},
    'car': {'example': 'The car drives down the road.'},
    'carrot': {'example': 'The carrot is orange and crunchy.'},
    'cat': {'example': 'The cat sits on the mat.'},
    'chair': {'example': 'I sit on the chair.'},
    'chicken': {'example': 'The chicken lays eggs.'},
    'clock': {'example': 'The clock tells the time.'},
    'comb': {'example': 'I use the comb to fix my hair.'},
    'corn': {'example': 'The corn is yellow and sweet.'},
    'cow': {'example': 'The cow gives us milk.'},
    'crocodile': {'example': 'The crocodile swims in the river.'},
    'deer': {'example': 'The deer runs fast in the forest.'},
    'dice': {'example': 'I roll the dice to play the game.'},
    'dinosaur': {'example': 'The dinosaur is big and strong.'},
    'dog': {'example': 'The dog sits on the mat.'},
    'donut': {'example': 'The donut is sweet and round.'},
    'drum': {'example': 'The drum makes a loud noise.'},
    'duck': {'example': 'The duck swims in the pond.'},
    'egg': {'example': 'The egg is white and oval.'},
    'eggplant': {'example': 'The eggplant is purple and shiny.'},
    'elephant': {'example': 'The elephant has a long trunk.'},
    'fence': {'example': 'The fence keeps the animals safe.'},
    'firetruck': {'example': 'The firetruck is red and big.'},
    'fish': {'example': 'The fish swims in the water.'},
    'flashlight': {'example': 'The flashlight helps us see in the dark.'},
    'flower': {'example': 'The flower is bright and pretty.'},
    'frog': {'example': 'The frog jumps into the pond.'},
    'grapes': {'example': 'The grapes are small and purple.'},
    'guitar': {'example': 'The guitar makes music.'},
    'hat': {'example': 'The hat protects me from the sun.'},
    'helicopter': {'example': 'The helicopter flies in the air.'},
    'helmet': {'example': 'The helmet keeps my head safe.'},
    'horse': {'example': 'The horse runs in the field.'},
    'house': {'example': 'The house is big and cozy.'},
    'icecream': {'example': 'The ice cream is cold and sweet.'},
    'key': {'example': 'The key opens the door.'},
    'kite': {'example': 'The kite flies in the sky.'},
    'ladder': {'example': 'The ladder helps me reach high places.'},
    'lamp': {'example': 'The lamp gives light to the room.'},
    'leaves': {'example': 'The leaves fall from the tree.'},
    'log': {'example': 'The log is heavy and brown.'},
    'magnet': {'example': 'The magnet sticks to metal.'},
    'mirror': {'example': 'The mirror shows my reflection.'},
    'moon': {'example': 'The moon shines at night.'},
    'mouse': {'example': 'The mouse is small and quick.'},
    'mug': {'example': 'The mug holds my drink.'},
    'mushroom': {'example': 'The mushroom grows in the forest.'},
    'nest': {'example': 'The bird builds a nest in the tree.'},
    'newspaper': {'example': "The newspaper has today's news."},
    'orange': {'example': 'The orange is juicy and sweet.'},
    'owl': {'example': 'The owl hoots at night.'},
    'peas': {'example': 'The peas are small and green.'},
    'pencil': {'example': 'I use the pencil to write.'},
    'penguin': {'example': 'The penguin waddles on the ice.'},
    'pig': {'example': 'The pig rolls in the mud.'},
    'pillow': {'example': 'I rest my head on the pillow.'},
    'pineapple': {'example': 'The pineapple is sweet and spiky.'},
    'pizza': {'example': 'The pizza is hot and cheesy.'},
    'potato': {'example': 'The potato is brown and round.'},
    'rabbit': {'example': 'The rabbit hops in the garden.'},
    'sandwich': {'example': 'The sandwich is tasty and filling.'},
    'scissor': {'example': 'I use the scissors to cut paper.'},
    'scooter': {'example': 'I ride my scooter down the street.'},
    'shark': {'example': 'The shark swims in the ocean.'},
    'shoe': {'example': 'The shoe protects my feet.'},
    'skateboard': {'example': 'I ride my skateboard at the park.'},
    'snake': {'example': 'The snake slithers on the ground.'},
    'snowman': {'example': 'The snowman has a carrot nose.'},
    'sock': {'example': 'The sock keeps my feet warm.'},
    'spider': {'example': 'The spider spins a web.'},
    'star': {'example': 'The star shines brightly in the sky.'},
    'stopwatch': {'example': 'The stopwatch helps me time the race.'},
    'sun': {'example': 'The sun is bright and hot.'},
    'tent': {'example': 'We sleep in the tent when we camp.'},
    'train': {'example': 'The train moves fast on the tracks.'},
    'tree': {'example': 'The tree grows tall and strong.'},
    'truck': {'example': 'The truck carries heavy things.'},
    'umbrella': {'example': 'The umbrella keeps me dry in the rain.'},
    'watch': {'example': 'The watch helps me tell the time.'},
    'whale': {'example': 'The whale is big and swims in the ocean.'},
    'zebra': {'example': 'The zebra has black and white stripes.'}
  };
  return values.entries
      .map((e) => PhonicStruct(
          key: e.key,
          title: '${e.key[0].toUpperCase()}${e.key.substring(1).toLowerCase()}',
          example: e.value["example"]))
      .toList();
}

List<OperationPracticeQuestionStruct>? getPracticeQuestions(String operation) {
  List<List<int>> values = [];
  if (operation == "percentage") {
    final List<List<int>> percentageQuestions = [
      [20, 50],
      [30, 20],
      [10, 70],
      [25, 40],
      [15, 60],
      [50, 20],
      [60, 80],
      [80, 75],
      [90, 50],
      [85, 40]
    ];
    values = percentageQuestions;
  }
  if (operation == "addition") {
    final List<List<int>> additionQuestions = [
      [3, 2],
      [5, 4],
      [7, 1],
      [6, 3],
      [8, 2],
      [10, 5],
      [12, 8],
      [15, 9],
      [18, 7],
      [25, 15]
    ];
    values = additionQuestions;
  }
  if (operation == "subtraction") {
    final List<List<int>> subtractionQuestions = [
      [5, 2],
      [8, 3],
      [10, 4],
      [7, 5],
      [9, 6],
      [14, 8],
      [20, 9],
      [25, 10],
      [30, 15],
      [40, 20]
    ];
    values = subtractionQuestions;
  }
  if (operation == "multiplication") {
    final List<List<int>> multiplicationQuestions = [
      [2, 2],
      [3, 3],
      [4, 2],
      [5, 3],
      [6, 2],
      [7, 5],
      [8, 4],
      [9, 6],
      [10, 7],
      [12, 8]
    ];
    values = multiplicationQuestions;
  }
  if (operation == "division") {
    final List<List<int>> divisionQuestions = [
      [4, 2],
      [6, 3],
      [8, 2],
      [9, 3],
      [12, 4],
      [15, 5],
      [18, 6],
      [24, 8],
      [28, 7],
      [36, 9]
    ];
    values = divisionQuestions;
  }
  return values
      .map((e) => OperationPracticeQuestionStruct(numbers: [e[0], e[1]]))
      .toList();
}

String getYoutubeUrl(String youtubeId) {
  return "https://www.youtube.com/watch?v=$youtubeId";
}

String getQuestion(
  String operation,
  List<int> numbers,
) {
  if (operation == "addition") {
    return "${numbers[0]} + ${numbers[1]} = ?";
  }
  if (operation == "subtraction") {
    return "${numbers[0]} - ${numbers[1]} = ?";
  }
  if (operation == "multiplication") {
    return "${numbers[0]} \u00D7 ${numbers[1]} = ?";
  }
  if (operation == "division") {
    return "${numbers[0]} ÷ ${numbers[1]} = ?";
  }
  if (operation == "percentage") {
    return "${numbers[0]}% of ${numbers[1]} is ?";
  }
  return " ";
}

String? getYoutubeStandardThumbnail(String? youtubeId) {
  return 'https://img.youtube.com/vi/$youtubeId/sddefault.jpg';
}

List<YoutubeStruct> getTedTalksYoutubes() {
  final result = {
    "iCi4jkb2hZQ": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "iCi4jkb2hZQ",
      "viewCount": 44480,
      "title":
          "How Kids Can Benefit from Empathy and Love Language | Maple Zhang | TEDxKerrisdale"
    },
    "9S8KR_qL3OQ": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "9S8KR_qL3OQ",
      "viewCount": 32,
      "title":
          "Animals' fun facts | Elisa Bonilha Lopes | TEDxMaple Bear Ribeirão Preto Youth"
    },
    "CqWBtnm2-LY": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "CqWBtnm2-LY",
      "viewCount": 23,
      "title":
          "Scouting as a holistic movement  | Paulo Ferrara Motooka | TEDxMaple Bear Ribeirão Preto Youth"
    },
    "TU2PUkasdbM": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "TU2PUkasdbM",
      "viewCount": 80398,
      "title":
          "I Thought You Were My Friend ... | Delphine Matta-Brown | TEDxYouth@DPL"
    },
    "wbftlDzIALA": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "wbftlDzIALA",
      "viewCount": 278925,
      "title": "The Effects of Lying | Georgia Haukom | TEDxKids@ElCajon"
    },
    "OMbNoo4mCcI": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "OMbNoo4mCcI",
      "viewCount": 216801,
      "title": "Education For All | Cameron Allen | TEDxKids@ElCajon"
    },
    "rW2r5uStgG0": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "rW2r5uStgG0",
      "viewCount": 1269102,
      "title":
          "The Power and Importance of...READING! | Luke Bakic | TEDxYouth@TBSWarsaw"
    },
    "RtVSamE7stM": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "RtVSamE7stM",
      "viewCount": 16826,
      "title": "Kids Play: Fun Learning | Leen NasrAlla | TEDxEt Tagammo Kids"
    },
    "Fkd9TWUtFm0": {
      "channelTitle": "TED",
      "youtubeId": "Fkd9TWUtFm0",
      "viewCount": 11216499,
      "title": "A 12-year-old app developer | Thomas Suarez | TED"
    },
    "vNMOKdSilTA": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "vNMOKdSilTA",
      "viewCount": 99102,
      "title": "Smiles are Contagious | Giovanni Maroki | TEDxKids@ElCajon"
    },
    "px9CzSZsa0Y": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "px9CzSZsa0Y",
      "viewCount": 1768499,
      "title": "The Mindset of a Champion | Carson Byblow | TEDxYouth@AASSofia"
    },
    "RIwwPHeWQdA": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "RIwwPHeWQdA",
      "viewCount": 69893,
      "title":
          "Empathy, Education, Inclusion: A Guide to Real Friendship | Emma Liu | TEDxYouth@GrandviewHeights"
    },
    "9fLlkOMrMq4": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "9fLlkOMrMq4",
      "viewCount": 1238928,
      "title": "The Power of Reading | April Qu | TEDxYouth@Suzhou"
    },
    "aISXCw0Pi94": {
      "channelTitle": "TED",
      "youtubeId": "aISXCw0Pi94",
      "viewCount": 7067289,
      "title": "Molly Wright: How every child can thrive by five | TED"
    },
    "S5RZF9fAjW4": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "S5RZF9fAjW4",
      "viewCount": 196429,
      "title": "Kids Can Too | Noah Diguangco | TEDxKids@BC"
    },
    "DRLcSSMiA3w": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "DRLcSSMiA3w",
      "viewCount": 12221,
      "title":
          "Why You Should Compete With Yourself More Often  | Aaron Wang | TEDxYouth@GranvilleIsland"
    },
    "L3HKC9C4ae0": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "L3HKC9C4ae0",
      "viewCount": 119,
      "title":
          "The power of storytelling | DeLiang Al Farabi | TEDxSMPI Al Abidin Surakarta Youth"
    },
    "IdIIPZU2QKI": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "IdIIPZU2QKI",
      "viewCount": 36521,
      "title":
          "Lessons I Learnt From Football | Jason Yeka Baba | TEDxKids@Mbora"
    },
    "bC0hlK7WGcM": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "bC0hlK7WGcM",
      "viewCount": 11025362,
      "title":
          "How a 13 year old changed 'Impossible' to 'I'm Possible' | Sparsh Shah | TEDxGateway"
    },
    "auSGX74O4bY": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "auSGX74O4bY",
      "viewCount": 19662,
      "title":
          "The Power of Positive Thinking  | Mia Xu | TEDxYouth@GranvilleIsland"
    },
    "JLYOUGo0ml4": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "JLYOUGo0ml4",
      "viewCount": 284212,
      "title": "Lemons to lemonade | Senna | TEDxEncinitas"
    },
    "qROkHxeFpDs": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "qROkHxeFpDs",
      "viewCount": 150912,
      "title":
          "Climate change - from one kid to another | Bandi Guan | TEDxYouth@GrandviewHeights"
    },
    "TdWEu0Ohoy8": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "TdWEu0Ohoy8",
      "viewCount": 51588,
      "title":
          "Innovate for the Future by Developing a Makers Mindset | Berton Yang | TEDxYouth@GrandviewHeights"
    },
    "xJqLcJnRnnc": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "xJqLcJnRnnc",
      "viewCount": 153839,
      "title":
          "Why Parents should Listen to Kids | Anyue Sun | TEDxYouth@Xujiahui"
    },
    "ICmok9ElvXI": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "ICmok9ElvXI",
      "viewCount": 198848,
      "title": "Friends = Happiness | Eyva Dusetzina | TEDxKids@ElCajon"
    },
    "2KoVNQz2BaM": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "2KoVNQz2BaM",
      "viewCount": 84313,
      "title": "A Positive Mindset Helps! | Sarah Good | TEDxYouth@Columbus"
    },
    "F7Id9caYw-Y": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "F7Id9caYw-Y",
      "viewCount": 2157227,
      "title":
          "What's wrong with our food system | Birke Baehr | TEDxNextGenerationAsheville"
    },
    "66yaYmUNOx4": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "66yaYmUNOx4",
      "viewCount": 298568,
      "title":
          "What Growth Mindset Means for Kids | Rebecca Chang | TEDxYouth@Jingshan"
    },
    "Kh9GbYugA1Y": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "Kh9GbYugA1Y",
      "viewCount": 1041574,
      "title": "Kids need recess | Simon Link | TEDxAmanaAcademy"
    },
    "JnNrxoxkg20": {
      "channelTitle": "TEDx Talks",
      "youtubeId": "JnNrxoxkg20",
      "viewCount": 93805,
      "title": "Kids Can Be Role Models | Jack Bonneau | TEDxBoulder"
    }
  };
  return result.entries
      .map((v) => YoutubeStruct(
          title: v.value["title"] as String,
          channel: v.value["channelTitle"] as String,
          youtubeId: v.key,
          viewCount: v.value["viewCount"] as int))
      .toList();
}

List<YoutubeStruct> getMathYoutubes() {
  final result = {
    'T3h1HUVHLJo': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "T3h1HUVHLJo",
      'viewCount': 249754,
      'title': "Divisions - Learn to Divide with our Monkey Friends"
    },
    'RBiBnfh97Pk': {
      'channelTitle': "Kuttu Kiddie Learning Space",
      'youtubeId': "RBiBnfh97Pk",
      'viewCount': 46,
      'title':
          "Learn Shapes for Kids with Circle, Square, Triangle & more | geometric shapes"
    },
    'OnJlGMgqBes': {
      'channelTitle': "KiddiTube Channel",
      'youtubeId': "OnJlGMgqBes",
      'viewCount': 4529573,
      'title':
          "How to Write Numbers 1-10 | How to Write Numbers 1234. | Kids Learning Numbers 1-10."
    },
    'uup7IC7c1V8': {
      'channelTitle': "Virtual Elementary School",
      'youtubeId': "uup7IC7c1V8",
      'viewCount': 383724,
      'title': "Grade 3 Math: How to Use a Multiplication Table"
    },
    'twh4ydx7TQc': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "twh4ydx7TQc",
      'viewCount': 11913,
      'title': "📝 ROMAN NUMERALS for Kids 🏛 Compilation"
    },
    'h0RF0N5TOPE': {
      'channelTitle': "True Curriculum",
      'youtubeId': "h0RF0N5TOPE",
      'viewCount': 139747,
      'title': "What is Multiplication?"
    },
    'OKJI91YYQaM': {
      'channelTitle': "Maths About You",
      'youtubeId': "OKJI91YYQaM",
      'viewCount': 16587,
      'title': "Understanding Fractions - Grade 2"
    },
    'VvKAVy5MKLA': {
      'channelTitle': "Math Quiz for Kids",
      'youtubeId': "VvKAVy5MKLA",
      'viewCount': 117184,
      'title': "20 Math Quiz for Kids | One Digit Addition Quiz"
    },
    'KgZIXq04ee8': {
      'channelTitle': "Virtual Elementary School",
      'youtubeId': "KgZIXq04ee8",
      'viewCount': 717290,
      'title': "Grade 2 Math: Addition Solution"
    },
    'DhiklliLG80': {
      'channelTitle': "Rock 'N Learn",
      'youtubeId': "DhiklliLG80",
      'viewCount': 997998,
      'title':
          "Skip Counting for Kids | Count by 2s through 12s and by 25s | Rock 'N Learn"
    },
    'FxrTNtClwrg': {
      'channelTitle': "LoveToLearn with Subhashini Balakrishnan",
      'youtubeId': "FxrTNtClwrg",
      'viewCount': 668561,
      'title':
          "Basic Subtraction |Subtraction For Kids |Learn To Subtract |Subtract |Premath Concept |Subtraction"
    },
    'qM7B2nwpV1M': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "qM7B2nwpV1M",
      'viewCount': 2913270,
      'title':
          "Subtraction for kids - Learn how to subtract - Mathematics for kids -"
    },
    'UffIn6yh7QQ': {
      'channelTitle': "Periwinkle",
      'youtubeId': "UffIn6yh7QQ",
      'viewCount': 242657,
      'title':
          "Subtraction With The Help of Stories | Mathematics Grade 1 | Periwinkle"
    },
    'MQZHc9_x5x0': {
      'channelTitle': "Boddle Learning",
      'youtubeId': "MQZHc9_x5x0",
      'viewCount': 4267,
      'title': "Addition and subtraction within 20 - 1st Grade Math 1.OA.A.1"
    },
    'mjlsSYLLOSE': {
      'channelTitle': "Noodle Kidz",
      'youtubeId': "mjlsSYLLOSE",
      'viewCount': 5228493,
      'title':
          "Basic Math Addition For Kids | Noodle Kidz Pre-K and Kindergarten Educational Video"
    },
    'kDFLcCOS7aw': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "kDFLcCOS7aw",
      'viewCount': 178390,
      'title':
          "Percentages for Kids % - What is percentages in Math? - Math for Kids"
    },
    'FSTlQjxznUg': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "FSTlQjxznUg",
      'viewCount': 963244,
      'title': "Fractions for kids - Mathematics for kids"
    },
    '7J1OkxuyLD0': {
      'channelTitle': "Scratch Garden",
      'youtubeId': "7J1OkxuyLD0",
      'viewCount': 3483511,
      'title': "Adding & Subtracting! | Mini Math Movies | Scratch Garden"
    },
    'peSNdpGC14Q': {
      'channelTitle': "Kiddos World TV",
      'youtubeId': "peSNdpGC14Q",
      'viewCount': 482174,
      'title': "Learn How to Draw and Identifying the Different Types of Shapes"
    },
    'j9y2uSvEj3I': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "j9y2uSvEj3I",
      'viewCount': 63177,
      'title':
          "2 DIGIT DIVISION ➗ Long Division 👨🏻‍🚀 Divide two digit numbers"
    },
    '2hVQLG-QTfI': {
      'channelTitle': "EasyTeaching",
      'youtubeId': "2hVQLG-QTfI",
      'viewCount': 347577,
      'title': "Prime and Composite Numbers | Maths | EasyTeaching"
    },
    'JnH7A2xGeMQ': {
      'channelTitle': "Little Learners TV",
      'youtubeId': "JnH7A2xGeMQ",
      'viewCount': 3229,
      'title':
          "What Is Addition? | Fun Math Song for Kids | Learn Basic Addition"
    },
    'CFDCG1b4ahk': {
      'channelTitle': "Learn and Play Online!",
      'youtubeId': "CFDCG1b4ahk",
      'viewCount': 384447,
      'title': "Multiplication for Kids!"
    },
    'Ds226Vh7epg': {
      'channelTitle': "Virtual Elementary School",
      'youtubeId': "Ds226Vh7epg",
      'viewCount': 303484,
      'title': "Grade 2 Math: Subtraction Rocks with Base Ten Blocks"
    },
    'NDMPwZL47JY': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "NDMPwZL47JY",
      'viewCount': 382043,
      'title': "Geometric Shapes for kids - Preschool Vocabulary"
    },
    '64643Op6WJo': {
      'channelTitle': "Free Animated Education",
      'youtubeId': "64643Op6WJo",
      'viewCount': 382475,
      'title': "What is Mathematics?"
    },
    'GLrn08g9QKA': {
      'channelTitle': "Smile and Learn - English",
      'youtubeId': "GLrn08g9QKA",
      'viewCount': 82552,
      'title':
          "PRIME AND COMPOSITE NUMBERS for Kids 🚀 What are Prime Numbers? 🪐 MATH for Kids"
    },
    'ohaXcHwUWY0': {
      'channelTitle': "Teddy & Timmy Edutainment - Education & Kids Songs",
      'youtubeId': "ohaXcHwUWY0",
      'viewCount': 9798862,
      'title':
          "Shapes | Names of Shapes | Geometry | Shapes for Kids | Geometric Shapes"
    },
    'g9Fo3xkPlvM': {
      'channelTitle': "Quizzy Cat",
      'youtubeId': "g9Fo3xkPlvM",
      'viewCount': 211,
      'title':
          "How Many Quiz for kids How Good are your observation & counting skills? ✅ 🧠"
    },
    'C1QG7etNF2U': {
      'channelTitle': "ABC junior",
      'youtubeId': "C1QG7etNF2U",
      'viewCount': 30303,
      'title': "Basic subtraction - Math made easy for kids"
    },
    'RwnqECUD6SI': {
      'channelTitle': "ABC junior",
      'youtubeId': "RwnqECUD6SI",
      'viewCount': 571674,
      'title': "Basic addition - Math made easy"
    }
  };
  return result.entries
      .map((v) => YoutubeStruct(
          title: v.value["title"] as String,
          channel: v.value["channelTitle"] as String,
          youtubeId: v.key,
          viewCount: v.value["viewCount"] as int))
      .toList();
}

List<int> generateEmptyList(int length) {
  return List.generate(length, (index) => index);
}

int? getAnswer(
  String operation,
  List<int> numbers,
) {
  if (operation == "addition") {
    return numbers[0] + numbers[1];
  }

  if (operation == "subtraction") {
    return numbers[0] - numbers[1];
  }

  if (operation == "multiplication") {
    return (numbers[0] * numbers[1]);
  }

  if (operation == "division") {
    return (numbers[0] / numbers[1]).round();
  }
  if (operation == "percentage") {
    return (numbers[0] * numbers[1] / 100).ceil();
  }
  return null;
}
