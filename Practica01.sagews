# Hoja 1 bitcoin
# Integrantes del grupo: Juan Becerro, David Gómez, Esmeralda Madrazo

# Calculamos p
 p = 2**256 - 2**32 - 2**9 - 2**8 - 2**7 - 2**6 - 2**4 - 1
# Calculamos el número de puntos en modulo 16
finite_field = FiniteField(p)

e = EllipticCurve(finite_field, [0, 7])

puntos = e.order()
puntos_mod = puntos % 16
print("El numero de puntos de la curva en base 16 es: " + str(puntos_mod))

# Comprobamos el teorema de Hasse
dif = abs(puntos - (p + 1))
aux = float(2*sqrt(p))
print("Comprobamos que se cumple el teorema de Hasse: " + str(aux >= dif))

# Comprobamos que G pertenece a la curva
x = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798
y = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8

y_cuadrado = (y**2) % p
x_cubo_mas_siete = (x**3 + 7) % p

iguales = (y_cuadrado == x_cubo_mas_siete)
print("Comprobamos que G pertenece a la curva: " + str(iguales))

G = e(x, y)
# Comprobamos el orden del subgrupo creado por G
orden = order(G)
print("El orden del subgrupo creado por G es " + str(orden))
primo = (orden in Primes())
print("El orden de G es primo: " + str(primo))

# Elección de claves

# Comprobamos que las claves casan

d = 0x45737461206672617365206D65206C612067756172646F2070617261206DED2E

W = e.point([0x1693AAC9007A1C28B2DF4BEB207ECD6C6A150C324E2066897252756F3BFC375A, 0x7F3EF84CC4BBD9C6988E3F77FE38127CF5B8C1513FC399CA26406774722DE01A])

G = e.point([0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798, 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8])

Q = G * d

# Q y W deberían ser iguales
casan = (W == Q)
print("Las claves casan: " + str(casan))

# Si (x, y) está en la curva secp256k1 y conocemos y, ¿Podemos determinar y a partir de x?
# Sí. De hecho, si no pudiésemos, la representación comprimida del punto no tendría sentido, ya que no podríamos obtener la componente x a partir de la y.

# Ejecutamos el ejecutable 01_publica. El archivo de salida ocuoa un total de 66 Bytes El primer Byte es 0x20, que indica que la clave pública está comprimida. Los siguientes 32 Bytes son la coordenada x del punto.
# Tenemos la siguiente clave pública comprimida
clave_comprimida = 0x2103EA1901C0F7B9FB4F22F187CED808141EE30714ADEC3841A7C5209735E0E081E0

# sacamos la componente x
x = 0xEA1901C0F7B9FB4F22F187CED808141EE30714ADEC3841A7C5209735E0E081E0

y_sqr = (x**3 + 7) % p

y = pow(y_sqr, (p+1)/4, p)
# y es impar por tanto tenemos la y correcta, construimos la clave pública
CP = "0x40"
CP += str(hex(x)).upper()[2::]
CP += str(hex(y)).upper()[2::]

print("Nuestra clave pública es " + CP)

# Siguiendo los pasos del PDF podemos descargar el bloque de la altura deseada. Tras esto, transformamos los archivos descargados en archivos binarios como los proporcionados mediante el comando xxd -r -p [fichero].

# Tras ejecutar el ejecutable 01_extrae_scriptPubs sobre el archivo raw del bloque 9 y ejecutar el ejecutable 01_extrae_Pub sobre la salida de este, obtenemos las siguientes coordenadas del punto:

x = 0x11DB93E1DCDB8A016B49840F8C53BC1EB68A382E97B1482ECAD7B148A6909A5C
y = 0xB2E0EADDFB84CCF9744464F82E160BFA9B8B64F9D4C03F999B8643F656B412A3

# Comprobamos que el punto pertenece a la curva

punto = e.point([x, y])
print("El punto pertenece a la curva elíptica")









