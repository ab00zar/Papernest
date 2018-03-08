require 'csv'

class Lambert93converter
  def initialize(x,y)
    @x = x
    @y = y
  end

  def tanh(x)
    if Math.tanh(x)
      Math.tanh(x)
    elsif x == Float::INFINITY
      1
    elsif x == -Float::INFINITY
      -1
    else
      (Math.exp(x) - Math.exp(-x)) / (Math.exp(x) + Math.exp(-x))
    end
  end

  def atanh(x)
    Math.atanh(x) || Math.log((1+x)/(1-x)) / 2
  end

  def compute

    puts "x is #{@x} and y is #{@y}"
    gRS80E = 0.081819191042816
    lONG_0 = 3
    xS = 700000
    yS = 12655612.0499
    n = 0.7256077650532670
    c = 11754255.4261

    delX = @x - xS
    delY = @y - yS

    gamma = Math.atan(-delX / delY)
    r = Math.sqrt(delX * delX + delY * delY)
    latiso = Math.log(c / r) / n
    sinPhiit0 = tanh(latiso + gRS80E * atanh(gRS80E * Math.sin(1)))
    sinPhiit1 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit0))
    sinPhiit2 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit1))
    sinPhiit3 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit2))
    sinPhiit4 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit3))
    sinPhiit5 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit4))
    sinPhiit6 = tanh(latiso + gRS80E * atanh(gRS80E * sinPhiit5))

    longRad = Math.asin(sinPhiit6);
    latRad = gamma / n + lONG_0 / 180 * Math::PI

    longitude = latRad / Math::PI * 180
    latitude = longRad / Math::PI * 180

    #puts "longitude is: #{longitude} and latitude is: #{latitude}"
    return latitude, longitude
  end
end


  CSV.foreach(File.join(File.dirname(__FILE__), 'input.csv'), headers: true, :col_sep => ?;) do |row|
    puts row.inspect
    a = Lambert93converter.new(row[1].to_i, row[2].to_i)
    latitude, longitude = a.compute
    operator = ''
    case row[0]
      when "20801"
        operator = 'Orange'
      when "20810"
        operator = 'SFR'
      when "20815"
        operator = 'Free'
      when "20820"
        operator = 'Bouygue'
      else
        operator = 'Unknown'
    end

    def trueorfalse(x)
      x == 1 ? 'True' : 'False'
    end
    Coverage.create(operator: operator, latitude: latitude, longitude: longitude,
                    g2: trueorfalse(row[3].to_i),
                    g3: trueorfalse(row[4].to_i),
                    g4: trueorfalse(row[5].to_i))
  end