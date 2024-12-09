class Result {
  final double confidence;
  final int index;
  final String label;
  final Map<String, double> boundingBox; // Bounding box as a map

  Result(
      this.confidence,
      this.index,
      this.label,
      this.boundingBox, // Add bounding box to constructor
      );
}
