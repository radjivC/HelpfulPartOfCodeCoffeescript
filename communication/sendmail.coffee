nodemailer = require "nodemailer"

smtpTransport = nodemailer.createTransport "SMTP",
    service: "Gmail"
    auth:
        user:
        pass:

mail =
    from: ""
    to: "@tumblr.com"
    subject:""
    text: "Test sending mail to tumblr by coffeescript and nodemailer"

smtpTransport.sendMail mail, (error, response) ->
    if error
        console.log(error)
    else
        console.log("Message sent: " + response.message)
    smtpTransport.close()
