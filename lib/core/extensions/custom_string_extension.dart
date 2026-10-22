extension S on String {
  String get inCaps {
    if (isEmpty) {
      return this;
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach {
    return split(' ')
        .map(
          (str) => str.isNotEmpty ? str.inCaps : str,
    )
        .join(' ');
  }

  String get png => 'assets/images/$this.png';

  String get jpeg => 'assets/images/$this.jpeg';

  String get jpg => 'assets/images/$this.jpg';

  String get svg => 'assets/images/svgs/$this.svgs';

  String get gif => 'assets/images/gifs/$this.gif';
}

