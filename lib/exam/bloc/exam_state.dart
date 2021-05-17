part of 'exam_cubit.dart';

enum ExamStatus { initial, started, inProgress, ended}

class ExamState extends Equatable {
  const ExamState._({
    this.status = ExamStatus.initial,
    this.duration = 0
    // this.questions = const <Question>[],
  });

  const ExamState.inital(): this._();

  const ExamState.started() :this._(status : ExamStatus.started);

  const ExamState.inProgress({
    @required int duration
  }): this._(status: ExamStatus.inProgress, duration:duration);

  const ExamState.ended() :this._(status : ExamStatus.ended);

  final ExamStatus status;
  final int duration;
  // final List<Question> questions;

  @override
  List<Object> get props => [status, duration];

}