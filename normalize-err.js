var reader = require('line-reader');
var sleep = require('sleep');
var stdev = require( 'compute-stdev' );
var numbers = require('numbers');

outfile = "rs-err.txt";
var fs = require('fs');
fs.writeFile(outfile,'',function(err){});

readFile("error-rate-1500.txt","Ethernet","1500-byte");
readFile("error-rate-9000.txt","Ethernet","9001-byte");
readFile("error-rate-SRS.txt","Ethernet","Diffuse MTU");
readFile("error-rate-Wifi1500.txt","Wifi","1500-byte");
readFile("error-rate-Wifi9000.txt","Wifi","9001-byte");
readFile("error-rate-WifiSRS.txt","Wifi","Diffuse-MTU");
//readFile("sendreceive-9000.txt","rs-err-1500.txt");
//readFile("sendreceive-SRS.txt","rs-err-SRS.txt");


function readFile(infile, type, id){

	var nfd_err = [];
	var ndp_err = [];


	reader.eachLine(infile, function(line, last) {
	line = line.trim();
	//console.log(n+" : "+line);
		var data = line.split("\t");
		//console.log(data[0]+"\t"+data[1]+"\t"+data[2]);
		if(!isNaN(data[1])){
			nfd_err.push(Number(data[1]));
		}
		if(!isNaN(data[2])){
			ndp_err.push(Number(data[2]));
		}

		if(last){

			var min = nfd_err.length;
			//console.log((min<ndp_err.length));
			if( min > ndp_err.length){
				min=ndp_err.length;
			}
			//console.log(min+"\t"+nfd_err.length+"\t"+ndp_err.length);
			nfd_err.splice(min,nfd_err.length);
			ndp_err.splice(min,ndp_err.length);
			console.log(min+"\t"+nfd_err.length+"\t"+ndp_err.length);



			var avg_nfd=numbers.statistic.mean(nfd_err);
			var avg_ndp=numbers.statistic.mean(ndp_err);

			var std_nfd=numbers.statistic.standardDev(nfd_err);
			var std_ndp=numbers.statistic.standardDev(ndp_err);

			var con_nfd=(1.96)*(std_nfd/Math.sqrt(nfd_err.length));
			var con_ndp=(1.96)*(std_ndp/Math.sqrt(ndp_err.length));
			console.log(type+"\t"+id+"\t"+avg_nfd+"\t"+avg_ndp+"\t"+con_nfd+"\t"+con_ndp+"\t"+nfd_err.length+"\t"+ndp_err.length);
			
			
			fs.appendFile(outfile,type+"\t"+id+"\t"+avg_nfd+"\t"+avg_ndp+"\t"+con_nfd+"\t"+con_ndp+"\n",function(err){
				if(err)console.log(err);
			});
			
		}//end last 
	});
}
function average(data){
  var sum = data.reduce(function(sum, value){
    return sum + value;
  }, 0);
  var avg = sum / data.length;
  return avg;
}

