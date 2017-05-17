<html lang="en">
<head>
  <meta charset="UTF-8">
    <script type="text/javascript" src="js/lib/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/msg/booter.activemq.js"></script>
    <title>消息队列</title>
</head>
<body>
<button id="btnSendQueue" onclick="booter.activemq.sendMsgQueue()">发送队列消息</button>
<button id="btnSendTopic" onclick="booter.activemq.sendMsgTopic()">发布消息</button>
</body>
</html>
