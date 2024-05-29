
class ApplicationPageEvents{
  const ApplicationPageEvents();
}


class PageEvent extends ApplicationPageEvents{
  final int page;
  PageEvent({required this.page});
}