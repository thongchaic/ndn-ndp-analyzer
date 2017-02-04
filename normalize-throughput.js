var reader = require('line-reader');
var sleep = require('sleep');
var stdev = require( 'compute-stdev' );
var numbers = require('numbers');

var alpha = 0.05;

readFile("bandwidth-9000.txt","rs-throughput-9000.txt");
readFile("bandwidth-1500.txt","rs-throughput-1500.txt");
readFile("bandwidth-SRS.txt","rs-throughput-diffuse.txt");

function readFile(infile,outfile){

	var nfd = new Array(30).fill(0);
	var ndp = new Array(30).fill(0);
	var len = new Array(30).fill(0);

	for(var i=0;i<nfd.length;i++){
		nfd[i] = [];
		ndp[i] = [];
	}

	reader.eachLine(infile, function(line, last) {
	line = line.trim();
	//console.log(n+" : "+line);
		var data = line.split("	");
		if(!isNaN(data[1])){

			var index=Number(data[1])-1;
			var nfdl = Number(data[2]);
			var ndpl = Number(data[3]);
			if(nfdl>0 && ndpl>0){
				nfd[index].push(nfdl);
				ndp[index].push(ndpl);
			}

			//console.log(index+" "+nfd[index]+" : "+last);
			//sleep.sleep(1);
		}

		if(last){

			var nfd_average = new Array(30).fill(0);
			var ndp_average = new Array(30).fill(0);
			var nfd_std = new Array(30).fill(0);
			var ndp_std = new Array(30).fill(0);
			var nfd_conf = new Array(30).fill(0);
			var ndp_conf = new Array(30).fill(0);


			var N=nfd[0].length;

			for (var i = 0; i < nfd.length ; i++) {
				//console.log(nfd[i]);
				var nfd_avg = average(nfd[i]);
					nfd_average[i] = nfd_avg;
				var ndp_avg = average(ndp[i]);
					ndp_average[i] = ndp_avg;

				nfd_std[i] = numbers.statistic.standardDev(nfd[i]);
				ndp_std[i] = numbers.statistic.standardDev(ndp[i]);

				nfd_conf[i] = (1.96)*(nfd_std[i]/Math.sqrt(N));
				ndp_conf[i] = (1.96)*(ndp_std[i]/Math.sqrt(N));
			}
			//console.log(nfd);
			//console.log(ndp);
			var fs = require('fs');
			fs.writeFile(outfile,'',function(err){});
			var c = 1;
			for (var i = 0; i < nfd_average.length ; i++) {
				fs.appendFile(outfile,c+"\t"+nfd_average[i]+"\t"+ndp_average[i]+"\t"+nfd_conf[i]+"\t"+ndp_conf[i]+"\t"+nfd_std[i]+"\t"+ndp_std[i]+"\t"+N+"\n",function(err){
					if(err)console.log(err);
				});
				c++;
			}
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

