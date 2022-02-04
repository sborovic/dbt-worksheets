class LogEntry {
  static const logsTableName = 'logs';

  static const columnDatetime = 'datetime';
  static const columnTableName = 'table_name';
  static const columnForeignId = 'foreign_id';
  static const columnId = 'id';

  final int datetime;
  final String tableName;
  final int foreignId;

  LogEntry(
      {required this.datetime,
      required this.tableName,
      required this.foreignId});

  LogEntry.fromMap(Map<String, dynamic> map)
      : datetime = map[columnDatetime],
        tableName = map[columnTableName],
        foreignId = map[columnForeignId];
}
