enum Stage {
  saved('Saved'),
  applied('Applied'),
  inProcess('In Process'),
  offering('Offering'),
  closed('Closed');

  const Stage(this.label);

  final String label;
}
