

public void setup(){
  size(280, 160);
  
  savedWps = 0;
  // TODO error screen
  try{
    initStandardWaypoint();
    String[] dataFormat = initDataFormat();
    
    
    // TODO init standard + dataFormat
    convertDataFile(dataFormat, loadStrings("waypoints.txt"));
    
    if(savedWps == 1){
      println("1 Waypoint is converted");
    } else {
      println(savedWps + " Waypoints are converted");
    }
    println("You can now add them to:");
    println("\t.minecraft/journeymap/data/mp/Minecraft~Server/waypoints");
    
    exit();
  } catch (Exception e){
    background(230, 0, 0);
    text("there is an ERROR", 0, 0, width, height / 2.0);
    println("there is an ERROR");
    text(e + "", 0, height / 2.0, width, height / 2.0);
    println(e);
    
  }
  
  
}

int savedWps;



/*
  dataFormat:
  0 "" // furst can be "" but rest cant
  1 "n" // only vars if the standard shall be
  2 ": "
  3 "x"
  ...
  
  -> odd r vars
  
  
  
*/

public String[] initDataFormat(){
  String[] rV = new String[0];
  String data = loadStrings("dataFormat.txt")[0];
  for(int i = 0; i < data.length(); i ++){
    if(isAVariable(data.charAt(i))){
      rV = append(append(rV, data.charAt(i) + ""), "");
    } else {
      rV[rV.length - 1] += data.charAt(i);
    }
    
  }
  
  return rV;
}




public void convertDataFile(String[] dataFormat, String[] dataFile){
  for(String data : dataFile){
    saveWaypoint(convertData(dataFormat, data));
  }
}


public Waypoint convertData(String[] dataFormat, String data){
  Waypoint rV = new Waypoint(); // the waypoint to be returned (rV = returnValue)
  int idF = 1; // index in dataFormat
  int lastIndex = 0;
  
  
  if(dataFormat[0].length() < 1){
    // start with the variable
    // TODOD is that needed?
  }
  
  
  for(int i = 0; i < data.length(); i ++){
    if(isEqual(data, i, dataFormat[idF])){
      // test wether the next seperation is reached
      // if so then save cur and and update cur (done), update idF
      rV.set(dataFormat[idF - 1], data.substring(lastIndex, i));
      
      lastIndex = i + dataFormat[idF].length();
      i = lastIndex - 1;
      
      idF += 2;
    }
  }
  
  
  return rV;
}


public boolean isEqual(String data, int dataIndex, String toCompare){
  
  for(int i = 0; i < toCompare.length(); i ++){
    if(data.charAt(dataIndex) != toCompare.charAt(i)){
      return false;
    }
    dataIndex ++;
  }
  
  return true;
}


public void saveWaypoint(Waypoint w){
  String fileName = w.name + "_" + w.x + "," + w.y + "," + w.z;
  
  String[] info = new String[18];
  info[0] = "{";
  info[1] = "  \"id\": \"" + fileName + "\"";
  info[2] = "  \"name\": \"" + w.name + "\",";
  info[3] = "  \"icon\": \"" + w.icon + "\",";
  info[4] = "  \"x\": " + w.x + ",";
  info[5] = "  \"y\": " + w.y + ",";
  info[6] = "  \"z\": " + w.z + ",";
  info[7] = "  \"r\": " + red(w.rgb) + ",";
  info[8] = "  \"g\": " + green(w.rgb) + ",";
  info[9] = "  \"b\": " + blue(w.rgb) + ",";
  info[10] = "  \"enable\": " + w.enable + ",";
  info[11] = "  \"type\": \"" + w.type + "\",";
  info[12] = "  \"origin\": \"" + w.origin + "\",";
  info[13] = "  \"dimensions\": [";
  info[14] = "    " + w.getDimensions();
  info[15] = "  ],";
  info[16] = "  \"persistent\": " + w.persistent;
  info[17] = "}";
  
  saveStrings("waypoints/" + fileName + ".json", info);
  savedWps ++;
}
