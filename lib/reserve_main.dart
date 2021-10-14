// class ReserveMain{


//   // Reset Quiz App

//   void _resetQuiz() async {
//     var bloc = Provider.of<MainBloc>(context, listen: false);
//     var prefs = await SharedPreferences.getInstance();
//     var contactBox = Hive.box<UserData>('UserData1');
//     if (bloc.questionIndex > 0) {
//       setState(() {
//         if (currentUser != null) {
//           _addHiveUserResult(contactBox, bloc);
//           _addMoorUserResult(bloc);
//         }

//         var timeNow = DateFormat('yyyy-MM-dd (kk:mm)').format(DateTime.now());
//         _lastResults.add(
//           '${currentUser != null ? '${currentUser.userName} - ' : ''} ${_lastResults.length + 1}) ${bloc.totalScore} / $bloc.questionIndex - $timeNow',
//         );
//         prefs.setStringList('lastResults', _lastResults);
//         bloc.inEvent.add(MainBlocEvent.setQuestionsLenght);
//         prefs.setInt('questionsLenght', bloc.questionIndex);
//         bloc.inEvent.add(MainBlocEvent.setSavedScore);
//         prefs.setInt('saveScore', bloc.totalScore);
//         bloc.inEvent.add(MainBlocEvent.questionIndexNullify);
//         bloc.inEvent.add(MainBlocEvent.totalScoreNullify);
//         bloc.inEvent.add(MainBlocEvent.progressNullify);
//       });
//     }
//     await cont.animateToPage(
//       0,
//       duration: (Duration(seconds: 1)),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _addHiveUserResult(Box<UserData> contactBox, MainBloc bloc) {
//     contactBox.values.forEach((element) {
//       if (element.isCurrentUser) {
//         element.userResult = bloc.totalScore;
//         element.userResults.insert(
//           0,
//           UserResult(
//             score: bloc.totalScore,
//             questionsLenght: bloc.questionIndex,
//             resultDate: DateTime.now(),
//             categoryNumber: _categoryNumber,
//           ),
//         );
//         element.save();
//       }
//     });
//   }

//   void _addMoorUserResult(MainBloc bloc) {
//     Provider.of<MyDatabase>(context, listen: false).insertMoorResult(
//       MoorResult(
//         id: null,
//         name: currentUser.userName,
//         result: bloc.totalScore,
//         questionsLenght: bloc.questionIndex,
//         rightResultsPercent: (100 / bloc.questionIndex * bloc.totalScore),
//         categoryNumber: _categoryNumber,
//         resultDate: DateTime.now(),
//       ),
//     );
//   }

// //When answer question

//   void _answerQuestion(bool result) {
//     var bloc = Provider.of<MainBloc>(context, listen: false);

//     if (result) {
//       bloc.inEvent.add(MainBlocEvent.questionIndexIncreement);
//       bloc.inEvent.add(MainBlocEvent.totalScoreIncreement);
//       bloc.inEvent.add(MainBlocEvent.progressAddTrue);
//     } else {
//       bloc.inEvent.add(MainBlocEvent.questionIndexIncreement);
//       bloc.inEvent.add(MainBlocEvent.progressAddFalse);
//     }
//   }


  // void _getCurrentUser() {
  //   var contactsBox = Hive.box<UserData>('UserData1');
  //   if (contactsBox.isNotEmpty) {
  //     contactsBox.values.forEach((element) {
  //       if (element.isCurrentUser) {
  //         currentUser = element;
  //       }
  //     });
  //   } else {
  //     currentUser = null;
  //   }
  // }

// Select User

// Page navigation

//   void swap0() {
//     cont.animateToPage(0,
//         duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
//   }

  // void _setCurrentUser() {
  //   var contactsBox = Hive.box<UserData>('UserData1');
  //   setState(() {
  //     contactsBox.values.forEach((element) {
  //       if (element.isCurrentUser) currentUser = element;
  //     });
  //   });
  // }

  // void _clearCurrentUser() {
  //   setState(() {
  //     currentUser = null;
  //   });
  // }
// }