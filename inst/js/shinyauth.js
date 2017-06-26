//logic for returning to shiny goes here.
const sendToShiny = (id) => {
  const send_dest = id + "token";
  return (token) => Shiny.onInputChange(send_dest, token);
};

$(document).on('shiny:connected', event => {
    console.log("shiny is connected.");

    //watch for message from server saying it's ready.
    Shiny.addCustomMessageHandler("initialize_button",
        params => {
          console.log("params", params)
          params.onTokenReceive = sendToShiny(params.id);
          const loginButton = authr( params );
        }
    );
});
