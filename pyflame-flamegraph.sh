#!/bin/bash
echo
echo
echo "Welcome to Pyflame & Flamegraph Installer and Executer"
echo "======================================================"

CUR_DIR="$(dirname "$(readlink -f "$0")")"
PYFLAME_DIR="$CUR_DIR/pyflame-master"
FLAMEGRAPH_DIR="$CUR_DIR/FlameGraph-master"

if [ ! -d $PYFLAME_DIR ]
then
    read -p "Installation is required. Continue? Y/n: " result
    if [ "$result" == "n" ]
    then
        echo "Installation aborted..."
        exit;
    fi
    echo
    echo ">> Start Installation Pyflame"
    sudo apt-get install autoconf automake autotools-dev g++ pkg-config python-dev python3-dev libtool make
    wget https://github.com/uber/pyflame/archive/master.zip -O "$CUR_DIR/pyflame_packege.zip"
    unzip "$CUR_DIR/pyflame_packege.zip"
    rm "$CUR_DIR/pyflame_packege.zip"
    cd "$PYFLAME_DIR"
    ./autogen.sh
    ./configure
    make

    cd $CUR_DIR
    echo ">> Start Installation Flamegraph"
    if [ ! -d $FLAMEGRAPH_DIR ]
    then
        wget https://github.com/brendangregg/FlameGraph/archive/master.zip -O "$CUR_DIR/flamegraph_packege.zip"
        unzip "$CUR_DIR/flamegraph_packege.zip"
        rm "$CUR_DIR/flamegraph_packege.zip"
    fi

    echo ">> Installation complete..."
    echo
fi

PYFLAME_BIN="$PYFLAME_DIR/src/pyflame"
FLAMELGRAPH_BIN="$FLAMEGRAPH_DIR/flamegraph.pl"
DATE=$(date +"%Y_%m_%d_%H_%M")
DATA_DIR="$CUR_DIR/profile_data"
PROFILE_FILE_PATH="$DATA_DIR/Profile_$DATE.txt"
GRAPH_FILE_NAME="$DATA_DIR/Graph_$DATE.svg"

mkdir $DATA_DIR -p

if [ -z ${1} ]; then echo ">> No PID was given as a parameter. Aborted."; exit; else PID=${1}; fi
if [ -z ${2} ]; then SECONDS=1; else SECONDS=${2}; fi

echo ">> Start Profiling"

sudo $PYFLAME_BIN -s $SECONDS -o $PROFILE_FILE_PATH -p $PID
$FLAMELGRAPH_BIN < $PROFILE_FILE_PATH > $GRAPH_FILE_NAME

echo ">> Finishd, Graph is in displayed in Google Chrome now."
echo

x-www-browser $GRAPH_FILE_NAME
