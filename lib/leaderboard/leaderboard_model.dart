import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/moor_database.dart';

class LeaderboardModel extends Equatable {
 final List<MoorResult>? moorResults;

  LeaderboardModel({
    this.moorResults = const [],
  });

  LeaderboardModel copyWith({List<MoorResult>? moorResults}) {
    return LeaderboardModel(
      moorResults: moorResults ?? this.moorResults,
    );
  }

  @override
  List<Object?> get props => [moorResults];
}
