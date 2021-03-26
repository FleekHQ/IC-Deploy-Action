import hello from 'ic:canisters/hello';

hello.greet(window.prompt("Enter your awesome name!:")).then(greeting => {
  window.alert(greeting);
});
