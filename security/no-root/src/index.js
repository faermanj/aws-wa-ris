"use strict";

const Promise = require("bluebird");
const zlib = Promise.promisifyAll(require('zlib'));
const aws = require("aws-sdk");
const sns = new aws.SNS();
const coeTopicArn = process.env.COE_TOPIC;

const toMessage = (unzipped) => {
  const decoded = unzipped.toString('ascii');
  const logData = JSON.parse(decoded);
  const logEvents = logData.logEvents;
  console.log(`Publishing ${logEvents.length} events`);
  const logEventsStr = JSON.stringify(logEvents);
  const msg = {
    Message: `${logEventsStr}`,
    TopicArn: `${coeTopicArn}`
  };
  return msg;
}

exports.handler = (event, context, callback) => {
  const eventData = event.awslogs.data;
  const eventBuf = new Buffer(eventData, 'base64');

  const promise = zlib.gunzipAsync(eventBuf)
      .then((unzipped) =>  toMessage(unzipped))
      .then((msg) => sns.publish(msg).promise());

  Promise.all([promise])
    .then(data => callback(null, data))
    .catch(e => callback(e));
};