# Pyflame & Flamegraph Installer and Executer
This Script installs the actual master of pyflame and flamegraph to the current folder.
After installation, run the script again and you can profile a given python program by process-id the number of seconds you want.

Having profiling finished, the script automatically runs Google Chrome and shows the profiled Flamegraph.

All profiled data is saved in the automatic created "profile_data" folder.

Parameters
----------
$1: Process ID of the to profile python program

$2: Number of Seconds you want to profile it

Example Usage
----------
With following command you profile the process "45632" 5 seconds.

pyflame-flamegraph.sh 45632 5

Contribute
----------
You have got ideas or suggestions? Please feel free to contribute by forking, or contacting me. 
