<?php

include('vendor/autoload.php');

$faker = Faker\Factory::create();

$rounds = 10;
$items = 2000;

$days = 1000;

for ($k=-$days;$k<0;$k++) {
    for ($i=0;$i<$rounds;$i++) {
	    echo "INSERT INTO statistics (EventDate,EventDateTime,abonent,send_name_id,distribution_id,partner_id,agregator_id,operator_id, region_id,message_id,sms_send_count,sms_delivered_count) VALUES ";
	
	    $data = array();
	
	    for ($j=0;$j<$items;$j++) {
		    $abonent = '7'.$faker->numberBetween(9000000000,9999999999);
		    $send_name_id = $faker->numberBetween(1,3000);
		    $distribution_id = $faker->numberBetween(1,50000);
		    $partner_id = $faker->numberBetween(1,1500);
		    $agregator_id = $partner_id % 15;
		    $operator_id = $faker->numberBetween(1,2500);
		    $region_id = $faker->numberBetween(1,300);
		    $message_id = '#'.(($k+$days)*$days*$items*$rounds + $i*$items + $j);
		    $sms_send_count = $faker->numberBetween(1,15);
		    $sms_delivered_count = $faker->numberBetween(1,$sms_send_count);
		
		    $eventDateTime = $faker->dateTimeBetween($startDate = $k.' days', $endDate = ($k+1).' days');
				
		    $data2 = array(			
			    "'".$eventDateTime->format('Y-m-d')."'",
			    "'".$eventDateTime->format('Y-m-d H:i:s')."'",
			    $abonent,
			    $send_name_id,
			    $distribution_id,
			    $partner_id,
			    $agregator_id,
			    $operator_id, 
			    $region_id,
			    "'".$message_id."'",
			    $sms_send_count,
			    $sms_delivered_count,			
		    );
		
		    $str = "(".implode(",", $data2).")";
		
		    $data[] = $str;
	    }
	
	    echo implode(',', $data);
	
	    echo ";\n";
    }
}
