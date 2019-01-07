const path = require('path');
const process = require('process');
const fs = require('fs');
const { spawn } = require('child_process');

const cwd = process.cwd();

const logDir = path.join('/tmp');

const lines = [];

const tscPath = path.join(cwd, 'node_modules', '.bin', 'tsc');

let activePointer = {
  mtime: 'initial'
};

function getLogs(cb) {
  const ls = spawn('tsc', ['--watch', '--noEmit', '--extendedDiagnostics']);
  ls.stdout.on('data', (data) => {
    process.stdout.write(data.toString());
    cb(data.toString());
  });
  ls.stderr.on('data', (data) => {
    console.log(`stderr: ${data}`);
  });

  ls.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
  });
}

getLogs(function(logLine) {
  if (logLine.trim().length === 0) return null;
  lines.push(logLine);
  const startMatch = logLine.match(/Starting incremental compilation/);
  const endMatch = logLine.match(/Found \d errors. Watching for file changes./);
  //console.log(logLine, startMatch, endMatch);
  if (startMatch) {
    const previousLine = lines[lines.length - 1 - 1];
    //console.log('previousLine', previousLine);
    const match = previousLine.match(/(.*)with\s(.*)\s1::\sWatchInfo(.*)/);
    if (previousLine && match) {
      const triggerFilePath = match[2];
      fs.stat(path.join(triggerFilePath), function(err, stats) {
        console.log(stats);
        activePointer = {
          mtime: stats.ino.toString(),
          //mtime.getTime().toString()
          file: triggerFilePath,
          start: lines.length
        };
      });
    }
  } else if (endMatch) {
    //console.log('endedcompilate', logLine, activePointer);
    if (!activePointer) {
      console.log('returning', endMatch);
      return null;
    };
    const outputLines = lines.slice(activePointer.start, lines.length);
    const outputPath = path.join(logDir, activePointer.mtime);

    fs.writeFile(outputPath, outputLines.join('\n'), function(err) {
      if (err) {
        console.log('Unable to write logs', activePointer, err);
      } else {
        console.log('wrotefile', outputPath);
      }
      //activePointer = null;
    });
  }
});
