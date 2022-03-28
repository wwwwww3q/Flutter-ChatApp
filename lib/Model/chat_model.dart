class Chat {
  final String name, lastMessage, image, time;
  final bool isActive, isSeen; //dang online hay ko | da~ xem hay chua

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
    this.isSeen = false,
  });
}
