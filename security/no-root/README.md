Fires an event when root logs in
https://aws.amazon.com/blogs/security/how-to-receive-notifications-when-your-aws-accounts-root-access-keys-are-used/


const aws = require("aws-sdk");
        const sns = new aws.SNS();
        const publish = sns.publish(params).promise();

        console.log(eventStr);
        var params = {
          Message: `${eventStr}`,
          TopicArn: `${coeTopicArn}`
        };  
        return parms;