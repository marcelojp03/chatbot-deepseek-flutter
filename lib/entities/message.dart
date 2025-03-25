enum FromWho { me, bot }

class Message {
  final String text;
  final FromWho fromWho;
  final bool isLoading;

  Message({
    required this.text, 
    required this.fromWho,
    this.isLoading = false
  });
}
