require 'yaml'
require 'pp'

class LogData
  attr_accessor :text, :memo
  def initialize
    @text
    @memo
  end

end

class DataFile
  def initialize
    @hashlist = LogData.new
  end

  def set_txt(str)
    @hashlist.text = str
  end

  def set_memo(str)
    @hashlist.memo = str
  end

  def get_txt
    @text
  end

  def get_memo
    @memo
  end
  
  def to_yaml(filename)
    str = YAML.dump(@hashlist)
    yf = File.open(filename + ".yaml", "w")
    yf.print str
    yf.close
  end

  def read_yaml(filename)
    yf = File.open(filename, "r")
    yaml = YAML.load(yf.read)
    @text = yaml.text
    @memo = yaml.memo
  end
end
