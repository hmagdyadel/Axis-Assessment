class PaginationState {
  final int currentPage;
  final int totalPages;
  final bool isLoading;

  const PaginationState({
    this.currentPage = 0,
    this.totalPages = 1,
    this.isLoading = false,
  });

  /// Check if there are more pages
  bool get hasMore => currentPage < totalPages - 1;

  PaginationState copyWith({
    int? currentPage,
    int? totalPages,
    bool? isLoading,
  }) {
    return PaginationState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
