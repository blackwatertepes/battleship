module PagesHelper
  def boat_classes(boat)
    classes = [boat[:boat][:name].split(' ').first, boat[:dir]]
    if boat[:boat][:length] > 1
      classes << "front" if boat[:n] == 0
      classes << "back" if boat[:n] == boat[:boat][:length] - 1
    else
      classes << "tiny"
    end
    classes
  end
end
