class WeatherLog{
  int? temperature;
  String? wind;
  String? cloudCover;
  int? humidity;
  String? comments;

  Map<String, dynamic> toJson() => {
    'temperature': temperature,
    'wind': wind,
    'cloudCover': cloudCover,
    'humidity': humidity,
    'comments': comments,
  };
}