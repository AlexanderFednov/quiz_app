import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/bloc/bloc_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/bloc/new_logic_ultimate.dart';
import 'package:quiz_app/data/logic_model.dart';
import '../../generated/l10n.dart';

// class LastResultWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return LastResultWidgetState();
//   }
// }

class LastResultWidget extends StatelessWidget {
  // final _mainBlocInstance = MainBloc();
  // var _futureLoadLastResults;

  @override
  Widget build(BuildContext context) {
    // var bloc = context.watch<MainBloc>();
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    // return FutureBuilder(
    //     future: _futureLoadLastResults,
    //     builder: (context, snapshot) {
    return StreamBuilder<LogicModel>(
        stream: logicBloc.logicStream,
        builder: (context, snapshot) {
          return Text(
            S.of(context).lastResult(
                  logicBloc.logic.savedScore,
                  logicBloc.logic.savedQuestionLenght,
                ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }
  //         },
  //       );
  //     },
  //   );
  // }

  // void loadSaveScore() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     savedResult = (prefs.getInt('saveScore') ?? 0);
  //     questionsLenght = (prefs.getInt('questionsLenght') ?? 0);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // _futureLoadLastResults = NewLogicUltimate().loadSavedScore();
  //   // loadSaveScore();
  // }
}
