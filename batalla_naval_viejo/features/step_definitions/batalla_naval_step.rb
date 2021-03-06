require_relative '../../app/models/Tablero.rb'
require_relative '../../app/models/Barco.rb'
require_relative '../../app/models/Exceptions.rb'
require_relative '../../app/models/BarcoYaExistenteException.rb'

Given(/^a board with dimensions "(.*?)" x "(.*?)"$/) do |x, y|
  	@tablero = Tablero.new(x.to_i,y.to_i)
end

Given(/^I create a small ship in position "(.*?)"$/) do |coord|
  @tablero.ponerBarcoEn(coord,BarcoChico.new("Foxtrox"))
end

Then(/^position "(.*?)" is not empty$/) do |coord|
  @tablero.posicionVacia(coord).should eq false
end

Then(/^position "(.*?)" is empty$/) do |coord|
  @tablero.posicionVacia(coord).should be true
end


Given(/^I create a large ship in position "(.*?)"$/) do |coords|
  @tablero.ponerBarcoEn(coords,BarcoLargo.new("Delta",2))
end


Given(/^coloco un barco en la posicion "(.*?)"$/) do |coord|
  begin
  	@tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  rescue FueraDelTableroException => @excepcion
  end
end

Then(/^un error de "(.*?)" debe ser lanzada$/) do |excepcion|
  expect(@excepcion.to_s).to eq excepcion
end


Given(/^coloco dos barcos en la posicion "(.*?)"$/) do |coord|
  @tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  begin
  	@tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  rescue BarcoYaExistenteException => @excepcion2
  end
end


Then(/^un error de "(.*?)" debe ser esperado$/) do |excepcion|
  expect(@excepcion2.to_s).to eq excepcion
end

