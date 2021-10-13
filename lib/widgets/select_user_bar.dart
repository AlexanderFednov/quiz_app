// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quiz_app/bloc/current_user_class.dart';
// import 'package:quiz_app/screens/user_list.dart';

// class SelectUserBar {
//   void selectUser(BuildContext context) {
//     var currentUserClass = Provider.of<CurrentUserClass>(context);
//     var currentUser = currentUserClass.currentUser;
//     showDialog(
//         context: context,
//         builder: (_) => Center(
//               child: Container(
//                 width: double.infinity,
//                 height: 300,
//                 child: Dialog(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       colors: [Colors.white, Colors.blue[100]!, Colors.red[100]!],
//                     )),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                               margin: EdgeInsets.only(bottom: 20),
//                               child: Text('Выбор пользователя',
//                                   style: TextStyle(fontSize: 30))),
//                           Container(
//                             child: Text('Текущий пользователь:',
//                                 style: TextStyle(fontSize: 20)),
//                           ),
//                           currentUser != null
//                               ? Column(
//                                   children: [
//                                     Container(
//                                       //margin: EdgeInsets.only(top: 10),
//                                       child: Text('${currentUser.userName}',
//                                           style: TextStyle(
//                                               fontSize: 35,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                     Container(
//                                       margin:
//                                           EdgeInsets.symmetric(vertical: 20),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.of(context).pop(),
//                                             child: Text('Ок',
//                                                 style: TextStyle(fontSize: 25)),
//                                           ),
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           UserList()),
//                                                 );
//                                               },
//                                               child: Text('Изменить',
//                                                   style:
//                                                       TextStyle(fontSize: 25)))
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               : Column(
//                                   children: [
//                                     Container(
//                                       //margin: EdgeInsets.all(20),
//                                       child: Text('Не выбран',
//                                           style: TextStyle(
//                                               fontSize: 30,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(top: 30),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () => null,
//                                             child: Text('Ок',
//                                                 style: TextStyle(
//                                                     fontSize: 25,
//                                                     color: Colors.grey)),
//                                           ),
//                                           TextButton(
//                                               onPressed: () => {
//                                                     Navigator.of(context).push(
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               UserList()),
//                                                     )
//                                                   },
//                                               child: Text(
//                                                 'Выбрать',
//                                                 style: TextStyle(fontSize: 25),
//                                               ))
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                         ]),
//                   ),
//                 ),
//               ),
//             ),);
//   }
// }
