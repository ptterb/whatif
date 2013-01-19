import org.json.*;

PImage keanu;

// Search text for what if
String whatIfCall = "http://search.twitter.com/search.json?q=%22what%20if%22&rpp=1&result_type=recent";
	
String rawText = "";
String parsedText = "";

PFont font;

void setup(){
size(551,549);

keanu = loadImage("conspiracy-keanu.jpg");

font = loadFont("Impact-48.vlw");
textFont(font, 48);

}

void draw(){
	background(keanu);
	textAlign(CENTER);
        // First copy is the shadow
	fill(0);
	text(parsedText, width/2+2, 52);
        fill(255);
	text(parsedText, width/2, 50);

}

void loadJson(){

        // Load the JSON from the search results
	try {
			String rawJson = join(loadStrings(whatIfCall),'\n');
	JSONObject root = new JSONObject(rawJson);
	JSONArray results = root.getJSONArray("results");
	JSONObject result1 = results.getJSONObject(0);
	rawText = result1.getString("text");

	} catch (Exception e) {
		println("e: "+e);
	} 

        // Parse the results, strip out anything before the what if
	String whatText[] = rawText.toLowerCase().split("what if");
	println(whatText.length);
	println(join(whatText, "WHAT IF").toUpperCase());
	parsedText = "WHAT IF"+whatText[1].toUpperCase();
}

void mousePressed(){
	// Threading to not stop the main loop
	thread("loadJson");
}
