module PagesHelper
  def boat_classes(boat)
    classes = []
    if boat && boat.ship
      classes = [boat.ship.name.split(' ').first, boat.dir]
      if boat.ship.length > 1
        classes << "front" if boat.n == 0
        classes << "back" if boat.n == boat.ship.length - 1
      else
        classes << "tiny"
      end
    end
    classes
  end
end
