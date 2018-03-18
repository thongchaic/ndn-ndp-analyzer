var reader = require('line-reader');
var sleep = require('sleep');
var stdev = require( 'compute-stdev' );
var numbers = require('numbers');

var fs = require('fs');


readFile("status-1500.txt",1500);
readFile("status-9000.txt",9000);
readFile("status-SRS.txt",1);


function readFile(infile, mtu){
	
	fs.writeFile("analyze-"+infile,'',function(err){});
	var nfd_err = [];
	var ndp_err = [];
	var n = 1;

	reader.eachLine(infile, function(line, last) {
		line = line.trim();

		var data = line.split("\t");
		var NfdInInterest = data[0].replace('counters={in={','');
		NfdInInterest = NfdInInterest.replace('i','')
		var NdpInInterest = data[1].replace('counters={in={','');
		NdpInInterest = NdpInInterest.replace('i','')

		var NfdInData = data[2].replace('d','');
		var NdpInData = data[3].replace('d','');

		console.log(NfdInInterest+'\t'+NdpInInterest+"\t"+NfdInData+"\t"+NdpInData)

		fs.appendFile("analyze-"+infile,NfdInInterest+"\t"+NdpInInterest+"\t"+NfdInData+"\t"+NdpInData+"\n",function(err){
			if(err)console.log(err);
		});
			
		n++;
	});//end of reader
}
function average(data){
  var sum = data.reduce(function(sum, value){
    return sum + value;
  }, 0);
  var avg = sum / data.length;
  return avg;
}

