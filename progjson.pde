//sup

import processing.data.*;

JSONObject[] jsonfiles = new JSONObject[2];
boolean typingStateShow = true;
String typingSearch = "";



void setup() {
  size(512, 512);
  
  //import 
  jsonfiles[0] = loadJSONObject("data/jsonfil1.json");
  jsonfiles[1] = loadJSONObject("data/jsonfil2.json");
  
  frameRate(15);
  
}

void draw() {
  background(255);
  nameInput();
  displaySearch();
  
}


ArrayList<String> search(String search) {
  ArrayList<String> results = new ArrayList<String>();
  for (JSONObject jsonfile : jsonfiles) {
    boolean found = false;
    ArrayList<String> strings = new ArrayList<String>() {{add(jsonfile.getString("fornavn")); add(jsonfile.getString("efternavn")); add(jsonfile.getString("studentID"));} };
    JSONArray fag = jsonfile.getJSONArray("fag");
    for (int i = 0; i < fag.size(); i++) {
      strings.add(fag.getString(i));
    }
    JSONArray telefonnumre = jsonfile.getJSONArray("telefonnumre");
    for (int i = 0; i < telefonnumre.size(); i++) {
      strings.add(telefonnumre.getJSONObject(i).getString("nummer"));
    }
    
    for (String string : strings) {
      if (search != "" && includes(string, search)) {
        found = true;
      }
    }
    if (found) {
      // results.add(jsonfile.toString());
      String[] temp = new String[strings.size()];
      for (int i = 0; i < strings.size(); i++) {
        temp[i] = strings.get(i);
      }
      results.add(join(temp, " "));
      
      
    }
  }
  return results;
}


void nameInput() {
  fill(0);
  textSize(32);
  String title = "Search";
  text(title, width / 2 - (textWidth(title) / 2), height / 10);
  textSize(20);
  if (typingStateShow) {
    text(typingSearch + "_", width / 2 - (textWidth(typingSearch) / 2),  200);
  } else {
    text(typingSearch, width / 2 - (textWidth(typingSearch) / 2), 200);
  }
  if (frameCount % 40 == 0) {
    typingStateShow = !typingStateShow;
  }
}

ArrayList<String> displayed = new ArrayList<String>();
void displaySearch() {
  int i = 0;
  for (String s : displayed) {
    println(s);
    //display on canvas
    text(s, width / 2 - (textWidth(s) / 2), 300 + i * 30);
    i++;
  }
  println("\n");
}

void keyPressed() {
  switch(key) {
    case BACKSPACE:
      if (typingSearch.length() > 0) {
        typingSearch = typingSearch.substring(0, typingSearch.length() - 1);
      }
      
      break;
    default:
    if ((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z') || (key == ' ') || (key >= '0' && key <= '9' && typingSearch.length() < 32)) {
      typingSearch += key;
    }
    break;
  }
  displayed = search(typingSearch);
}

boolean includes(String str, String search) {
  return str.toLowerCase().indexOf(search.toLowerCase()) != -1;
}

// Json Opgave
// Vihar arbejdede med Json fil som viste et eksempel på en student.Nu skal i bygge videre på den opgave.
// Ifår 2 json filer som i skal bruge i opgaven.I opgaven skal i lave et search bar, hvor det muligt at søge efter
// informationer om de 2 elever i json filen.
// Load de 2 json filer i jeres processing program, og brug en println for at se hvilke data i har med at gør.
//Derefter skal der laves et search bar hvor man kan søge efter, navn, efternavn og student ID.
//Resultatet kan entenvises ved at trykke et knap eller enter, eller ved live update hvor dan viser
//informationen mens man skriver.
//Som ekstra opgave fådit program til at søge efter adresse, telefonnummer og fag.Samt kan du også få dit
//program til at fx ændre informationer som telefon nr eller fag.