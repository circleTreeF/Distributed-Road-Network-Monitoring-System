import 'package:json_annotation/json_annotation.dart';

part 'Record.g.dart';

@JsonSerializable()
///This class represents the history record get from database.
class Record extends Object {
  ///The start time of this driving record
  final String startTime;
  ///The end time of this driving record
  final String endTime;
  /// The mark of this driving record
  final String roundMark;

  Record(this.startTime, this.endTime, this.roundMark);

  /**
  *** @author: Shengnan HU ID: 20126376 Email: scysh1@nottingham.edu.cn
  *** @date: 2021/3/2 7:46 PM
  *** @version:1.0
  **/
  ///Converts Json to [Record]
  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  /**
  *** @author: Shengnan HU ID: 20126376 Email: scysh1@nottingham.edu.cn
  *** @date: 2021/3/2 7:46 PM
  *** @version:1.0
  **/
 ///Converts [Record] to Json
  Map<String, dynamic> toJson(Record instance) => _$RecordToJson(instance);

}