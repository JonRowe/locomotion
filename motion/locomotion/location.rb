module Locomotion
  class Location

   def init(original)
     @original = original
     self
   end

   def latitude
     @original.coordinate.latitude
   end

   def longitude
     @original.coordinate.longitude
   end

   def speed
     @original.speed
   end

   def heading
     @original.course
   end

   def time
     @original.timestamp
   end

   def accuracy
     @original.horizontalAccuracy
   end

   def inspect
     "<Location #{latitude} #{longitude} >"
   end
   alias :to_s :inspect
  end
end
