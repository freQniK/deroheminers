#!/bin/bash

UPDATE=0
UPDATEALL=0
GITDIR="/data/data/com.termux/files/home/git"
DEROHEDIR="$GITDIR/derohe"



help_screen() { 
        echo " "
        echo "Android DEROHE Mining v0.2.0  (Fats Domino)"
        echo " "
        echo "Usage:"
        echo "      ./android-derohe.sh [options]"
        echo " "
        echo "Options: "
        echo "          --update-all, Update all dependencies and latest xmrig version."
        echo "          -h|--help,    This help screen."
        echo " "
        exit                

}


compile_derohe_miner() {
        echo "We need to change the TERMUX repo to a more stable one. Select Albatross for best results..."
        sleep 4
        termux-change-repo
        echo "Upgrading system dependencies... (You will need to respond to the prompts)... "
        sleep 2
        apt-get full-upgrade -y
        apt-get -q -y install git libtool binutils golang
        
        if [[ ! -d "$GITDIR" ]]; then
                mkdir "$GITDIR"
        fi
        
        cd "$GITDIR"
        
        if [[ -d "$DEROHEDIR" ]]; then
                rm -rf derohe
        fi
        
        echo "Cloning DEROHE project..."
        sleep 2
        git clone https://github.com/deroproject/derohe
        
        
        echo "Building Mining from Source...."
        sleep 3
        cd "$DEROHEDIR/cmd/dero-miner" && go build 
        echo "Done."
        
        cd /data/data/com.termux/files/home
        ln -s /data/data/com.termux/files/home/git/derohe/cmd/dero-miner/dero-miner dero-miner
        echo "Run: ./derominers.sh"
        
}




while [ "$#" -gt 0 ]; do
        key=${1}

        case ${key} in
                --update)
                        UPDATE=1
                        shift
                        ;;
                --update-all)
                        UPDATEALL=1
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


compile_derohe_miner


