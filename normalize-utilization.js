var reader = require('line-reader');
var sleep = require('sleep');
var stdev = require( 'compute-stdev' );
var numbers = require('numbers');

var alpha = 0.05;

readFile("netwokutilization-1500.txt","1500-byte","rs-netwokutilization.txt");
readFile("netwokutilization-9000.txt","9000-byte","rs-netwokutilization.txt");
readFile("netwokutilization-SRS.txt","Diffuse","rs-netwokutilization.txt");


function readFile(infile, titile,outfile){

	var nfd_send = [];//new Array(5);
	var ndp_send = [];//new Array(5);
	var nfd_recv = [];//new Array(5);
	var ndp_recv = [];//new Array(5);


	reader.eachLine(infile, function(line, last) {
	line = line.trim();
	//console.log(n+" : "+line);
		var data = line.split("	");
		if(!data[0].startsWith("#")){
			var index=Number(data[0])-1;
			nfd_send.push(Number(data[2]));
			ndp_send.push(Number(data[3]));
			nfd_recv.push(Number(data[4]));
			ndp_recv.push(Number(data[5]));
		}

		if(last){




				var avg_nfd_send=numbers.statistic.mean(nfd_send);
				var avg_ndp_send=numbers.statistic.mean(ndp_send);
				var avg_nfd_recv=numbers.statistic.mean(nfd_recv);
				var avg_ndp_recv=numbers.statistic.mean(ndp_recv);

				var std_nfd_send=numbers.statistic.standardDev(nfd_send);
				var std_ndp_send=numbers.statistic.standardDev(ndp_send);
				var std_nfd_recv=numbers.statistic.standardDev(nfd_recv);
				var std_ndp_recv=numbers.statistic.standardDev(ndp_recv);


				var con_nfd_send=(1.96)*(std_nfd_send/Math.sqrt(150));
				var con_ndp_send=(1.96)*(std_ndp_send/Math.sqrt(150));
				var con_nfd_recv=(1.96)*(std_nfd_recv/Math.sqrt(150));
				var con_ndp_recv=(1.96)*(std_ndp_recv/Math.sqrt(150));

			var fs = require('fs');
			fs.writeFile(outfile,'',function(err){});
			var c = 1;

				fs.appendFile(outfile,titile+"\t"+avg_nfd_send+"\t"+avg_ndp_send+"\t"+avg_nfd_recv+"\t"+avg_ndp_recv+"\t"+con_nfd_recv+"\t"+con_ndp_recv+"\n",function(err){
					if(err)console.log(err);
				});



		}//end last 
	});
}

