/**
 * Created by sn on 2017-4-16.
 * proc activemq related
 */

var booter={};
 booter.activemq ={};
var _this=booter.activemq;
$.extend( booter.activemq,
    {
        sendMsgQueue:function()
        {
            $.getJSON("activemq/sendqueue",
            function(json){
                console.log(json);
            }
            )
        },
        sendMsgTopic:function()
        {
            $.getJSON("activemq/sendtopic",
                function(json){
                    console.log(json);
                }
            )
        }
    }
    )
