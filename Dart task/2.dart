void main() {
  Map<String, int> runners = {
    "Ahmed": 341,
    "Mohamed": 273,
    "Ismail": 278,
    "Hend": 329,
    "Aly": 445,
    "Hossam": 402,
    "Ola": 388,
    "Alaa": 275,
    "Basma": 243,
    "Mina": 334,
    "Nada": 412,
    "Saad": 393
  };

  List<MapEntry<String, int>> sortedRunners = runners.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  print('Fastest runner: ${sortedRunners[0].key} with time ${sortedRunners[0].value} minutes');

  print('Second fastest runner: ${sortedRunners[1].key} with time ${sortedRunners[1].value} minutes');
}