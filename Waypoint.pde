

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
      value = (int) random(256) + "";
    }
    
    if(variable.equals("n")){
      this.name = value;
    } else if(variable.equals("x")){
      this.x = Integer.parseInt(value);
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
    } else if(variable.equals("t")){
      this.type = value;
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
