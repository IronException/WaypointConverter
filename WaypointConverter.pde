

public void setup(){
  size(280, 160);
  
  savedWps = 0;
  // TODO error screen
  //try{
    initStandardWaypoint();
    String[] dataFormat = initDataFormat();
    
    convertDataFile(dataFormat, loadStrings("waypoints.txt"));
    
    if(savedWps == 1){
      println("1 Waypoint is converted");
    } else {
      println(savedWps + " Waypoints are converted");
    }
    println("You can now add them to:");
    println("\t.minecraft/journeymap/data/mp/Minecraft~Server/waypoints");
    
    exit();
  /*} catch (Exception e){
    background(230, 0, 0);
    text("there is an ERROR", 0, 0, width, height / 2.0);
    println("there is an ERROR");
    text(e + "", 0, height / 2.0, width, height / 2.0);
    println(e);
    
  }*/
  
  
}

int savedWps;


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
  println(rV);
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
  
  /*
  println("DATAFRMAT");
  for(int i = 0; i < dataFormat.length; i ++){
    println(i + "]: " + dataFormat[i]);
  }
  println();*/
  
  for(int i = 0; i < data.length(); i ++){
    println(dataFormat[idF - 1] + " " + data.charAt(i));
    if(isEqual(data, i, dataFormat[idF])){
      println(dataFormat[idF - 1] + " " + data.substring(lastIndex, i));
      rV.set(dataFormat[idF - 1], data.substring(lastIndex, i));
      
      lastIndex = i + dataFormat[idF].length();
      i = lastIndex - 1; // i = lastIndex - 1;
      //lastIndex --; // remove
      
      idF += 2;
    }
  }
  
  
  return rV;
}



public void saveWaypoint(Waypoint w){
  String fileName = w.name + "_" + w.x + "," + w.y + "," + w.z;
  
  String[] info = new String[18];
  info[0] = "{";
  info[1] = "  \"id\": \"" + fileName + "\",";
  info[2] = "  \"name\": \"" + w.name + "\",";
  info[3] = "  \"icon\": \"" + w.icon + "\",";
  info[4] = "  \"x\": " + w.x + ",";
  info[5] = "  \"y\": " + w.y + ",";
  info[6] = "  \"z\": " + w.z + ",";
  info[7] = "  \"r\": " + (int) red(w.rgb) + ",";
  info[8] = "  \"g\": " + (int) green(w.rgb) + ",";
  info[9] = "  \"b\": " + (int) blue(w.rgb) + ",";
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

// TODO vvvvvvv


public void loadWaypoint(String[] data){
  
  
}


public void saveData(Waypoint w){
  
  
}
