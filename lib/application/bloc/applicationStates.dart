
class ApplicationPageStates{
  final int? page;
  const ApplicationPageStates({this.page});

  ApplicationPageStates copyWith({int? page}){
    return ApplicationPageStates(page: page??this.page);
  }
}
