#!/bin/bash

# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Ctrl+C
function ctrl_c(){
  echo -e "\n${redColour} [!] Saliendo.... ${endColour}" 
  exit 1
}
trap ctrl_c INT


helppanel ()
{
  echo ""
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Para ejecutar la herramienta${endColour} ${blueColour}$0${endColour}${grayColour} es necesario usar la opción -i e indicar la IP${endColour}\n"
  echo -e "${grayColour}Ejemplo:${endColour} ${blueColour}$0 -i 192.168.1.41${endColour}\n"
  exit 0

}
ip_transform ()
{
  tput cinvis
  clear


  local ip=$1
  local mask=${2#/}
  local mask_binari=""
  local ip_binari=""
  local primera_red_binario=""


  echo -e "${yellowColour}[+]${endColour}${grayColour} Bienvenido a $0 esta herramienta sirve para calcular el ${purpleColour}subnetting${endColour} de una ${purpleColour}IP${endColour}${endColour} \n"
  sleep 0.5
  echo -e "${yellowColour}[+]${endColour}${grayColour} IP introducida:${endColour} ${blueColour}$ip${endColour} ${grayColour} con el CIDR: ${blueColour}$mask${endColour}\n"




echo -e "${yellowColour}[+]${endColour}${grayColour} Mostrando la mascara de la red:${endColour}"
  for ((i=1; i<=32; i++)); do
    if [ $i -le $mask ]; then
      mask_binari+="1"
    else
      mask_binari+="0"
    fi
  done

  mask_binari1=${mask_binari:0:8}
  mask_binari2=${mask_binari:8:8}
  mask_binari3=${mask_binari:16:8}
  mask_binari4=${mask_binari:24:8}
  
  mask_decimal=$(echo "ibase=2; $mask_binari1" | bc)
  mask_decimal2=$(echo "ibase=2; $mask_binari2" | bc)
  mask_decimal3=$(echo "ibase=2; $mask_binari3" | bc)
  mask_decimal4=$(echo "ibase=2; $mask_binari4" | bc)


  sleep 1
  echo -e "${greenColour}$mask_decimal.$mask_decimal2.$mask_decimal3.$mask_decimal4${endColour}"


  IFS='.' read -r ip1 ip2 ip3 ip4 <<< "$ip"

  red1=$(( ip1 & mask_decimal ))
  red2=$(( ip2 & mask_decimal2 ))
  red3=$(( ip3 & mask_decimal3 ))
  red4=$(( ip4 & mask_decimal4 ))


  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Mostrando la primera IP disponible:"
  sleep 1
  echo -e "${greenColour}$red1.$red2.$red3.$red4${endColour}"

  inv_mask1=$((255 - mask_decimal))
  inv_mask2=$((255 - mask_decimal2))
  inv_mask3=$((255 - mask_decimal3))
  inv_mask4=$((255 - mask_decimal4))

  broadcast1=$((red1 | inv_mask1))
  broadcast2=$((red2 | inv_mask2))
  broadcast3=$((red3 | inv_mask3))
  broadcast4=$((red4 | inv_mask4))



  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Mostrando la dirección broadcast:${endColour}"
  sleep 1
  echo -e "${greenColour}$broadcast1.$broadcast2.$broadcast3.$broadcast4${endColour}"



  total_hosts=$(echo "2 ^ $((32-$mask))-2" | bc -l)

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Mostrando el total de hosts disponibles:${endColour}"
  sleep 1
  echo -e "${greenColour}$total_hosts${endColour}"

  tput cnorm

}

# getopts
declare -i parametro=0
while getopts "i:m:h" arg; do
  case "$arg" in
  
    i) ip="$OPTARG"; let parametro+=1;;
    m) mascara="$OPTARG"; let parametro+=1;;
    h) helppanel;;

  esac
done

if [ $parametro -eq 2 ];then
  ip_transform "$ip" "$mascara"
else
  helppanel
fi
