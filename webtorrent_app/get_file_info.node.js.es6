const { exec } = require('child_process');
var child;
var command = `webtorrent create ${process.argv[2]} > fileinfo.torrent && webtorrent info fileinfo.torrent`;

child = exec(command,
  function(error, stdout, stderr)  {
    if(error !== null) {
      throw `An error has occurred: ${error}`
    }
    fileInfo= JSON.parse(stdout);
    console.log(fileInfo['infoHash']);
  }
);

