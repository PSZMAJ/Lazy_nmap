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
	echo " Przykladowa sciezka do slownikow -> /usr/share/wordlists    ex. /usr/share/wordlists/rockyou.txt"
	echo "Zawartosc katalogu wordlist"
	ls /usr/share/wordlists
	echo -e "\e[35m Podaj sciezke do slownika z loginami \e[0m" 
	read login
	echo -e "\e[35m Podaj sciezke do slownika z haslami \e[0m" 
	read haslo
	sudo nmap --script ssh-brute -p22 $cel --script-args userdb=$login,passdb=$haslo
	sudo ./lazy_nmap.sh
	
}
#6
sV_skan()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	sudo nmap -sV $cel
	sudo ./lazy_nmap.sh
}
#7
O_skan()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	sudo nmap -O $cel | grep OS
	sudo ./lazy_nmap.sh
}
#8
Szybki_skan()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	sudo nmap -T5 $cel
	sudo ./lazy_nmap.sh
}
Szczegolowe_info_port()
{
	echo -e "\e[35m Podaj IP celu \e[0m"
	read cel
	echo -e "\e[35m Podaj numer portu \e[0m"
	read port
	sudo nmap $cel -PO -sV -p $port
	sudo ./lazy_nmap.sh
}


update()
{
	sudo cd ..
	sudo rm -rI lazy_nmap
	yes
	git clone https://github.com/PSZMAJ/Lazy_nmap.git
	cd lazy_nmap
	chmod +x lazy_nmap.sh
	echo echo -e "\e[35m Aktualizacja tool'a zakonczona \e[0m"
	sudo ./lazy_nmap
}


figlet -f pagga Lazy Nmap 
echo -e "\e[31m [---------L-A-Z-Y--N-M-A-P------BY-PRZEMO---V.1-0-----------------------------]\e[0m"
echo -e "\e[31m [ ] - Wyczysc ekran - ENTER \e[0m"
echo -e "\e[31m [1] - Pokaz IP Bramy w Twojej sieci \e[0m"
echo -e "\e[31m [2] - Pokaz dostepne cele - skanowanie pingiem \e[0m"
echo -e "\e[31m [3] - Pokaz adres MAC celu- skanowanie pingiem \e[0m"
echo -e "\e[31m [4] - Pokaz stan portu SSH \e[0m"
echo -e "\e[31m [5] - Wykonaj atak BruteForce SSH \e[0m"
echo -e "\e[31m [6] - Skanuj numery wersji i uslugi \e[0m"
echo -e "\e[31m [7] - Pokaz system operacyjny hosta \e[0m"
echo -e "\e[31m [8] - Wykonaj szybki skan hosta \e[0m"
echo -e "\e[31m [9] - Pokaz szczegolowe informacje o konkretnym porcie \e[0m"
echo -e "\e[31m [U] - Aktualizuj Lazy_Nmap \e[0m"

echo -e "\e[31m [----------------------------------------------------------------------------] \e[0m"


read opcja
case "$opcja" in


  "1") pokaz_ip_bramy ;;
  "2") pokaz_dostepne_cele ;;
  "3") pokaz_adres_MAC ;;
  "4") Pokaz_Port_ssh ;;
  "5") SSH_Brute ;;
  "6") sV_skan ;;
  "7") O_skan ;;
  "8") Szybki_skan ;;
  "9") Szczegolowe_info_port ;;
  "20") update ;;


  *) clear && ./lazy_nmap.sh
  
esac

 

