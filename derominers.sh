#!/bin/bash

#if [[ -f "worker_name" ]]; then
#        worker_name=`cat worker_name`
#else
#        echo -ne "Enter Worker Name (no spaces):  "
#        read worker_name
#        echo "$worker_name" > worker_name
#fi

DAEMON=""
THREADS=""
help_screen() { 
        echo " "
        echo "AndroidXmrig For DERO v0.2.0  (Fats Domino)"
        echo " "
        echo "Usage:"
        echo "      ./derominers.sh [options]"
        echo " "
        echo "Options: "
        echo "          --mathnodes,         Update all dependencies and latest xmrig version. value will be stored"
        echo "          --daemon <ip:port>,  set this as your permanent DEROHE daemon to use. value will be stored"
        echo "          --threads <n>,       no. of threads to use. value will be stored"
        echo "          -h|--help,           This help screen."
        echo " "
        exit                

}


run_derohe_miner() {

if [[ -f "derohe_wallet_address" ]]; then
        derohe_wallet_address=`cat derohe_wallet_address`
else
        echo -ne "DERO Wallet Address: "
        read derohe_wallet_address
        echo "$derohe_wallet_address" > derohe_wallet_address
fi

if [[ -f "derohe_daemon" ]] && [[ -z "$DAEMON" ]]; then
        DAEMON=`cat derohe_daemon`
else
        if [[ -z "$DAEMON" ]]; then
                echo "Pleas enter a daemon, either --mathnodes or your personal one. i.e., --daemon x.x.x.x:10100"
                exit
        else
                echo "$DAEMON" > derohe_daemon
        fi
fi

if [[ -f "derohe_threads" ]] && [[ -z "$THREADS" ]]; then
        THREADS=`cat derohe_threads`
else
        if [[ -z "$THEREADS" ]]; then
                echo "Setting default of 8 threads since not specified"
                THREADS=8
                echo "$THREADS" > derohe_threads
        else
                echo "$THREADS" > derohe_threads
        fi
fi

echo "Beginning DEROHE mining with: "
echo "$THREADS threads"
echo "Daemon: $DAEMON"
echo "Wallet Address: $derohe_wallet_address"
echo " "
echo "These options will be stored so you can just run $0 on next go around"
echo -ne "Starting"
sleep 1
echo -ne "."
sleep 1
echo -ne "."
sleep 1
echo -ne "."
./dero-miner --daemon-rpc-address=$DAEMON --wallet-address=$derohe_wallet_address --mining-threads=$THREADS

}


while [ "$#" -gt 0 ]; do
        key=${1}

        case ${key} in
                --mathnodes) 
                        DAEMON="dero.mathnodes.com:10100"
                        shift
                        ;;
                --daemon)
                        DAEMON=${2}
                        shift
                        shift
                        ;;
                --threads)
                        THREADS=${2}
                        shift
                        shift
                        ;;
                -h|--help)
                        help_screen
                        shift
                        ;;

                *)
                        shift
                        ;;
        esac
done

run_derohe_miner
