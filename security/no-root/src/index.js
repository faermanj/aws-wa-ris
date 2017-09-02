"use strict";

exports.handler = (event, context, callback) => {
  const coeTopicArn = process.env.COE_TOPIC;
  const eventJSON = JSON.stringify(event);
  var params = {
    Message: `${eventJSON}`,
    TopicArn: `${coeTopicArn}`
  };
  const aws = require("aws-sdk");
  const sns = new aws.SNS();
  Promise.all(
    sns
      .publish(params)
      .promise()
      .then(data => callback(null, data))
      .catch(e => callback(e))
  );
};
