# Tarea de Patrones de Diseño

Se han usado tres patrones de diseño, los cuales son : Adapter, Abstract Factory y State

La pequeña aplicación presentada consiste en una tienda de útiles escolares, en las que se tiene 3 productos : lapiz, lapicero y cuaderno. Esta tienda acepta pagos en línea y pagos en efectivo. Y además determina si un producto está en stock o no.

## Adapter

Usamos el patron de diseño Adapter para el pago, pueda ser efectivo o en linea. Usando este código:

```
class SistemaVenta
  def procesoPago
  end
end


# Una clase para pagar en efectivo que hereda la clase SistemaVenta
class PagoEfectivo < SistemaVenta 
  def procesoPago(cantidadPagar)
    puts "Ha pagado en efectivo la cantidad de $#{cantidadPagar}"
  end
end

# Un adaptador para realizar el pago online
class PagoOnlineAdapter < SistemaVenta
  def initialize(pagoOnline)
    @pagoOnline = pagoOnline
  end

  def procesoPago(cantidadPagar)
    @pagoOnline.hacerPago(cantidadPagar)
  end
end

# Una clase para realizar pagos online que no se hereda de ninguna otra clase, con métodos diferentes
class PagoOnline
  def hacerPago(cantidadPagar)
    puts "Ha pagado de manera online la cantidad de $#{cantidadPagar}"
  end
end
```

En el que se crea una clase de sistema de venta, que en este caso muy simple solo tendrá un método, de esta se hereda la clase de pago efectivo, sin embargo para el PagoOnlineno hereda esa clase padre, por lo que necesitamos un adaptador que este sí hereda la clase padre. Este patrón se usa más cuando para el pagoOnline se puede usar APIs externas.
## State

Se tienen dos estados de los productos EN STOCK o AGOTADO.


```
class EstadoProducto
  def productoStock
  end
end

class EnStock < EstadoProducto
  def productoStock
    " en stock"
  end
end

class Agotado < EstadoProducto
  def productoStock
    " agotado"
  end
end
```

Para este se tiene una clase padre cuya único método es productoStock, para este caso muy simple. Esta se hereda a dos clases hijas los cuales seran los estados que en ese único método heredado retornan un string con la información requerida.

## Abstract Factory

Y el patrón que se usó para las clases de los productos.


```
class UtilEscolar
  attr_accessor :precio, :cantidad, :marca
  attr_reader :estado
  def initialize(precio,cantidad,marca)
    @precio = precio
    @cantidad = cantidad
    @marca = marca
  end
  def venta
    @cantidad = @cantidad - 1
  end
  def estadoStock
    if @cantidad > 0
      @estado = EnStock.new 
    else 
      @estado = Agotado.new
    end
    
  end
end

# Clases hijas de la clase UtilEscolar

class Lapicero < UtilEscolar
  def initialize(precio,cantidad,marca)
    super(precio,cantidad,marca)
  end
  def venta
    super
    puts "Se ha vendido un lapicero #{@marca}"
  end
  def estadoStock
    super
    puts "El lapicero #{@marca} esta#{@estado.productoStock}"
  end
end

class Lapiz < UtilEscolar
  def initialize(precio,cantidad,marca)
    super(precio,cantidad,marca)
  end
  def venta 
    super
    puts "Se ha vendido un lapiz #{@marca}"
  end
  def estadoStock
    super
    puts "El lapiz #{@marca} esta#{@estado.productoStock}"
  end
end

class Cuaderno < UtilEscolar
  def initialize(precio,cantidad,marca)
    super(precio,cantidad,marca)
  end
  def venta
    super
    puts "Se ha vendido un cuaderno #{@marca}"
  end
  def estadoStock
    super
    puts "El cuaderno #{@marca} esta#{@estado.productoStock}"
  end
end

# Usando Abstract Factory para crear ciertos tipos de productos


class TipoUtilEscolar
  def crearUtilEscolar
  end
end

class UtilEscolarLapiceros 
  def crearUtilEscolar(precioLapicero,cantidadLapiceros,marcaLapicero)
    Lapicero.new(precioLapicero,cantidadLapiceros,marcaLapicero)
  end
end

class UtilEscolarLapices
  def crearUtilEscolar(precioLapiz,cantidadLapices,marcaLapiz)
    Lapiz.new(precioLapiz,cantidadLapices,marcaLapiz)
  end
end

class UtilEscolarCuadernos
    def crearUtilEscolar(precioCuaderno,cantidadCuadernos,marcaCuaderno)
      Cuaderno.new(precioCuaderno,cantidadCuadernos,marcaCuaderno)
    end
end

```

