var Socket = require('phoenix').Socket;
var RatchetLib = require('ratchetjs');
var Ratchet = RatchetLib.Ratchet;
var PhoenixAdapter = RatchetLib.PhoenixAdapter;

// TODO make socket configurable
var socket = new Socket('/data');
socket.connect();

function channelInit(property) {
  var topic = "data:" + property; // This prefix must always be synchronized with the DataChannel
  var channel = socket.channel(topic);

  channel.join()
    .receive("ok", function(resp) { console.log("Joined \"" + topic + "\"") })
    .receive("error", function(resp) { console.log("Unable to join \"" + topic + "\"") });

  return new PhoenixAdapter(channel);
}

Ratchet.init({channelInit: channelInit});
