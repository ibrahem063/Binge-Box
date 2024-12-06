abstract class bingeboxStates {}
class bingeboxInitialState extends bingeboxStates {}

class TrendingLoadingState extends bingeboxStates {}
class TrendingDoneState extends bingeboxStates {}
class TrendingErrorState extends bingeboxStates {}

class SeriesDoneState extends bingeboxStates {}
class SeriesErrorState extends bingeboxStates {}
class SeriesLoadingState extends bingeboxStates {}

class MoviesDoneState extends bingeboxStates {}
class MoviesErrorState extends bingeboxStates {}
class MoviesLoadingState extends bingeboxStates {}

class MoviesDetailsDoneState extends bingeboxStates {}
class MoviesDetailsErrorState extends bingeboxStates {}
class MoviesDetailsLoadingState extends bingeboxStates {}

class MovieDetailsInitial extends bingeboxStates {}

class MovieDetailsLoading extends bingeboxStates {}

class MovieDetailsLoaded extends bingeboxStates {
  final List<Map<String, dynamic>> movieDetails;
  final List<Map<String, dynamic>> userReviews;
  final List<Map<String, dynamic>> similarMoviesList;
  final List<Map<String, dynamic>> recommendedMoviesList;
  final List<Map<String, dynamic>> movieTrailersList;
  final List<String> moviesGenres;

  MovieDetailsLoaded({
    required this.movieDetails,
    required this.userReviews,
    required this.similarMoviesList,
    required this.recommendedMoviesList,
    required this.movieTrailersList,
    required this.moviesGenres,
  });
}

class MovieDetailsError extends bingeboxStates {
  final String message;
  MovieDetailsError(this.message);
}

class SearchInitialState extends bingeboxStates {}

// State when the search is loading
class SearchLoadingState extends bingeboxStates {}

// State when search results are successfully loaded
class SearchLoadedState extends bingeboxStates {
  final List<Map<String, dynamic>> searchResults;
  SearchLoadedState(this.searchResults);
}

// State for when an error occurs
class SearchErrorState extends bingeboxStates {
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}


class SeriesDetailsInitial extends bingeboxStates {}

class SeriesDetailsLoading extends bingeboxStates {}

class SeriesDetailsLoaded extends bingeboxStates {
  final List<Map<String, dynamic>> SeriesDetails;
  final List<Map<String, dynamic>> userReviewsSeries;
  final List<Map<String, dynamic>> similarSeriesList;
  final List<Map<String, dynamic>> recommendedSeriesList;
  final List<Map<String, dynamic>> SeriesTrailersList;
  final List<Map<String, dynamic>> SeasonsList;
  final List<String> SeriesGenres;

  SeriesDetailsLoaded({
    required this.SeriesDetails,
    required this.userReviewsSeries,
    required this.similarSeriesList,
    required this.recommendedSeriesList,
    required this.SeriesTrailersList,
    required this.SeasonsList,
    required this.SeriesGenres,
  });
}

class SeriesDetailsError extends bingeboxStates {
  final String message;
  SeriesDetailsError(this.message);
}
class SeriesDetailsSeasonLoaded extends bingeboxStates {
  final List<Map<String, dynamic>> SeasonsList;


  SeriesDetailsSeasonLoaded({
    required this.SeasonsList,

  });
}
