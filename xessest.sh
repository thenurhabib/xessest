#!/usr/bin/bash
nic=`ip -o -4 route show to default | awk '{print $5}'`
if [ -z "$nic" ];
then
    printf "No Network Interfaces found. \n please Check your Network and try again\n"
    exit
else
    figlet-figlet  "Xessest"
    printf "   Mac Address Changer Tool. \n "
    printf "  Author : Md. Nur Habib. \n \n"
    printf  "wait few secound, loading... \n \n"
    sleep 2s;
    printf "Network Interfaces running ==> $nic\n"
    printf "Only one interface should run at a time! Disable the others.\n \n"
    while true
    do
        read -p " You Want to Run this script now?(Y/N) " answer
        case $answer in
            [yY]* ) for i in $nic; do
                    ifconfig $i down
                    echo "$i is down....."
                    sleep 2
                    macchanger -r $i
                    sleep 2
                    ifconfig $i up
                    echo "$i is up....."
                    sleep 1
                done
                echo "....................."
                sleep 2
                echo "Setting DNS....."
                /bin/bash /root/scripts/dns_set.sh
                echo "SUCCESSFUL"
            break;;
            [nN]* ) exit;;
            * )     echo "Just enter Y or N, please.";
        esac
    done
fi