Una clase padre UtilEscolar que hereda a los tres utiles escolares, tiene como atributos el precio (para el pago), la cantidad (para el stock) y la marca (para la fabrica del producto). Usando Abstract Factory, se creo una clase padre *TipoUtilEscolar*, que tiene como clases hijas, las fábricas abstractas de cada útil escolar. 

Usando esas clases, se planteó el siguiente ejemplo :


```
# Se tienen 2 marcas que haces lapices, con diferentes precios

faberCastellLapices = UtilEscolarLapices.new
alpinoLapices = UtilEscolarLapices.new

faberCastellLapiz = faberCastellLapices.crearUtilEscolar(1.50,10,"Faber Castell")
alpinoLapiz = alpinoLapices.crearUtilEscolar(1.20,15,"Alpino")

# Se tiene 2 marcas de lapiceros, con diferentes precios

stabiloLapiceros = UtilEscolarLapiceros.new
pilotLapiceros = UtilEscolarLapiceros.new

stabiloLapicero = stabiloLapiceros.crearUtilEscolar(3.00,1,"Stabilo")
pilotLapicero = pilotLapiceros.crearUtilEscolar(2.00,2,"Pilot")


# Se tiene 2 marcas de cuadernos de diferentes precios

alphaCuadernos = UtilEscolarCuadernos.new
standforCuadernos = UtilEscolarCuadernos.new

alphaCuaderno = alphaCuadernos.crearUtilEscolar(5.00,10,"Alpha")
standforCuaderno = standforCuadernos.crearUtilEscolar(7.50,7,"Standford")

# Imaginemos que se un cliente compra esos productos

precioTotal = faberCastellLapiz.precio + alpinoLapiz.precio + stabiloLapicero.precio + pilotLapicero.precio + alphaCuaderno.precio + standforCuaderno.precio

# El cliente hace una compra en efectivo

pagoEfectivo = PagoEfectivo.new
pagoEfectivo.procesoPago(precioTotal)

# Si el cliente quisiera pagarlo de manera online, usando un adaptador 

pagoOnline = PagoOnline.new
pagoOnlineAdaptado = PagoOnlineAdapter.new(pagoOnline)
pagoOnlineAdaptado.procesoPago(precioTotal)

faberCastellLapiz.venta 
alpinoLapiz.venta
stabiloLapicero.venta
pilotLapicero.venta
alphaCuaderno.venta
standforCuaderno.venta

faberCastellLapiz.estadoStock
alpinoLapiz.estadoStock
stabiloLapicero.estadoStock
pilotLapicero.estadoStock
alphaCuaderno.estadoStock
s
```

En el que se tienen marcas de cada util escolar, se realiza una venta. El pago de las dos formas posibles y mostramos si el producto está en stock o está agotado.


```
Ha pagado en efectivo la cantidad de $20.2
Ha pagado de manera online la cantidad de $20.2
Se ha vendido un lapiz Faber Castell
Se ha vendido un lapiz Alpino
Se ha vendido un lapicero Stabilo
Se ha vendido un lapicero Pilot
Se ha vendido un cuaderno Alpha
Se ha vendido un cuaderno Standford
El lapiz Faber Castell esta en stock
El lapiz Alpino esta en stock
El lapicero Stabilo esta agotado
El lapicero Pilot esta en stock
El cuaderno Alpha esta en stock
El cuaderno Standford esta en stock
```

Ese fue el resultado en la terminal, los lapiceros Stabilo al iniciarlos con un único producto, al hacer la venta, queda agotado como se vio en la terminal al ejecutar el programa


