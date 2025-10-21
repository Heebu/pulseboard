class JournalEntry {
  final String id;
  final DateTime date;
  final String title;
  final String content;
  final String mood; // e.g. “happy”, “sad”, “neutral”
  final int? moodScore; // optional numeric scale (1–5)
  final String? relatedMetric; // e.g. “heart_rate”, “sleep”

  JournalEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.mood,
    this.moodScore,
    this.relatedMetric,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      content: json['content'],
      mood: json['mood'],
      moodScore: json['moodScore'],
      relatedMetric: json['relatedMetric'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'title': title,
    'content': content,
    'mood': mood,
    'moodScore': moodScore,
    'relatedMetric': relatedMetric,
  };
}
