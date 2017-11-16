"use strict";


exports.handler = (event, context, callback) => {
  console.log(event);
  console.log(context);
  const response = {
    statusCode: 200,
      body: JSON.stringify({
        "event":event,
        "context":context
      })
  };
  callback(null,response);
};