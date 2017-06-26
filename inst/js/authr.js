(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.authr = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

var makeQueryString = function makeQueryString(_ref) {
  var main_url = _ref.main_url,
      _ref$response_type = _ref.response_type,
      response_type = _ref$response_type === undefined ? "token" : _ref$response_type,
      api_key = _ref.api_key,
      redirect_uri = _ref.redirect_uri,
      scope = _ref.scope;

  return [main_url, '?response_type=' + response_type, '&client_id=' + api_key, '&redirect_uri=' + redirect_uri, '&scope=' + scope.join("%20")].join('');
};

var addressBar = function addressBar() {
  var info = window.location;
  return {
    main_url: info.href,
    has_token: info.hash ? true : false,
    options: info.hash,
    go_to: function go_to(newUrl) {
      return info.replace(newUrl);
    }
  };
};

var parseToken = function parseToken(url) {
  return url.split("#access_token=")[1];
};
var buttonText = function buttonText(dom_target, message) {
  return document.getElementById(dom_target).innerHTML = message;
};
var clearURLOptions = function clearURLOptions() {
  return window.history.pushState(null, null, window.location.pathname);
};
var authButton = function authButton(_ref2) {
  var dom_target = _ref2.dom_target,
      main_url = _ref2.main_url,
      _ref2$response_type = _ref2.response_type,
      response_type = _ref2$response_type === undefined ? "token" : _ref2$response_type,
      api_key = _ref2.api_key,
      scope = _ref2.scope,
      _ref2$onTokenReceive = _ref2.onTokenReceive,
      onTokenReceive = _ref2$onTokenReceive === undefined ? function (token) {
    return console.log("Token is, ", token);
  } : _ref2$onTokenReceive;

  console.log("authr has run");
  var page = addressBar(),
      hasToken = page.has_token,
      apiQuery = makeQueryString({ main_url: main_url, api_key: api_key, redirect_uri: page.main_url, scope: scope }),
      token = hasToken ? parseToken(page.options) : "no token yet";

  if (hasToken) {
    buttonText(dom_target, "Logged In");
    onTokenReceive(token);
    clearURLOptions(); //hide ugly url. 
  } else {
    buttonText(dom_target, "Log In");
    document.getElementById(dom_target).onclick = function () {
      return page.go_to(apiQuery);
    };
  }

  return {
    sendToShiny: function sendToShiny() {
      return console.log("sending this token to shiny noao", token);
    }
  };
};

module.exports = authButton;

},{}]},{},[1])(1)
});