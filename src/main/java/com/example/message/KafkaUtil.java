package com.example.message;


import java.util.Arrays;
import java.util.Properties;

/**
 * Created by sn on 2017-4-15.
 */
public class KafkaUtil {
//    public static void send()
//    {
//        Properties props=new Properties();
//        props.put("bootstrap.servers","localhost:9092");
//        props.put("acks","all");
//        props.put("retries",0);
//        props.put("linger.ms",1);
//        props.put("buffer.memory",33554432);
//        props.put("key.serializer","org.apache.kafka.common.serialization.StringSerializer");
//        props.put("value.serializer","org.apache.kafka.common.serialization.StringSerializer");
//        Producer<String,String> producer=new KafkaProducer<String, String>(props);
//        for (int i=0;i<100;i++){
//            producer.send(new ProducerRecord<String, String>("test",Integer.toString(i),Integer.toString(i)));
//        }
//        producer.close();
//    }
//    public static void consume()
//    {
//        Properties props=new Properties();
//        props.put("bootstrap.servers","localhost:9092");
//        props.put("group.id","demo");
//        props.put("enable.auto.commit","true");
//        props.put("auto.commit.interval.ms","1000");
//        props.put("session.timeout.ms","30000");
//        props.put("key.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
//        props.put("value.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
//        KafkaConsumer<String,String> consumer=new KafkaConsumer<String, String>(props);
//        consumer.subscribe(Arrays.asList("test"));
//        while (true){
//            ConsumerRecords<String,String> records=consumer.poll(100);
//            for (ConsumerRecord<String,String> record:records)
//            {
//                System.out.printf("offset=%d,key=%s,value=%s",record.offset(),record.key(),record.value());
//            }
//        }
//
//    }
}
