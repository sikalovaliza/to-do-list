class Task {
  String id;
  String text;
  String importance;
  int deadline;
  bool done;
  String color;
  int createdAt;
  int changedAt;
  String lastUpdatedBy;
  
  Task({
    required this.id,
    required this.text,
    required this.importance,
    required this.done,
    this.deadline = 0,
    this.color = "#FFFFFF",
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      text: json['text'],
      importance: json['importance'],
      deadline: json['deadline'] ?? 0,
      done: json['done'],
      color: json['color'] ?? "#FFFFFF",
      createdAt: json['created_at'],
      changedAt: json['changed_at'],
      lastUpdatedBy: json['last_updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'importance': importance,
      'deadline': deadline,
      'done': done,
      'color': color,
      'created_at': createdAt,
      'changed_at': changedAt,
      'last_updated_by': lastUpdatedBy,
    };
  }
}


List<Task> items = [
    Task(id: '0', text: "помыть посуду", importance: "important", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '1', text: "вымыть полы", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '2', text: "развесить вещи", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '3', text: "вытереть пыль", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '4', text: "приготовить еду", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '5', text: "отключить телевизор", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '6', text: "написать заявление", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '7', text: "позонить маме", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '8', text: "купить продукты", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3"),
    Task(id: '9', text: "заказать самовар", importance: "low", done: false, createdAt: 12345678, changedAt: 12345678, lastUpdatedBy: "3")
];

