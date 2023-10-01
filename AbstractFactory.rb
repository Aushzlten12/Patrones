load 'adapter.rb'
load 'State.rb'
# Ahora tenemos una clase de utiles escolares

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
standforCuaderno.estadoStock
