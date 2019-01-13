

Waypoint standard;

public class Waypoint{
  
  public Waypoint(){
    name = standard.name;
    x = standard.x;
    y = standard.y;
    z = standard.z;
    rgb = standard.rgb; // clone?
    icon = standard.icon;
    enable = standard.enable;
    type = standard.type;
    dimO = standard.dimO;
    dimN = standard.dimN;
    dimE = standard.dimE;
    persistent = standard.persistent;
    origin = standard.origin;
    
  }
  
  public Waypoint(int useless){
    
  }
  
  public void set(String variable, String value){
    if(value.equals("random")){
      value = ((int) random(256)) + "";
    }
    
    if(variable.equals("n")){
      this.name = value;
    } else if(variable.equals("x")){
      this.x = Integer.parseInt(value);;
    } else if(variable.equals("y")){
      this.y = Integer.parseInt(value);
    } else if(variable.equals("z")){
      this.z = Integer.parseInt(value);
    } else if(variable.equals("i")){
      this.icon = value;
    } else if(variable.equals("r")){
      this.rgb = color(Integer.parseInt(value), green(this.rgb), blue(this.rgb));
    } else if(variable.equals("g")){
      this.rgb = color(red(this.rgb), Integer.parseInt(value), blue(this.rgb));
    } else if(variable.equals("b")){
      this.rgb = color(red(this.rgb), green(this.rgb), Integer.parseInt(value));
    } else if(variable.equals("c")){
      if(value.charAt(0) == '#'){
        value = value.substring(1);
      }
      this.rgb = unhex(value);
    } else if(variable.equals("a")){
      this.enable = toBoolean(value);
    } else if(variable.equals("h")){
      this.origin = value;
    } else if(variable.equals("o")){
      this.dimO = toBoolean(value);
    } else if(variable.equals("n")){
      this.dimN = toBoolean(value);
    } else if(variable.equals("e")){
      this.dimE = toBoolean(value);
    } else if(variable.equals("p")){
      this.persistent = toBoolean(value);
    } else if(variable.equals("w")){
      this.convertCoords = !toBoolean(value);
    }
  }
  
  
  public String get(String variable){
    if(variable.equals("n")){
      return this.name;
    } else if(variable.equals("x")){
      return this.x + "";
    } else if(variable.equals("y")){
      return this.y + "";
    } else if(variable.equals("z")){
      return this.z + "";
    } else if(variable.equals("i")){
      return this.icon;
    } else if(variable.equals("r")){
      return red(this.rgb) + "";
    } else if(variable.equals("g")){
      return green(this.rgb) + "";
    } else if(variable.equals("b")){
      return blue(this.rgb) + "";
    } else if(variable.equals("c")){
      return Integer.toHexString(this.rgb);
    } else if(variable.equals("a")){
      return this.enable;
    } else if(variable.equals("h")){
      return this.origin;
    } else if(variable.equals("o")){
      return this.dimO;
    } else if(variable.equals("n")){
      return this.dimN;
    } else if(variable.equals("e")){
      return this.dimE;
    } else if(variable.equals("p")){
      return this.persistent;
    } else if(variable.equals("w")){
      return this.convertCoords;
    }
    return ""; // so the standard will be taken
  }
  
  
  public void loadWaypoint(String[] data){
    String[] sp;
    String variable, value;
    for(int i = 0; i < data.length; i ++){
      try{
        sp = data[i].split("\": ");
        variable = sp[0].split("\"")[1];
        value = sp[1];
        if(value.charAt(0) == '"'){
          value = value.substring(1, value.length() - 2);
        }
        
        if(variable.equals("dimensions")){
          i ++;
          this.setDimensions(data[i]);
        } else{
          this.set(variable, value);
        }
      } catch(Exception e){
        
      }
      
    }
    
  }
  
  
  
  public void setDimensions(String value){
    dimN = false;
    dimO = false;
    dimE = false;
    
    String[] sp = value.split(" ");
    for(String s : sp){
      if(s.length() > 0){
        if(s.equals("-1")){
          dimN = true;
        } else if(s.equals("0")){
          dimO = true;
        } else if(s.equals("1")){
          dimE = true;
        }
        
      }
      
      
    }
    
    
  }  
  
  
  
  boolean convertCoords;
  
  public String name;
  public int x;
  public int y;
  public int z;
  public int rgb;
  public String icon;
  public boolean enable;
  public String type;
  public boolean dimO, dimN, dimE;
  public String origin;
  public boolean persistent;
  
  
  public String getDimensions(){
    String rV = "";
    if(dimN){
      rV += "-1";
    }
    if(dimO){
      if(rV.length() > 0){
        rV += ",";
      }
      rV += "0";
    }
    if(dimE){
      if(rV.length() > 0){
        rV += ",";
      }
      rV += "1";
    }
    return rV;
  }
  
  
}

public String getLine(String[] dataFormat, Waypoint w){
  String rV = "";
  
  for(int i = 0; i < dataFormat.length; i ++){
    if(i % 2 == 0){
      rV += w.get(dataFormat[i]);
    } else {
      rV += dataFormat[i];
    }
    
  }
  
}

public Waypoint initStandardWaypoint(){
  String[] info = loadStrings("standardWaypoint.txt");
  standard = new Waypoint(0);
  String[] sp;
  for(String data : info){
    sp = data.split(": ");
    standard.set(sp[0], sp[1]);
  }
  return standard;
}


public boolean toBoolean(String value){
  if(value.equals("1")){
    return true;
  } else if(value.equals("True")){
    return true;
  } else if(value.equals("true")){
    return true;
  } else if(value.equals("add more")){
    return true;
  }
  return false;
}
