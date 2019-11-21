Stream<int> counter(){
  return Stream.periodic(Duration(seconds: 1),(i)=>i);
}