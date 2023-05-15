class SubToggle extends Toggle {

  // Define toggle properties
  public SubToggle(float x, float y, boolean status) {
    super(x, y, status);
    currentX = x;
  }

  void switchSubToggle() {
    if (t.status == true) {
      switchToggle();
    } else {
      currentX = x;
      toggleBgColor = 43;
      switchColor = 142;
      status = false;
    }

    //draw Toggle
    display();
  }
}
