import 'package:easy_dispose/easy_dispose.dart';
import 'package:quiz_app/leaderboard/leaderboard_model.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:rxdart/rxdart.dart';

class LeaderboardBloc extends DisposableOwner {
  LeaderboardBloc({required this.moorDatabase}) {
    getMoorResults();

    _leaderBoardStateSubject.disposeWith(this);
  }

  final MyDatabase moorDatabase;

  static final LeaderboardModel _leaderBoardModel = LeaderboardModel();

  final BehaviorSubject<LeaderboardModel> _leaderBoardStateSubject =
      BehaviorSubject.seeded(_leaderBoardModel);

  LeaderboardModel get leaderboardState => _leaderBoardStateSubject.value;

  Stream<List<MoorResult>?> get moorResultsStream =>
      _leaderBoardStateSubject.stream
          .map((leaderboardModel) => leaderboardModel.moorResults);

  void getMoorResults() async {
    var moorResultsFromDB = await moorDatabase.getAllMoorResults();

    moorResultsFromDB.sort(
      (b, a) => a.rightResultsPercent.compareTo(b.rightResultsPercent),
    );

    _leaderBoardStateSubject.add(
      leaderboardState.copyWith(moorResults: moorResultsFromDB),
    );
  }

  void nullifyLeaderboard() {
    moorDatabase.clearMyDatabase();

    getMoorResults();
  }
}
