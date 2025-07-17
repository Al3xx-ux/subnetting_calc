# subnetting_calc

Una herramienta para terminal escrita en **Bash** para calcular el **subnetting** de una IP con el CIDR.

---

## Características

- Convierte la máscara CIDR a decimal.
- Calcula la dirección de red.
- Calcula la dirección **broadcast**.
- Muestra el total de **hosts disponibles**.

---

## Ejemplo de uso

```bash
chmod +x subnet.sh
./subnet.sh -i 192.168.1.10 -m /24
```
## Salida esperada
```bash
[+] Bienvenido a ./subnetting.sh esta herramienta sirve para calcular el subnetting de una IP 

[+] IP introducida: 192.168.1.10  con el CIDR: 24

[+] Mostrando la mascara de la red:
255.255.255.0

[+] Mostrando la primera IP disponible:
192.168.1.0

[+] Mostrando la dirección broadcast:
192.168.1.255

[+] Mostrando el total de hosts disponibles:
254
```


